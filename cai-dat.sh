#!/bin/sh
# Cai (hoac cap nhat) bo skill nuoi kenh vao Claude tren macOS / Linux.
#   curl -fsSL https://raw.githubusercontent.com/vietducltd/skill-nuoi-kenh/main/cai-dat.sh | sh
# Luu y: phan lon script trong bo skill la PowerShell (viet cho Windows). Tren macOS can cai
# PowerShell 7 (pwsh); chen-chu.ps1, soi-chu.ps1 cua tao-anh-quang-cao chi chay tren Windows.
set -e
REPO="vietducltd/skill-nuoi-kenh"
DICH="${SKILL_NUOI_KENH_DICH:-$HOME/.claude/skills}"
TAM=$(mktemp -d)
trap 'rm -rf "$TAM"' EXIT
echo "Dang tai bo skill tu github.com/$REPO ..."
curl -fsSL "https://github.com/$REPO/archive/refs/heads/main.tar.gz" | tar -xz -C "$TAM"
mkdir -p "$DICH"
# Ten cu co so do bo nay cai truoc day: chuyen sang skills-cu (khong xoa). May co du chuoi skill
# danh so (co fb-01 hoac fp-06) la may cua nguoi soan skill: khong dong vao.
if [ ! -d "$DICH/fb-01-nghien-cuu-khach-hang" ] && [ ! -d "$DICH/fp-06-do-hieu-qua-page" ]; then
  LUU="$(dirname "$DICH")/skills-cu"
  for n in fb-04-anh-quang-cao fp-01-ho-so-thuong-hieu fp-02-lich-content fp-03-viet-bai-hang-loat fp-04-tao-anh-bai-page fp-05-dang-tu-dong-zernio; do
    if [ -d "$DICH/$n" ]; then
      mkdir -p "$LUU"; mv "$DICH/$n" "$LUU/$n-$(date +%Y%m%d-%H%M%S)"
      echo "  - $n (ten cu, da chuyen sang $LUU)"
    fi
  done
fi
for s in "$TAM"/*/skills/*/; do
  n=$(basename "$s")
  mkdir -p "$DICH/$n"
  cp -R "$s". "$DICH/$n/"
  echo "  + $n"
done
echo "Da cai vao $DICH. Mo phien Claude moi de dung."
