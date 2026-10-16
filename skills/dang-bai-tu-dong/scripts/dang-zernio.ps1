<#
dang-bai-tu-dong · Hẹn giờ đăng các bài đã duyệt trong lich-content.csv lên Facebook Page qua Zernio.

Cách dùng (chạy trong thư mục dự án):
  Kiểm tra (không gửi gì lên Zernio):
    powershell -ExecutionPolicy Bypass -File dang-zernio.ps1 -Csv "<slug>\lich-content.csv" -KiemTra
  Hẹn giờ các bài người dùng đã xác nhận:
    powershell -ExecutionPolicy Bypass -File dang-zernio.ps1 -Csv "<slug>\lich-content.csv" -MaBai B001,B002
  Cập nhật trạng thái các bài đã hẹn (đã đăng chưa, link bài, lỗi):
    powershell -ExecutionPolicy Bypass -File dang-zernio.ps1 -Csv "<slug>\lich-content.csv" -CapNhat
  Gỡ lịch bài đã hẹn (xoá khỏi Zernio, dòng CSV về da-duyet):
    powershell -ExecutionPolicy Bypass -File dang-zernio.ps1 -Csv "<slug>\lich-content.csv" -GoLich -MaBai B003
  Thử kết nối (tạo 1 bản nháp trên Zernio rồi xoá ngay, không lên page, không đụng CSV):
    powershell -ExecutionPolicy Bypass -File dang-zernio.ps1 -Csv "<slug>\lich-content.csv" -GuiThu [-AnhThu "anh\thu.png"]
  Khi thử script: -XemJson chỉ in dữ liệu sẽ gửi; -Nhap tạo bản NHÁP trên Zernio (không hẹn giờ,
  không lên page, không ghi CSV) và in mã nháp để xoá sau.

Khoá API đọc từ <thư mục thương hiệu>\cau-hinh-dang-bai.env (dòng ZERNIO_API_KEY=...),
hoặc biến môi trường ZERNIO_API_KEY. Nhiều page Facebook trong Zernio thì thêm dòng
ZERNIO_ACCOUNT_ID=... để chọn đúng page.

Chỉ bài trang_thai = da-duyet mới được gửi. Ảnh/video trong cột file_anh có thể là đường
dẫn trên máy (tương đối với thư mục thương hiệu) hoặc link công khai; nhiều file cách nhau bằng |.
Kết quả ghi lại vào CSV sau mỗi bài. Chạy được trên Windows PowerShell 5.1 và PowerShell 7.
#>
param(
    [Parameter(Mandatory = $true)] [string]$Csv,
    [string[]]$MaBai = @(),
    [string]$MuiGio = "Asia/Ho_Chi_Minh",
    [string]$UtcOffset = "+07:00",
    [switch]$KiemTra,
    [switch]$ChoPhepKhongAnh,
    [switch]$CapNhat,
    [switch]$GoLich,
    [switch]$GuiThu,
    [string]$AnhThu = "",
    [switch]$XemJson,
    [switch]$Nhap
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [Text.Encoding]::UTF8
try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch { }

$ApiBase = "https://zernio.com/api/v1"
$PhutToiThieu = 15          # giờ đăng phải cách hiện tại ít nhất chừng này phút
$NgayToiDa = 90             # xa hơn thì nghi gõ nhầm năm/tháng
$LoaiFile = @{
    ".jpg" = "image/jpeg"; ".jpeg" = "image/jpeg"; ".png" = "image/png"; ".webp" = "image/webp"; ".gif" = "image/gif"
    ".mp4" = "video/mp4"; ".mov" = "video/quicktime"; ".m4v" = "video/x-m4v"; ".webm" = "video/webm"
}

$Csv = (Resolve-Path $Csv).Path
$ThuMucThuongHieu = Split-Path -Parent $Csv
$Slug = Split-Path -Leaf $ThuMucThuongHieu

# ---------- Cấu hình: khoá API, tài khoản ----------
$ApiKey = ""
$AccountId = ""
$envFile = Join-Path $ThuMucThuongHieu "cau-hinh-dang-bai.env"
if (Test-Path $envFile) {
    foreach ($line in (Get-Content $envFile -Encoding UTF8)) {
        if ($line -match "^\s*ZERNIO_API_KEY\s*=\s*(\S+)") { $ApiKey = $Matches[1].Trim('"', "'") }
        if ($line -match "^\s*ZERNIO_ACCOUNT_ID\s*=\s*(\S+)") { $AccountId = $Matches[1].Trim('"', "'") }
    }
}
if ([string]::IsNullOrWhiteSpace($ApiKey) -and $env:ZERNIO_API_KEY) { $ApiKey = $env:ZERNIO_API_KEY }
if ($ApiKey -match "DAN_KHOA|DAN_API|xxxx") { $ApiKey = "" }   # còn chữ mẫu, chưa dán khoá thật

# -MaBai B001,B002 có thể đến dưới dạng một chuỗi khi gọi qua -File
$MaBai = @($MaBai | ForEach-Object { $_ -split "[,; ]+" } | Where-Object { $_ })

# ---------- Hàm gọi API ----------
function ConvertFrom-JsonAnToan([string]$text) {
    if ([string]::IsNullOrWhiteSpace($text)) { return $null }
    try { return ($text | ConvertFrom-Json) } catch { return $null }
}

function Invoke-Zernio([string]$Method, [string]$Path, $Body = $null, [string]$IdemKey = "") {
    $headers = @{ Authorization = "Bearer $script:ApiKey" }
    if ($IdemKey) { $headers["Idempotency-Key"] = $IdemKey }
    $p = @{ Method = $Method; Uri = "$script:ApiBase$Path"; Headers = $headers; UseBasicParsing = $true; TimeoutSec = 120; UserAgent = "dang-bai-tu-dong/1.0" }
    if ($null -ne $Body) {
        $p.Body = [Text.Encoding]::UTF8.GetBytes((ConvertTo-Json -InputObject $Body -Depth 10 -Compress))
        $p.ContentType = "application/json; charset=utf-8"
    }
    try {
        $resp = Invoke-WebRequest @p
        $text = [Text.Encoding]::UTF8.GetString($resp.RawContentStream.ToArray())
        return [pscustomobject]@{ ok = $true; code = [int]$resp.StatusCode; data = (ConvertFrom-JsonAnToan $text); text = $text }
    } catch {
        $code = 0
        try { $code = [int]$_.Exception.Response.StatusCode } catch { }
        $text = $_.ErrorDetails.Message
        if ([string]::IsNullOrWhiteSpace($text)) { $text = $_.Exception.Message }
        return [pscustomobject]@{ ok = $false; code = $code; data = (ConvertFrom-JsonAnToan $text); text = $text }
    }
}

function Get-LoiApi($r) {
    $msg = ""
    if ($r.data) {
        foreach ($k in @("error", "message", "detail")) { if ($r.data.$k) { $msg = [string]$r.data.$k; break } }
    }
    if (-not $msg) { $msg = $r.text }
    if ($msg.Length -gt 300) { $msg = $msg.Substring(0, 300) + "..." }
    switch ($r.code) {
        401 { return "khoá API sai hoặc đã bị thu hồi (401): $msg" }
        403 { return "khoá API không đủ quyền (403): $msg" }
        409 { return "Zernio báo trùng: nội dung này đã gửi cho page trong 24 giờ qua (409)" }
        429 { return "gọi quá nhiều, chờ vài phút rồi chạy lại (429)" }
    }
    if ($r.code -gt 0) { return "Zernio trả lỗi $($r.code): $msg" }
    return "không gọi được Zernio: $msg"
}

function Get-BaiTuPhanHoi($data) {
    if ($null -eq $data) { return $null }
    if ($data.post) { return $data.post }
    return $data
}

function Get-TaiKhoan {
    $r = Invoke-Zernio "GET" "/accounts?platform=facebook"
    if (-not $r.ok) { throw (Get-LoiApi $r) }
    $ds = @($r.data.accounts | Where-Object { $_.platform -eq "facebook" })
    if ($ds.Count -eq 0) { throw "tài khoản Zernio chưa nối Facebook Page nào — vào zernio.com nối page trước" }
    if ($script:AccountId) {
        $tk = $ds | Where-Object { $_._id -eq $script:AccountId } | Select-Object -First 1
        if (-not $tk) { throw "ZERNIO_ACCOUNT_ID trong cau-hinh-dang-bai.env không khớp page nào đã nối" }
        return $tk
    }
    if ($ds.Count -gt 1) {
        $dsTen = ($ds | ForEach-Object { "$($_.displayName) = $($_._id)" }) -join "; "
        throw "Zernio đang nối $($ds.Count) page Facebook, phải chọn một: thêm dòng ZERNIO_ACCOUNT_ID=<mã> vào cau-hinh-dang-bai.env. Các page: $dsTen"
    }
    return $ds[0]
}

function Get-TenPage($tk) {
    if ($tk.displayName) { return [string]$tk.displayName }
    return [string]$tk.username
}

function Send-FileLenZernio([string]$path, [string]$tenFile) {
    $ext = [IO.Path]::GetExtension($path).ToLower()
    $ct = $script:LoaiFile[$ext]
    $size = (Get-Item -LiteralPath $path).Length
    $r = Invoke-Zernio "POST" "/media/presign" @{ filename = $tenFile; contentType = $ct; size = $size }
    if (-not $r.ok -or -not $r.data.uploadUrl) { throw ("lấy chỗ tải file lỗi — " + (Get-LoiApi $r)) }
    try {
        Invoke-WebRequest -Method Put -Uri $r.data.uploadUrl -InFile $path -ContentType $ct -UseBasicParsing -TimeoutSec 900 | Out-Null
    } catch {
        throw "tải file $([IO.Path]::GetFileName($path)) lên Zernio lỗi: $($_.Exception.Message)"
    }
    return [string]$r.data.publicUrl
}

function Convert-AnhUrl([string]$u) {
    $u = $u.Trim()
    # Link chia sẻ Google Drive -> link tải trực tiếp
    if ($u -match "drive\.google\.com/file/d/([^/?#]+)") { return "https://drive.google.com/uc?export=download&id=$($Matches[1])" }
    if ($u -match "drive\.google\.com/open\?id=([^&#]+)") { return "https://drive.google.com/uc?export=download&id=$($Matches[1])" }
    return $u
}

function Get-KhoaChongTrung([string]$s) {
    # Cùng một bài (cùng nội dung, giờ, ảnh) gửi lại trong 24 giờ -> Zernio trả bài cũ, không tạo bài thứ hai
    $sha = [Security.Cryptography.SHA256]::Create()
    $b = $sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($s))
    $h = -join ($b[0..15] | ForEach-Object { $_.ToString("x2") })
    return "$($h.Substring(0,8))-$($h.Substring(8,4))-$($h.Substring(12,4))-$($h.Substring(16,4))-$($h.Substring(20,12))"
}

function Get-MaZernio($row) {
    $ms = [regex]::Matches([string]$row.ghi_chu, "(?i)zernio\D{0,15}([0-9a-f]{24})")
    if ($ms.Count -eq 0) { return "" }
    return $ms[$ms.Count - 1].Groups[1].Value
}

function Save-Csv($rows, [string]$path) {
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $rows | Export-Csv -Path $path -NoTypeInformation -Encoding utf8BOM -UseQuotes Always
    } else {
        $rows | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8
    }
}

function Add-GhiChu($row, [string]$text) {
    if ([string]::IsNullOrWhiteSpace($row.ghi_chu)) { $row.ghi_chu = $text }
    else { $row.ghi_chu = "$($row.ghi_chu) | $text" }
}

function Exit-NeuChuaCoKhoa {
    if ([string]::IsNullOrWhiteSpace($script:ApiKey)) {
        Write-Output "CHƯA CÓ KHOÁ ZERNIO: mở $script:envFile, dán khoá vào dòng ZERNIO_API_KEY=... rồi lưu."
        exit 1
    }
}

# ---------- Chế độ thử kết nối: nháp trên Zernio rồi xoá, không lên page ----------
if ($GuiThu) {
    Exit-NeuChuaCoKhoa
    try { $tk = Get-TaiKhoan } catch { Write-Output "LỖI: $($_.Exception.Message)"; exit 1 }
    Write-Output "Khoá hợp lệ. Page: $(Get-TenPage $tk) (mã $($tk._id))"
    $body = @{
        content   = "Bài thử kết nối dang-bai-tu-dong — bản nháp, sẽ bị xoá ngay."
        platforms = @(@{ platform = "facebook"; accountId = $tk._id })
        isDraft   = $true
    }
    if ($AnhThu) {
        $duongDan = $AnhThu
        if (-not [IO.Path]::IsPathRooted($duongDan)) { $duongDan = Join-Path $ThuMucThuongHieu $duongDan }
        if (-not (Test-Path -LiteralPath $duongDan)) { Write-Output "LỖI: không thấy file $AnhThu"; exit 1 }
        try { $url = Send-FileLenZernio $duongDan "$Slug-thu-ket-noi$([IO.Path]::GetExtension($duongDan).ToLower())" }
        catch { Write-Output "LỖI: $($_.Exception.Message)"; exit 1 }
        Write-Output "Tải ảnh thử lên Zernio: OK"
        $body.mediaItems = @(@{ type = "image"; url = $url })
    }
    $r = Invoke-Zernio "POST" "/posts" $body
    if (-not $r.ok) { Write-Output "LỖI khi tạo bản nháp: $(Get-LoiApi $r)"; exit 1 }
    $bai = Get-BaiTuPhanHoi $r.data
    Write-Output "Tạo bản nháp: OK (trạng thái $($bai.status))"
    $x = Invoke-Zernio "DELETE" "/posts/$($bai._id)"
    if ($x.ok) { Write-Output "Đã xoá bản nháp. KẾT NỐI SẴN SÀNG." }
    else { Write-Output "Kết nối chạy được nhưng chưa xoá được bản nháp ($(Get-LoiApi $x)) — xoá tay trong zernio.com, mục Posts." }
    exit 0
}

$rows = @(Import-Csv -Path $Csv -Encoding UTF8)
$now = [DateTimeOffset]::Now
$thoiDiem = (Get-Date).ToString("yyyy-MM-dd HH:mm")

# ---------- Cập nhật trạng thái các bài đã hẹn ----------
if ($CapNhat) {
    Exit-NeuChuaCoKhoa
    $doi = 0
    foreach ($r in $rows) {
        if ($r.trang_thai -ne "da-len-lich") { continue }
        if ($MaBai.Count -gt 0 -and $MaBai -notcontains $r.ma_bai) { continue }
        $ma = Get-MaZernio $r
        if (-not $ma) { Write-Output "$($r.ma_bai): không có mã bài Zernio trong ghi_chu — bỏ qua"; continue }
        $g = Invoke-Zernio "GET" "/posts/$ma"
        if (-not $g.ok) {
            if ($g.code -eq 404) {
                $r.trang_thai = "loi"; Add-GhiChu $r "Không còn bài trên Zernio ($thoiDiem) — có thể đã bị xoá"; $doi++
                Write-Output "$($r.ma_bai): không còn trên Zernio -> loi"
            } else { Write-Output "$($r.ma_bai): $(Get-LoiApi $g)" }
            continue
        }
        $bai = Get-BaiTuPhanHoi $g.data
        $pf = @($bai.platforms)[0]
        switch ($bai.status) {
            "published" {
                $r.trang_thai = "da-dang"
                if ($pf.platformPostUrl) { $r.link_bai = [string]$pf.platformPostUrl }
                Add-GhiChu $r "Đã đăng (kiểm lúc $thoiDiem)"; $doi++
                Write-Output "$($r.ma_bai): đã đăng -> $($r.link_bai)"
            }
            { $_ -in @("failed", "partial") } {
                $lyDo = [string]$pf.errorMessage
                if (-not $lyDo) { $lyDo = "không rõ lý do" }
                $r.trang_thai = "loi"; Add-GhiChu $r "Đăng lỗi ($thoiDiem): $lyDo"; $doi++
                Write-Output "$($r.ma_bai): LỖI khi đăng — $lyDo"
            }
            "cancelled" {
                $r.trang_thai = "loi"; Add-GhiChu $r "Bài bị huỷ trên Zernio ($thoiDiem)"; $doi++
                Write-Output "$($r.ma_bai): bị huỷ trên Zernio -> loi"
            }
            default { Write-Output "$($r.ma_bai): $($bai.status) — chưa tới giờ đăng ($($r.ngay) $($r.gio))" }
        }
    }
    if ($doi -gt 0) { Save-Csv $rows $Csv; Write-Output ""; Write-Output "Đã cập nhật $doi dòng: $Csv" }
    else { Write-Output "Không có dòng nào đổi trạng thái." }
    exit 0
}

# ---------- Gỡ lịch bài đã hẹn ----------
if ($GoLich) {
    Exit-NeuChuaCoKhoa
    if ($MaBai.Count -eq 0) { Write-Output "Gỡ lịch phải kèm -MaBai (VD -MaBai B003)."; exit 1 }
    $doi = 0
    foreach ($m in $MaBai) {
        $r = $rows | Where-Object { $_.ma_bai -eq $m } | Select-Object -First 1
        if (-not $r) { Write-Output "${m}: không có trong CSV"; continue }
        if ($r.trang_thai -ne "da-len-lich") { Write-Output "${m}: đang là '$($r.trang_thai)', không phải bài đã hẹn — bỏ qua"; continue }
        $ma = Get-MaZernio $r
        if (-not $ma) { Write-Output "${m}: không có mã bài Zernio trong ghi_chu — gỡ tay trong zernio.com"; continue }
        $x = Invoke-Zernio "DELETE" "/posts/$ma"
        if ($x.ok -or $x.code -eq 404) {
            $r.trang_thai = "da-duyet"; $r.link_bai = ""
            Add-GhiChu $r "Đã gỡ lịch, xoá bài khỏi Zernio ($thoiDiem)"; $doi++
            Write-Output "${m}: đã gỡ lịch -> da-duyet (sửa giờ/nội dung rồi gửi lại, hoặc đặt huy)"
        } else {
            Write-Output "${m}: không gỡ được — $(Get-LoiApi $x) (bài đã đăng thì không gỡ lịch được, phải xoá trên Facebook)"
        }
    }
    if ($doi -gt 0) { Save-Csv $rows $Csv; Write-Output "Đã cập nhật: $Csv" }
    exit 0
}

# ---------- Kiểm tra các bài da-duyet ----------
$ketQua = @()
$hopLe = @()

foreach ($r in $rows) {
    if ($r.trang_thai -ne "da-duyet") { continue }
    if ($MaBai.Count -gt 0 -and $MaBai -notcontains $r.ma_bai) { continue }

    $loi = @()
    $tep = @()          # @{ loai = image|video; file = <đường dẫn> hoặc url = <link> }
    $thoiGian = $null

    if ($r.kenh -ne "facebook") { $loi += "kênh '$($r.kenh)' chưa hỗ trợ" }
    if ([string]::IsNullOrWhiteSpace($r.caption)) { $loi += "caption trống" }
    if ($r.caption -match "\[CHÈN") { $loi += "caption còn [CHÈN]" }
    if ($r.dinh_dang -eq "livestream") { $loi += "livestream phải làm tay" }

    try {
        $thoiGian = [DateTimeOffset]::Parse("$($r.ngay)T$($r.gio):00$UtcOffset")
        $phut = ($thoiGian - $now).TotalMinutes
        if ($phut -lt $PhutToiThieu) { $loi += "giờ đăng đã qua hoặc còn dưới $PhutToiThieu phút (Zernio sẽ đăng NGAY nếu giờ đã qua)" }
        elseif ($phut -gt $NgayToiDa * 24 * 60) { $loi += "giờ đăng xa hơn $NgayToiDa ngày — kiểm lại ngày" }
    } catch { $loi += "ngày/giờ không đọc được" }

    if (-not [string]::IsNullOrWhiteSpace($r.file_anh)) {
        foreach ($u in ($r.file_anh -split "\|")) {
            $u = $u.Trim()
            if (-not $u) { continue }
            if ($u -match "^https?://") {
                $loaiUrl = "image"
                if ($r.dinh_dang -eq "video-ngan" -or $u -match "\.(mp4|mov|m4v|webm)(\?|$)") { $loaiUrl = "video" }
                $tep += @{ loai = $loaiUrl; url = (Convert-AnhUrl $u) }
                continue
            }
            $duongDan = $u
            if (-not [IO.Path]::IsPathRooted($duongDan)) { $duongDan = Join-Path $ThuMucThuongHieu $duongDan }
            if (-not (Test-Path -LiteralPath $duongDan)) { $loi += "không thấy file '$u'"; continue }
            $ext = [IO.Path]::GetExtension($duongDan).ToLower()
            if (-not $LoaiFile.ContainsKey($ext)) { $loi += "file '$u' không phải ảnh/video hỗ trợ (jpg, png, webp, gif, mp4, mov)"; continue }
            $loaiTep = "image"
            if ($LoaiFile[$ext] -like "video/*") { $loaiTep = "video" }
            $tep += @{ loai = $loaiTep; file = $duongDan }
        }
    }
    $soAnh = @($tep | Where-Object { $_.loai -eq "image" }).Count
    $soVideo = @($tep | Where-Object { $_.loai -eq "video" }).Count

    if ($soAnh -gt 0 -and $soVideo -gt 0) { $loi += "Facebook không cho trộn ảnh và video trong một bài" }
    if ($soVideo -gt 1) { $loi += "mỗi bài chỉ 1 video" }
    if ($soAnh -gt 10) { $loi += "quá 10 ảnh" }
    if ($r.dinh_dang -eq "video-ngan" -and $soVideo -eq 0) { $loi += "bài video-ngan chưa có file video" }
    if ($r.dinh_dang -in @("anh-don", "album") -and $soVideo -gt 0) { $loi += "bài $($r.dinh_dang) lại có file video — sửa dinh_dang hoặc file_anh" }
    if ($r.dinh_dang -in @("anh-don", "album") -and $soAnh -eq 0 -and -not $ChoPhepKhongAnh) { $loi += "bài $($r.dinh_dang) chưa có ảnh trong file_anh" }
    if ($r.dinh_dang -eq "anh-don" -and $soAnh -gt 1) { $loi += "bài anh-don lại có $soAnh ảnh — đăng sẽ thành album; đổi dinh_dang sang album (hỏi người duyệt) hoặc bớt ảnh" }

    $ghi = ""
    if (Get-MaZernio $r) { $ghi = " (đã từng gửi — xem ghi_chu, tránh trùng)" }
    $ketQua += [pscustomobject]@{
        ma_bai   = $r.ma_bai
        dang_luc = $(if ($thoiGian) { $thoiGian.ToString("dd/MM HH:mm") } else { "?" })
        tep      = $(if ($soVideo) { "1 video" } elseif ($soAnh) { "$soAnh ảnh" } else { "chữ" })
        kiem_tra = $(if ($loi.Count -eq 0) { "OK$ghi" } else { $loi -join "; " })
    }
    if ($loi.Count -eq 0) { $hopLe += [pscustomobject]@{ row = $r; tep = $tep; thoiGian = $thoiGian } }
}

if ($MaBai.Count -gt 0) {
    $timThay = @($ketQua | ForEach-Object { $_.ma_bai })
    foreach ($m in $MaBai) {
        if ($timThay -notcontains $m) {
            $ketQua += [pscustomobject]@{ ma_bai = $m; dang_luc = "-"; tep = "-"; kiem_tra = "không có trong CSV hoặc chưa ở trạng thái da-duyet" }
        }
    }
}

Write-Output "=== KIỂM TRA ==="
$ketQua | Format-Table -AutoSize -Wrap | Out-String -Width 220 | Write-Output
Write-Output "Hợp lệ để gửi: $($hopLe.Count) bài"

$tk = $null
if ([string]::IsNullOrWhiteSpace($ApiKey)) {
    Write-Output "Chưa có khoá Zernio trong $envFile — chưa gửi được (xem Chế độ cài đặt)."
    if ($KiemTra) { exit 0 } else { exit 1 }
}
try { $tk = Get-TaiKhoan } catch { Write-Output "LỖI KẾT NỐI ZERNIO: $($_.Exception.Message)"; exit 1 }
Write-Output "Page đích: $(Get-TenPage $tk)"

if ($KiemTra -or $hopLe.Count -eq 0) { exit 0 }

# ---------- Gửi ----------
Write-Output ""
Write-Output "=== HẸN GIỜ QUA ZERNIO ==="
foreach ($h in $hopLe) {
    $r = $h.row
    $noiDung = $r.caption.Trim()
    if (-not [string]::IsNullOrWhiteSpace($r.hashtag)) { $noiDung = "$noiDung`n`n$($r.hashtag.Trim())" }

    try {
        $media = @()
        $i = 0
        foreach ($t in $h.tep) {
            $i++
            if ($t.url) { $media += @{ type = $t.loai; url = $t.url }; continue }
            $ten = "$Slug-$($r.ma_bai)-$i$([IO.Path]::GetExtension($t.file).ToLower())"
            if ($XemJson) { $url = "https://media.zernio.com/temp/(chua-tai)-$ten" }
            else { $url = Send-FileLenZernio $t.file $ten }
            $media += @{ type = $t.loai; url = $url }
        }

        $nen = @{ platform = "facebook"; accountId = $tk._id }
        if ($r.dinh_dang -eq "video-ngan") { $nen.platformSpecificData = @{ contentType = "reel" } }
        $body = @{
            content      = $noiDung
            platforms    = @($nen)
            scheduledFor = $h.thoiGian.ToString("yyyy-MM-ddTHH:mm:ss")
            timezone     = $MuiGio
        }
        if ($media.Count -gt 0) { $body.mediaItems = @($media) }
        if ($Nhap) { $body.isDraft = $true }

        if ($XemJson) {
            Write-Output "--- $($r.ma_bai) (chỉ in, không gửi) ---"
            Write-Output (ConvertTo-Json -InputObject $body -Depth 10)
            continue
        }

        $soLanGo = [regex]::Matches([string]$r.ghi_chu, "Đã gỡ lịch").Count
        $khoa = Get-KhoaChongTrung "fp05|$Csv|$($r.ma_bai)|$($body.scheduledFor)|$noiDung|$($r.file_anh)|$soLanGo|$Nhap"
        $resp = Invoke-Zernio "POST" "/posts" $body $khoa
        if (-not $resp.ok) { throw (Get-LoiApi $resp) }
        $bai = Get-BaiTuPhanHoi $resp.data
        if ($resp.code -eq 200) {
            # 200 = Zernio trả lại bài đã tạo trước đó với cùng khoá chống trùng. Bài đó còn thì dùng luôn
            # (không tạo bài thứ hai); đã bị xoá thì tạo bài mới.
            $g = Invoke-Zernio "GET" "/posts/$($bai._id)"
            if (-not $g.ok) {
                $resp = Invoke-Zernio "POST" "/posts" $body (Get-KhoaChongTrung "$khoa|$((Get-Date).Ticks)")
                if (-not $resp.ok) { throw (Get-LoiApi $resp) }
                $bai = Get-BaiTuPhanHoi $resp.data
            } else { $bai = Get-BaiTuPhanHoi $g.data }
        }
        $pf = @($bai.platforms)[0]

        if ($Nhap) {
            Write-Output "$($r.ma_bai): bản nháp $($bai._id) (trạng thái $($bai.status), $($media.Count) tệp) — CSV không đổi"
            continue
        }
        if ($bai.status -eq "scheduled") {
            $r.trang_thai = "da-len-lich"
            Add-GhiChu $r "Zernio: $($bai._id) — đã hẹn giờ ($thoiDiem)"
            Write-Output "$($r.ma_bai): đã hẹn $($h.thoiGian.ToString('dd/MM HH:mm')) (Zernio $($bai._id))"
        } elseif ($bai.status -eq "published") {
            $r.trang_thai = "da-dang"
            if ($pf.platformPostUrl) { $r.link_bai = [string]$pf.platformPostUrl }
            Add-GhiChu $r "Zernio: $($bai._id) — đã đăng ngay ($thoiDiem)"
            Write-Output "$($r.ma_bai): ĐÃ ĐĂNG NGAY -> $($r.link_bai)"
        } else {
            $lyDo = [string]$pf.errorMessage
            if (-not $lyDo) { $lyDo = "trạng thái $($bai.status)" }
            $r.trang_thai = "loi"
            Add-GhiChu $r "Zernio: $($bai._id) — lỗi ($thoiDiem): $lyDo"
            Write-Output "$($r.ma_bai): LỖI — $lyDo"
        }
    } catch {
        $r.trang_thai = "loi"
        Add-GhiChu $r "Gửi lỗi ($thoiDiem): $($_.Exception.Message)"
        Write-Output "$($r.ma_bai): LỖI — $($_.Exception.Message)"
    }

    Save-Csv $rows $Csv
    Start-Sleep -Seconds 1
}

if (-not $XemJson -and -not $Nhap) { Write-Output ""; Write-Output "Đã cập nhật: $Csv" }
