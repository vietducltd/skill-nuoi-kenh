---
name: dang-bai-tu-dong
description: "Bộ skill nuôi fanpage: ĐĂNG TỰ ĐỘNG qua ZERNIO — hẹn giờ các bài đã duyệt (trang_thai da-duyet) trong lich-content.csv lên Facebook Page: bài chữ, ảnh đơn, album, video ngắn (Reel). Ảnh/video lấy thẳng từ máy, script tự tải lên, không cần Google Drive. Ghi kết quả vào CSV (da-len-lich + mã Zernio, hoặc loi + lý do), cập nhật bài đã đăng (da-dang + link bài), gỡ lịch bài đã hẹn để đổi giờ/huỷ. Có hướng dẫn tạo tài khoản Zernio (miễn phí cho 2 page), lưu khoá API, thử kết nối mà không đăng gì lên page, bảng xử lý lỗi. Luôn kiểm tra trước (bài còn [CHÈN], thiếu file, giờ đã qua) và xin xác nhận trước khi hẹn giờ. Dùng khi gõ \"/dang-bai-tu-dong\", \"đăng tự động\", \"hẹn giờ đăng\", \"lên lịch đăng bài lên page\", \"bài đã duyệt rồi, đăng đi\", \"cài Zernio\", \"kết nối Zernio với fanpage\", \"bài đăng chưa\", \"cập nhật link bài\", \"gỡ lịch bài\", \"huỷ bài đã hẹn\", \"đổi giờ bài đã hẹn\". KHÔNG dùng để viết/duyệt bài (viet-bai-hang-loat) hay chạy quảng cáo."
---

# Đăng tự động qua Zernio

Vị trí trong bộ skill nuôi fanpage:

```
lap-ho-so-thuong-hieu → len-lich-content → viet-bai-hang-loat + duyệt
→ tao-anh-bai-page (ảnh) / video-minh-hoa-doc (video) → [dang-bai-tu-dong: hẹn giờ đăng qua Zernio]
```

Cách hoạt động: script `scripts/dang-zernio.ps1` (trong thư mục skill này) đọc
`lich-content.csv`, tải ảnh/video trên máy lên Zernio, rồi tạo **từng bài đã
duyệt** thành bài hẹn giờ cho page. Zernio giữ bài và **tự đăng đúng giờ**.
Script ghi kết quả vào CSV ngay sau mỗi bài.

Bài hẹn qua Zernio **không hiện** trong Meta Business Suite → Lập kế hoạch.
Xem, sửa, xoá bài đã hẹn ở **zernio.com** (lịch đăng), hoặc bằng chế độ
`-GoLich` của script (cuối file).

Luôn gửi bằng script, không chép caption vào lời gọi công cụ MCP `zernio`:
script đọc caption thẳng từ CSV nên chữ trên page khớp từng ký tự với bản đã
duyệt. MCP `zernio` (nếu đã nối) chỉ dùng để xem lịch hoặc tra bài.

Đây là bước duy nhất trong chuỗi **đưa nội dung ra công khai**, nên có hai chốt
an toàn không được bỏ qua:
1. Chỉ bài `da-duyet` (do người dùng duyệt ở viet-bai-hang-loat) mới được xét.
2. Trước mỗi lần gửi, liệt kê đúng những bài sẽ gửi và **chờ người dùng xác nhận
   trong lượt đó**. Việc duyệt nội dung ở viet-bai-hang-loat không đồng nghĩa với đồng ý hẹn
   giờ đăng — người dùng có thể còn muốn đổi giờ, thêm ảnh.

| `dinh_dang` | Đăng thành | `file_anh` cần có |
|---|---|---|
| `bai-chu` | Bài chữ | Không |
| `anh-don` | Bài 1 ảnh | 1 ảnh (nhiều ảnh thì script chặn — đổi sang `album` sau khi hỏi người duyệt) |
| `album` | Bài nhiều ảnh | 2-10 ảnh, cách nhau bằng `\|` |
| `video-ngan` | Reel | 1 video dọc 9:16 (Zernio ghi Reel 3-60 giây) |
| `livestream` | Không tự đăng được | Đặt `dang-tay` |

`file_anh` là đường dẫn trên máy, tính từ thư mục thương hiệu (VD
`anh/B011.png`), hoặc link công khai. Ảnh: jpg, png, webp, gif. Video: mp4, mov.

**Giờ đăng phải sau hiện tại ít nhất 15 phút.** Zernio đăng **ngay lập tức**
nếu giờ hẹn đã qua, nên script chặn mọi bài có giờ đã qua hoặc quá sát. Giờ xa
hơn 90 ngày cũng bị chặn (thường là gõ nhầm năm/tháng).

Script chạy bằng PowerShell có sẵn trên Windows, không cần cài thêm. Trên
macOS cần cài PowerShell 7 (`brew install --cask powershell`) rồi dùng `pwsh`
thay cho `powershell`.

## Bước 0 — Đọc dữ liệu

- Hồ sơ `<slug>/ho-so-thuong-hieu.md`: tên page, `mui_gio`. Mặc định của script
  là `Asia/Ho_Chi_Minh` (+07:00); múi giờ khác thì thêm
  `-MuiGio "<tên múi giờ>" -UtcOffset "<+hh:mm>"` vào mọi lệnh.
- Lịch `<slug>/lich-content.csv` — định dạng cột và vòng đời trạng thái:
  `len-lich-content/references/dinh-dang-lich.md`.
- Khoá Zernio nằm trong `<slug>/cau-hinh-dang-bai.env` (dòng
  `ZERNIO_API_KEY=...`). **Không mở file này bằng Read, không in khoá ra chat,
  không đưa khoá vào lệnh** — script tự đọc. Script báo "CHƯA CÓ KHOÁ ZERNIO"
  hoặc "LỖI KẾT NỐI ZERNIO" → chuyển sang **Chế độ cài đặt** (dưới cùng).

Lệnh mẫu bên dưới viết tắt `<script>` cho
`powershell -ExecutionPolicy Bypass -File "<thư mục skill>/scripts/dang-zernio.ps1"`.

## Bước 1 — Kiểm tra (không gửi gì)

```
<script> -Csv "<slug>/lich-content.csv" -KiemTra
```

Thêm `-MaBai B001,B002` nếu người dùng chỉ định bài. Script xét mọi dòng
`da-duyet`, báo từng bài `OK` hoặc lý do bị chặn, rồi in **page đích** (tên page
đang nối trong Zernio):

| Lý do bị chặn | Cách xử lý đề xuất |
|---|---|
| caption còn `[CHÈN]` | Người dùng cung cấp dữ kiện → sửa bằng viet-bai-hang-loat, duyệt lại |
| chưa có ảnh / video | Hỏi file ảnh nằm đâu trên máy → ghi đường dẫn (tính từ thư mục thương hiệu) vào `file_anh`. Người dùng đồng ý đăng không ảnh → thêm `-ChoPhepKhongAnh` |
| không thấy file | Sai đường dẫn hoặc tên file → sửa `file_anh` |
| trộn ảnh và video / quá 10 ảnh / nhiều video | Tách thành nhiều bài, hoặc bớt file |
| livestream | Đề nghị đặt `trang_thai` = `dang-tay` |
| giờ đã qua / dưới 15 phút | Hỏi giờ mới → sửa `ngay`/`gio` (giữ `ma_bai`) |
| xa hơn 90 ngày | Kiểm lại ngày với người dùng |
| `đã từng gửi` (cột kiểm tra vẫn OK) | Dòng này từng có bài trên Zernio. Hỏi người dùng có chắc gửi lại không, tránh page đăng trùng |

Sửa CSV bằng Edit từng dòng (như viet-bai-hang-loat), không viết lại cả file.

## Bước 2 — Xin xác nhận

Trình bày bảng các bài **sẽ gửi**: mã · ngày giờ đăng · dòng đầu caption ·
số ảnh/video — và tên page đích script vừa in. Hỏi rõ: "Hẹn giờ N bài này lên
page <tên>?" Chỉ gửi khi người dùng đồng ý; chỉ gửi đúng các mã họ đồng ý.

## Bước 3 — Gửi

```
<script> -Csv "<slug>/lich-content.csv" -MaBai <các mã đã xác nhận>
```

Script gửi lần lượt từng bài, ghi CSV sau mỗi bài (bị ngắt giữa chừng thì các
bài đã gửi vẫn được ghi đúng). Nội dung đăng = `caption` + dòng trống +
`hashtag`. Mỗi bài kèm khoá chống trùng: chạy lại cùng lệnh trong 24 giờ không
tạo bài thứ hai trên page.

## Bước 4 — Báo kết quả

- Bài `da-len-lich`: liệt kê mã và giờ đăng. Mã bài Zernio nằm trong `ghi_chu`
  (dạng `Zernio: <mã>`) — đừng xoá, các chế độ `-CapNhat` và `-GoLich` cần nó.
  `link_bai` còn trống cho tới khi bài lên page.
- Bài `loi`: đọc lý do trong `ghi_chu`, đối chiếu bảng "Lỗi thường gặp" trong
  `references/cai-dat-zernio.md`, nói cách sửa. Sửa xong, **hỏi người dùng** rồi
  mới đặt lại `da-duyet` để gửi lại.
- Cập nhật dòng "Trạng thái:" trong `<slug>/bai-viet/tuan-N.md` cho khớp CSV.

## Sau giờ đăng — cập nhật trạng thái

Khi người dùng hỏi bài đã đăng chưa, hoặc mở lại phiên sau giờ đăng của các bài
`da-len-lich`, chạy (chỉ đọc từ Zernio, không cần xin phép):

```
<script> -Csv "<slug>/lich-content.csv" -CapNhat
```

- Bài đã lên page → `da-dang`, điền `link_bai`.
- Bài đăng lỗi → `loi`, lý do Facebook trả về ghi vào `ghi_chu`. Đối chiếu bảng
  lỗi để hướng dẫn sửa.
- Bài chưa tới giờ → giữ nguyên.

## Đổi giờ, sửa nội dung, huỷ bài đã hẹn

Gỡ lịch xoá bài đó khỏi Zernio và đưa dòng CSV về `da-duyet`. **Xin xác nhận
trước** (nói rõ mã bài và giờ đăng đang hẹn), rồi chạy:

```
<script> -Csv "<slug>/lich-content.csv" -GoLich -MaBai B003
```

Sau đó:
- **Đổi giờ** → sửa `ngay`/`gio`, làm lại Bước 1-3 cho bài đó.
- **Sửa nội dung** → sửa caption bằng viet-bai-hang-loat (bài về `cho-duyet`, người dùng
  duyệt lại), rồi Bước 1-3.
- **Huỷ** → đặt `trang_thai` = `huy`.

Bài đã lên page (`da-dang`) không gỡ lịch được: sửa hoặc xoá thẳng trên
Facebook. Nếu người dùng tự sửa/xoá bài trên zernio.com thì ghi lại thay đổi
đó vào CSV để lịch không lệch.

## Chế độ cài đặt (lần đầu cho mỗi thư mục thương hiệu)

Làm theo `references/cai-dat-zernio.md`, **từng bước một**, chờ người dùng báo
xong mới sang bước tiếp — họ đang bấm trong trình duyệt, không phải Claude.

1. Người dùng tạo tài khoản Zernio, nối Facebook Page, tạo khoá API.
2. Claude tạo `<slug>/cau-hinh-dang-bai.env` chỉ có dòng
   `ZERNIO_API_KEY=DAN_KHOA_VAO_DAY` rồi đưa người dùng lệnh mở file bằng
   Notepad để **tự dán khoá** thay chữ mẫu. Không bao giờ bảo người dùng dán
   khoá vào chat. Lỡ dán vào chat: khuyên xoá khoá đó trên zernio.com và tạo
   khoá mới.
3. Thử kết nối — tạo một bản nháp trên Zernio rồi xoá ngay, **không đăng gì lên
   page, không đụng CSV**, nên không cần xin phép:
   ```
   <script> -Csv "<slug>/lich-content.csv" -GuiThu
   ```
   Thêm `-AnhThu "<đường dẫn ảnh>"` để thử luôn khâu tải ảnh. Thấy
   `KẾT NỐI SẴN SÀNG` và đúng tên page = dùng được Bước 1-4.
4. Zernio nối nhiều page Facebook thì script báo danh sách page kèm mã: hỏi
   người dùng chọn page nào cho thương hiệu này, thêm dòng
   `ZERNIO_ACCOUNT_ID=<mã>` vào file `.env`.

Nhiều thư mục thương hiệu dùng chung một tài khoản Zernio: mỗi thư mục có file
`.env` riêng, cùng khoá; khác page thì khác `ZERNIO_ACCOUNT_ID`.
