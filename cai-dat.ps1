# Cai (hoac cap nhat) bo skill nuoi kenh vao Claude tren Windows.
# Chay trong PowerShell:
#   irm https://raw.githubusercontent.com/vietducltd/skill-nuoi-kenh/main/cai-dat.ps1 | iex
# Chay lai lenh tren bat cu luc nao de cap nhat ban moi nhat.

# Chay trong khoi rieng (& { }) de bien cua script khong de len bien cua phien PowerShell dang mo
& {
    $ErrorActionPreference = "Stop"
    $repo = "vietducltd/skill-nuoi-kenh"
    $dich = if ($env:SKILL_NUOI_KENH_DICH) { $env:SKILL_NUOI_KENH_DICH } else { Join-Path $env:USERPROFILE ".claude\skills" }

    $tam = Join-Path $env:TEMP ("skill-nuoi-kenh-" + [guid]::NewGuid().ToString("N").Substring(0, 8))
    New-Item -ItemType Directory -Path $tam | Out-Null
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Write-Host "Dang tai bo skill tu github.com/$repo ..."
        $zip = Join-Path $tam "repo.zip"
        Invoke-WebRequest "https://github.com/$repo/archive/refs/heads/main.zip" -OutFile $zip -UseBasicParsing
        Expand-Archive $zip -DestinationPath $tam -Force
        $goc = Get-ChildItem $tam -Directory | Where-Object { Test-Path (Join-Path $_.FullName "skills") } | Select-Object -First 1
        if (-not $goc) { throw "Khong thay thu muc skills trong ban tai ve." }

        New-Item -ItemType Directory -Force -Path $dich | Out-Null
        # Ban dau bo skill dung ten co so (fb-04-..., fp-01-...). Hoc vien da cai ban do thi chuyen
        # cac thu muc ten cu sang skills-cu (khong xoa) de khong bi trung skill. May co du chuoi
        # skill danh so (co fb-01 hoac fp-06) la may cua nguoi soan skill: khong dong vao.
        $tenCu = @("fb-04-anh-quang-cao", "fp-01-ho-so-thuong-hieu", "fp-02-lich-content",
            "fp-03-viet-bai-hang-loat", "fp-04-tao-anh-bai-page", "fp-05-dang-tu-dong-zernio")
        $chuoiDu = (Test-Path (Join-Path $dich "fb-01-nghien-cuu-khach-hang")) -or (Test-Path (Join-Path $dich "fp-06-do-hieu-qua-page"))
        if (-not $chuoiDu) {
            $luu = Join-Path (Split-Path $dich -Parent) "skills-cu"
            foreach ($n in $tenCu) {
                $p = Join-Path $dich $n
                if (Test-Path $p) {
                    New-Item -ItemType Directory -Force -Path $luu | Out-Null
                    Move-Item $p (Join-Path $luu ($n + "-" + (Get-Date -Format "yyyyMMdd-HHmmss")))
                    Write-Host "  - $n (ten cu, da chuyen sang $luu)"
                }
            }
        }

        $ds = @(Get-ChildItem (Join-Path $goc.FullName "skills") -Directory)
        foreach ($s in $ds) {
            $d = Join-Path $dich $s.Name
            New-Item -ItemType Directory -Force -Path $d | Out-Null
            Copy-Item (Join-Path $s.FullName "*") $d -Recurse -Force
            Write-Host "  + $($s.Name)"
        }
        Write-Host ""
        Write-Host "Da cai $($ds.Count) skill vao $dich"
        Write-Host "Mo phien Claude moi de dung. Go thu: 'lap ho so thuong hieu' hoac 'lam anh quang cao'."
    } finally {
        Remove-Item $tam -Recurse -Force -ErrorAction SilentlyContinue
    }
}
