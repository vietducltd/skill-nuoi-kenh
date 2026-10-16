param([string]$Csv, [string]$OutDir, [string]$ThuongHieu, [int[]]$Tuan, [string]$HookFile)
$ErrorActionPreference = "Stop"
$rows = @(Import-Csv $Csv -Encoding UTF8)
$hooks = @{}
foreach ($line in (Get-Content $HookFile -Encoding UTF8)) {
    if ($line -match "^(B\d+)\t(.+)$") { $hooks[$Matches[1]] = $Matches[2] }
}
foreach ($n in $Tuan) {
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine("# Bài viết tuần $n — $ThuongHieu")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("Cách duyệt: đọc từng bài, ghi góp ý ngay dưới dòng `"Góp ý:`" (để trống = ổn).")
    [void]$sb.AppendLine("Xong thì nói với Claude: `"sửa theo góp ý tuần $n`" hoặc `"duyệt B0xx, B0yy`".")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("---")
    foreach ($r in ($rows | Where-Object { [int]$_.tuan -eq $n })) {
        $d = [datetime]::ParseExact($r.ngay, "yyyy-MM-dd", $null).ToString("dd/MM")
        $series = if ($r.series) { " · series" } else { "" }
        $chen = $r.caption -match "\[CHÈN"
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("## $($r.ma_bai) · $($r.thu) $d · $($r.gio) · $($r.tru_cot)$series · $($r.cong_thuc)")
        [void]$sb.AppendLine("Trạng thái: $($r.trang_thai)$(if ($chen) { ' ⚠️ còn chỗ cần điền' })")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine($r.caption.Trim())
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine($r.hashtag)
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("Hook dự phòng: $($hooks[$r.ma_bai])")
        [void]$sb.AppendLine("Ảnh cần: $($r.mo_ta_anh -replace '^Cần tạo:\s*','')")
        [void]$sb.AppendLine("Ghi chú: $(if ($r.ghi_chu) { $r.ghi_chu } else { 'không' })")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("Góp ý:")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("---")
    }
    $path = Join-Path $OutDir "tuan-$n.md"
    [IO.File]::WriteAllText($path, $sb.ToString(), (New-Object System.Text.UTF8Encoding($false)))
    "Đã ghi $path"
}
