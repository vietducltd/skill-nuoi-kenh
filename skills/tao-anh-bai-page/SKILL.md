---
name: tao-anh-bai-page
description: "Bộ skill nuôi fanpage: TẠO ẢNH cho các bài trong lịch content — ảnh chữ nhiều khổ cho người dùng chọn (dọc 4:5 mặc định, vuông 1:1, Story 9:16, ngang 16:9, ảnh chia sẻ link 1.91:1) đúng màu, logo, chân ảnh của thương hiệu, dựng từ chính caption đã viết ở viet-bai-hang-loat: câu chốt, danh sách, con số lớn, so sánh, bảng 2 cột, câu hỏi A/B, trích dẫn, ảnh thật kèm chữ; album nhiều trang; 7 phong cách xen kẽ (tạp chí, sổ tay, bảng đen, pastel...). Chạy bằng Chrome/Edge có sẵn trên máy, không cần Python, không gọi API, không tốn phí. Script tự kiểm tra chữ tràn khung (tự thu nhỏ), chữ mồ côi, logo; Claude mở xem từng ảnh rồi ghi đường dẫn vào cột file_anh của lich-content.csv để dang-bai-tu-dong đăng. Bài 'ảnh thật' dùng ảnh người dùng đưa; bài video (video-ngan) thì làm video hoạt hình HTML theo 4 loại của trang mẫu skillry.dev/ai-videos/opus-5-5 (Motion graphics, Explainers, 3D scenes, Games) rồi quay thành MP4 dọc bằng scripts/quay-video.py, hoặc dùng video-minh-hoa-doc khi cần giọng đọc. Dùng khi gõ \"/tao-anh-bai-page\", \"làm ảnh cho bài\", \"tạo ảnh tuần này\", \"làm ảnh chữ\", \"thiết kế ảnh bài page\", \"ảnh cho lịch content\", \"làm lại ảnh B003\", \"đổi màu ảnh\", \"ảnh nhiều phong cách\", \"thêm logo vào ảnh\", \"bài này chưa có ảnh\", \"làm video cho bài\", \"kiểu video\". KHÔNG dùng cho ảnh quảng cáo từ ảnh sản phẩm (tao-anh-quang-cao) hay viết caption (viet-bai-hang-loat)."
---

# Tạo ảnh cho bài fanpage

Vị trí trong bộ skill nuôi fanpage:

```
lap-ho-so-thuong-hieu → len-lich-content → viet-bai-hang-loat
→ [tao-anh-bai-page (ảnh)] / video-minh-hoa-doc (video) → duyệt → dang-bai-tu-dong
```

Skill này làm **ảnh chữ**: tấm ảnh (mặc định dọc 1080×1350, chọn được khổ khác) có một câu chốt, một danh sách hay
một con số lấy từ chính bài viết, đặt trên nền màu thương hiệu, có logo và chân
ảnh. Đây là loại ảnh hợp nhất với bài kiến thức, câu chuyện, hỏi đáp trên page.

Ảnh được dựng từ HTML rồi chụp lại bằng Chrome hoặc Edge chạy ẩn
(`scripts/dung-anh.ps1`). Vì sao không dùng AI vẽ ảnh:
- **Chữ tiếng Việt đúng dấu 100%.** Model tạo ảnh hay viết sai dấu, sai chữ.
- **Không tốn phí, không cần khoá API.**
- **Cả page cùng một bộ nhận diện:** cùng logo, chân ảnh; người lướt nhận
  ra page sau vài bài.
- **Nhiều phong cách, không bị một màu:** 7 phong cách (`phong_cach`): mặc định
  theo màu thương hiệu, tạp chí, tương phản đen – vàng, sổ tay viết tay, bảng
  đen phấn trắng, tối giản, pastel. Font đi kèm skill, đủ dấu tiếng Việt.

Ảnh sản phẩm đẹp kiểu quảng cáo (cần dựng cảnh từ ảnh sản phẩm thật) là việc
của `tao-anh-quang-cao` (mặc định làm thủ công miễn phí trên ChatGPT) — chỉ gợi
ý khi người dùng muốn.

## Bước 0 — Đọc dữ liệu, chọn lô

1. Hồ sơ `<slug>/ho-so-thuong-hieu.md`:
   - mục 7 Nhận diện hình ảnh (màu, font, logo, phong cách, điều tránh);
   - mục 8 Tài nguyên có sẵn (ảnh thật, logo);
   - mục 3 giọng, mục 4 giới hạn (từ cấm, cam kết cấm dùng cho cả chữ trên ảnh).
2. Lịch `<slug>/lich-content.csv` (định dạng:
   `len-lich-content/references/dinh-dang-lich.md`). Lô mặc định: các bài
   **đã có caption** và **`file_anh` còn trống**, theo tuần viet-bai-hang-loat vừa viết.
   Người dùng chỉ định được (`tuần 2`, `B005-B008`, `làm lại ảnh B003`).
3. `<slug>/anh/thiet-ke.json` và `<slug>/anh/noi-dung-anh.json` nếu đã có (lần
   trước) — giữ bộ nhận diện cũ, viết tiếp vào file nội dung.

**Bài lẻ, chưa có hồ sơ và lịch:** người dùng chỉ đưa một bài viết (dán vào
chat hoặc file) thì vẫn làm được, không bắt chạy lap-ho-so-thuong-hieu, len-lich-content trước:
- Tạo thư mục thương hiệu `<slug>/` (tên thương hiệu viết không dấu, nối bằng
  `-`) ở thư mục đang mở, gồm `anh-goc/` (chép ảnh thật người dùng gửi), `bai-viet/` (lưu bài).
- Làm Bước 1 (hỏi một lần: màu, logo, chân ảnh, và một ảnh hay album), rồi
  Bước 2 với mã bài tự đặt `B001`, `B002`...
- Script chạy được khi không có `lich-content.csv`. Bỏ `-GhiCsv` ở Bước 5,
  vẫn dùng `-Xem`.
- Bài dài nhiều ý thì đề xuất album; bài ngắn một ý thì một ảnh.
- Cuối buổi gợi ý chạy lap-ho-so-thuong-hieu nếu người dùng sẽ làm đều đặn nhiều bài.

Chia các bài trong lô theo `dinh_dang` và `mo_ta_anh`:

| Bài | Làm gì |
|---|---|
| `anh-don`, `mo_ta_anh` ghi "cần tạo" / ảnh chữ | Ảnh chữ — Bước 2 |
| `album` | 3-6 trang ảnh chữ (trang bìa → các ý → trang kết), hoặc ảnh thật |
| `mo_ta_anh` ghi "ảnh thật: ..." | **Hỏi người dùng đường dẫn ảnh** (gom các bài vào một câu hỏi). Có ảnh: ghi thẳng vào `file_anh`, hoặc dùng mẫu `anh-nen` nếu muốn thêm chữ lên ảnh. Chưa có: đề nghị tạm làm ảnh chữ thay, hỏi trước |
| `video-ngan` | Đọc `references/kieu-video.md`, chọn cách dựng: **(A) video hoạt hình HTML** theo 4 loại của trang mẫu https://skillry.dev/ai-videos/opus-5-5 (Motion graphics, Explainers, 3D scenes, Games), Claude viết một file HTML rồi quay thành MP4 bằng `scripts/quay-video.py`; **(B) `video-minh-hoa-doc`** khi cần giọng đọc tiếng Việt. Không lặp cách thể hiện trong lô, ghi `Kiểu: ...` vào `mo_ta_anh`. Người dùng tự quay thì ghi đường dẫn mp4 vào `file_anh`. Đổi sang ảnh chữ chỉ khi người dùng đồng ý |
| `bai-chu`, `livestream` | Bỏ qua |
| Caption còn `[CHÈN: ...]` đúng chỗ ảnh cần (giá, số liệu) | Bỏ qua bài đó, báo cần gì |

## Bước 1 — Chốt bộ nhận diện (làm một lần cho mỗi thương hiệu)

Tạo `<slug>/anh/thiet-ke.json` từ mẫu `assets/thiet-ke-mau.json`:

| Trường | Ý nghĩa | Lấy từ |
|---|---|---|
| `mau_chinh` | Màu nền đậm, chữ nhấn trên nền sáng | Hồ sơ mục 7 |
| `mau_phu` | Màu nhấn trên nền đậm, nút số, gạch chân | Hồ sơ mục 7 |
| `mau_nen` | Nền sáng (kem, trắng ngà) | Tuỳ chọn; để trống thì script tự pha từ màu phụ |
| `font` | Font nội dung (và tiêu đề nếu không đặt `font_tieu_de`). 7 font kèm sẵn, đủ dấu tiếng Việt: `Be Vietnam Pro` (mặc định), `Montserrat`, `Noto Serif`, `Playfair Display`, `Nunito`, `Anton`, `Patrick Hand` | Hồ sơ mục 7; chưa có thì theo ngành (`thiet-ke-theo-nganh.md`) |
| `font_tieu_de` | Tuỳ chọn: font riêng cho tiêu đề, câu trích, con số. VD sang trọng: `Playfair Display` + `font` = `Be Vietnam Pro` | Như trên |
| `kho` | Khổ ảnh chính: `4x5` (bỏ trống), `1x1`, `9x16`, `16x9`, `1.91x1` | Người dùng chọn (bảng dưới) |
| `phong_cach` | Phong cách mặc định cả lô (`mac-dinh` nếu bỏ trống); từng bài vẫn đổi được | Xem `references/mau-anh.md` mục Phong cách |
| `ten_thuong_hieu` | Tên hiện ở chân ảnh khi chưa có logo | Hồ sơ |
| `chu_goc` | Chữ nhỏ góc trên phải (VD `<TÊN THƯƠNG HIỆU>` viết hoa) | Thường là tên thương hiệu |
| `logo` | Đường dẫn file logo, tính từ thư mục thương hiệu hoặc đường dẫn đầy đủ, **viết bằng dấu `/`** | Hồ sơ mục 7, mục 8 |
| `chan_dong_1`, `chan_dong_2` | Hai dòng chân ảnh bên phải (VD tên người đứng page; thương hiệu · sản phẩm) | Hỏi người dùng |

- **Thiết kế phải hợp ngành, phân khúc của từng người dùng** (học viên bán đủ
  thứ: thời trang, đồ chơi trẻ em, phòng gym, nha khoa...): màu, font, phong
  cách không dùng một bộ cho mọi ngành. Hồ sơ mục 7 đã có thì theo hồ sơ.
- Hồ sơ còn trống màu/font/logo (hoặc bài lẻ không có hồ sơ): đọc
  `../lap-ho-so-thuong-hieu/references/thiet-ke-theo-nganh.md` (tính từ thư
  mục skill này), lấy màu từ logo, bao bì, ảnh sản phẩm trước, rồi đề xuất
  **2-3 phương án khác hẳn nhau** hợp ngành và phân khúc (màu chính · nhấn ·
  nền, font tiêu đề + nội dung, phong cách mặc định), hỏi **một lần** gồm
  phương án, file logo (PNG nền trong suốt là đẹp nhất), chân ảnh. Chưa có
  logo vẫn làm được: chân ảnh hiện tên thương hiệu.
- Chốt xong thì ghi lại vào hồ sơ mục 7 (tăng `phien_ban`), để lần sau và các
  skill khác dùng chung.

**Khổ ảnh — đề xuất để người dùng chọn.** Hỏi người dùng đăng ở đâu (nếu chưa
nói), đề xuất khổ chính kèm một câu lý do, liệt kê các khổ còn lại để chọn thêm:

| Khổ | Kích thước | Hợp với |
|---|---|---|
| `4x5` (mặc định) | 1080×1350 dọc | Bài đăng bảng tin Facebook, Instagram: chiếm nhiều màn hình điện thoại nhất |
| `1x1` | 1080×1080 vuông | Bảng tin, Zalo, nhóm Facebook; bài ít chữ |
| `9x16` | 1080×1920 dọc dài | Story Facebook, Instagram, Zalo. Script tự chừa 14% trên, 20% dưới cho giao diện che |
| `16x9` | 1920×1080 ngang | Ảnh bìa video YouTube, bài website, slide |
| `1.91x1` | 1200×628 ngang dẹt | Ảnh hiện khi chia sẻ link bài blog, website |

- Khổ chính ghi vào `kho` của `thiet-ke.json`; không chọn thì `4x5`. Bài nào khác
  khổ chính thì đặt `kho` trong bài đó (`noi-dung-anh.json`).
- Cần thêm bản khổ khác cho vài bài (VD bản Story của bài vừa đăng) thì dựng
  thêm bằng `-Kho` ở Bước 3, không phải viết lại nội dung.
- Khổ vuông và khổ ngang ít chỗ hơn 4x5: viết ít chữ hơn (danh sách ≤ 4 mục,
  bỏ dòng phụ). Khổ ngang tự chia danh sách, lựa chọn thành 2 cột.

- **Lần đầu, dựng 1-2 ảnh mẫu cho người dùng xem trước** rồi mới làm cả lô:
  gu hình ảnh là chuyện của chủ page, sửa sớm đỡ phải dựng lại cả lô. Người
  dùng đã dặn "cứ làm" thì làm luôn.

## Bước 2 — Viết nội dung ảnh

Đọc `references/mau-anh.md` (các mẫu, trường JSON, ví dụ) và
`references/quy-tac-anh-chu.md` (chữ trên ảnh viết thế nào). Ghi vào
`<slug>/anh/noi-dung-anh.json`, mỗi bài một mục, dựa trên **caption đã viết**:

- Chọn mẫu hợp nội dung bài: câu chốt, danh sách, con số, so sánh, bảng 2 cột,
  câu hỏi A/B, trích dẫn, ảnh nền.
- Ảnh là **tóm tắt** caption: ít chữ, không thêm sự thật, con số hay lời hứa
  nào caption không có. Có con số thì thêm dòng `nguon`.
- Xen kẽ mẫu và nền sáng/đậm trong lô; không quá 2 ảnh liền nhau cùng mẫu.
- **Xen kẽ phong cách** (`phong_cach` trong từng bài): lô 10+ ảnh dùng 3-5 phong
  cách, 2 ảnh liền nhau trên page không cùng phong cách, mỗi phong cách hợp một
  kiểu bài (bảng `references/mau-anh.md`). **Chỉ xen kẽ trong các phong cách hợp
  ngành** (hồ sơ mục 7, hoặc cột "Phong cách tao-anh-bai-page" của `thiet-ke-theo-nganh.md`):
  VD trang sức cao cấp dùng toi-gian, mac-dinh đậm, không dùng bang-den, so-tay,
  tuong-phan; mẹ & bé dùng pastel, so-tay, mac-dinh sáng, không dùng tuong-phan
  nền đen. Giữ cùng logo, chân ảnh để page vẫn nhận ra được. Hồ sơ dặn chỉ một
  phong cách thì theo hồ sơ.
- Chủ động xuống dòng bằng `\n` cho câu ngắt đẹp; nhấn 1-2 cụm bằng `*...*`.
- `kicker` đừng lặp chữ của nhãn tròn (`nhan`, mặc định là tên trụ cột) — script tự bỏ kicker trùng y hệt.
- Ghi file JSON bằng công cụ ghi file (Write), không qua lệnh shell: `\n` phải là hai ký tự, shell hay đổi nó thành xuống dòng thật làm hỏng JSON.

## Bước 3 — Dựng ảnh

```
powershell -ExecutionPolicy Bypass -File "<thư mục skill>/scripts/dung-anh.ps1" -ThuMuc "<slug>"
```

Thêm `-MaBai B003,B005` để dựng lại vài bài. Ảnh ra ở `<slug>/anh/B001.png`
(album: `B004-1.png`, `B004-2.png`...); HTML gốc ở `<slug>/anh/html/`.
Khổ khác 4x5 thì tên có thêm đuôi khổ: `B001-1x1.png`, `B004-2-9x16.png`.
Dựng thêm bản khổ khác cho vài bài, bản chính giữ nguyên: `-MaBai B003 -Kho 9x16`.
Mỗi lần dựng khoảng 1 giây một ảnh.

Script tự kiểm tra từng ảnh và in `OK` hoặc `CẢNH BÁO`:
- **Chữ tràn khung:** script tự thu nhỏ chữ tối đa 25%, in "đã thu nhỏ còn
  N%". Dưới 90% là chữ đã quá nhiều → nên bớt chữ cho thoáng. Vẫn tràn → bắt
  buộc bớt.
- **Chữ mồ côi** (dòng cuối chỉ còn một chữ rớt xuống): thêm `\n` để
  ngắt sớm hơn, hoặc đổi chữ.
- **Logo / ảnh nền không tải được, font chưa nạp:** sửa đường dẫn, chạy lại.
- **Ảnh chụp mỗi lần một khác:** script chụp mỗi ảnh tới khi 2 lần liên tiếp
  giống hệt nhau (trình duyệt chạy ẩn đôi khi chụp lúc trang chưa vẽ xong:
  mất nửa logo, mảng màu lạ đè chân ảnh). Báo lỗi này thì chạy lại bài đó.

## Bước 4 — Mở xem từng ảnh

**Mở từng file PNG ra xem** (công cụ đọc ảnh), không chỉ tin dòng `OK` của
script. Script không thấy được những lỗi này:
- [ ] Dấu tiếng Việt đúng, không sai chính tả
- [ ] Câu ngắt dòng tự nhiên, cụm từ không bị tách đôi (tên riêng, con số với đơn vị)
- [ ] Chữ nhấn đúng ý chính, chỉ 1-2 cụm
- [ ] Ảnh khớp caption của bài (đúng con số, đúng ý)
- [ ] Không chữ nào đè lên nhau, đè logo, sát mép
- [ ] Ảnh nền (nếu có) không có logo thương hiệu khác, chữ vẫn đọc được

Sửa trong `noi-dung-anh.json` rồi dựng lại đúng bài đó (`-MaBai`).

## Bước 5 — Ghi vào lịch

```
powershell -ExecutionPolicy Bypass -File "<thư mục skill>/scripts/dung-anh.ps1" -ThuMuc "<slug>" -MaBai <các bài> -GhiCsv -Xem
```

- `-GhiCsv` ghi `file_anh` = `anh/B001.png` (album nối bằng `|`) cho các bài
  vừa dựng. Chỉ chạy `-GhiCsv` cho bản khổ chính; bản thêm bằng `-Kho`
  thì không ghi (sẽ đè đường dẫn bản chính). Script báo "LƯU Ý" khi số ảnh không khớp `dinh_dang` của lịch (VD
  lịch ghi `anh-don` mà làm album 3 trang): hỏi người duyệt đổi `dinh_dang`, vì
  dang-bai-tu-dong sẽ chặn bài `anh-don` có nhiều ảnh. Script không ghi đè `file_anh` do người dùng tự đặt (ảnh thật), và
  báo nếu bài đã `da-len-lich`/`da-dang`: ảnh mới chưa lên Zernio, muốn thay
  thì dang-bai-tu-dong gỡ lịch rồi hẹn lại.
- Bài ảnh thật: ghi đường dẫn người dùng đưa vào `file_anh` bằng **Edit** đúng
  dòng đó (giữ nguyên các cột khác), tính từ thư mục thương hiệu nếu ảnh nằm
  trong đó.
- `-Xem` tạo `<slug>/anh/xem-anh.html`: lưới mọi ảnh của lô kèm câu đầu caption,
  mở bằng trình duyệt để xem cả lô một lúc.
- Không đổi `trang_thai`: duyệt bài vẫn là việc của người dùng (viet-bai-hang-loat).

## Bước 6 — Trình bày

Trong chat:
- đường dẫn `xem-anh.html` và thư mục ảnh;
- bảng: mã bài · mẫu · nền · ghi chú (đã thu nhỏ chữ, ảnh thật, bỏ qua vì sao);
- bài nào chờ người dùng đưa ảnh thật/video;
- cách sửa: "B003 đổi nền đậm", "B005 chữ ngắn lại", "đổi màu chính sang
  #...", "thêm logo, file ở ..." → sửa JSON, dựng lại đúng bài;
- bước tiếp: người dùng duyệt bài kèm ảnh (`duyệt B001-B004`), rồi dang-bai-tu-dong hẹn
  giờ đăng.

Có công cụ gửi file cho người dùng thì gửi vài ảnh tiêu biểu hoặc
`xem-anh.html`.

## Lỗi thường gặp

| Hiện tượng | Cách xử lý |
|---|---|
| `không thấy Chrome hoặc Edge` | Cài Chrome, hoặc thêm `-TrinhDuyet "<đường dẫn chrome.exe>"` |
| `không đúng định dạng JSON` | Thường do đường dẫn có dấu `\` — viết lại bằng `/`; hoặc thiếu dấu phẩy, ngoặc |
| `không thấy file logo` | Sửa `logo` trong `thiet-ke.json`; đường dẫn tính từ thư mục thương hiệu |
| `chưa kiểm tra được` | Máy chậm: chạy lại đúng bài đó. Lặp lại nhiều lần → đóng bớt ứng dụng |
| Chữ bị thu nhỏ còn dưới 90% | Bớt chữ: rút gọn tiêu đề, bỏ dòng phụ, giảm số mục |
| Ảnh hiện font khác lạ | Font trong `thiet-ke.json` chưa cài trên máy → dùng `Be Vietnam Pro` |
| `-MaBai` không khớp bài nào | Mã bài trong `noi-dung-anh.json` phải trùng mã trong lịch |
