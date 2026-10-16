# Cài Zernio để đăng bài Facebook (làm 1 lần)

Mất khoảng 10 phút. Người dùng tự bấm trong trình duyệt; Claude hướng dẫn từng
bước, chờ người dùng báo xong bước này mới sang bước sau. Giao diện Zernio bằng
tiếng Anh — ghi tên nút tiếng Anh trong ngoặc để người dùng tìm đúng.

## Cách hoạt động

```
Claude Code (dang-zernio.ps1)
   │ 1. tải ảnh/video trên máy lên Zernio
   │ 2. tạo bài hẹn giờ cho page
   ▼
Zernio giữ bài ──(đến giờ)──> đăng lên Facebook Page
   │
   └─ -CapNhat: hỏi Zernio bài đã đăng chưa → ghi da-dang + link bài vào CSV
```

Máy tính không cần bật lúc tới giờ đăng — Zernio đăng thay.

**Chi phí:** gói miễn phí của Zernio nối được **2 tài khoản mạng xã hội** (2
page Facebook), không giới hạn số bài. Từ tài khoản thứ 3 trở đi tính khoảng
$6/tài khoản/tháng (giá tại thời điểm viết, xem lại ở zernio.com/pricing).

## Chuẩn bị

- Tài khoản Facebook có **toàn quyền quản lý** fanpage.
- Đã có thư mục thương hiệu (chạy lap-ho-so-thuong-hieu trước) — file khoá nằm trong đó.

## Bước 1 — Tạo tài khoản Zernio

Vào https://zernio.com → **Sign up** (đăng ký bằng email hoặc Google). Không cần
thẻ thanh toán cho gói miễn phí.

## Bước 2 — Nối Facebook Page

1. Vào trang **Connections** (https://zernio.com/dashboard).
2. Ở thẻ **Facebook** bấm **+ Connect** → đăng nhập Facebook.
3. Khi Facebook hỏi, chọn **đúng fanpage** cần đăng và cho phép đủ quyền.
4. Quay lại Zernio, thấy page hiện trạng thái đã kết nối (connected) là xong.

## Bước 3 — Tạo khoá API

1. Vào **API keys** (https://zernio.com/dashboard/api-keys) → **Create API key**,
   đặt tên dễ nhớ, VD `dang-bai-tu-dong may-tinh-nha`.
2. **Sao chép khoá ngay** — Zernio chỉ hiện một lần. Khoá bắt đầu bằng `sk_`,
   dài 67 ký tự.

**Khoá này như mật khẩu**: ai có nó đều đăng được bài lên page. Không dán vào
khung chat với Claude, không gửi vào nhóm, không đưa lên Drive. Lỡ lộ: xoá khoá
đó trong trang API keys rồi tạo khoá mới.

## Bước 4 — Lưu khoá vào thư mục thương hiệu

Claude tạo file `<slug>/cau-hinh-dang-bai.env` với nội dung:

```
ZERNIO_API_KEY=DAN_KHOA_VAO_DAY
```

rồi đưa người dùng lệnh mở file (chạy trong PowerShell hoặc ô Run của Windows):

```
notepad "<đường dẫn đầy đủ tới>\cau-hinh-dang-bai.env"
```

Người dùng thay chữ `DAN_KHOA_VAO_DAY` bằng khoá vừa sao chép — **giữ nguyên
`ZERNIO_API_KEY=` phía trước**, không thêm dấu cách hay dấu ngoặc — bấm
**Ctrl+S** rồi đóng Notepad.

Đã có khoá ở thư mục thương hiệu khác (cùng tài khoản Zernio): chép nguyên file
`cau-hinh-dang-bai.env` sang, không cần tạo khoá mới.

Khi chia sẻ thư mục thương hiệu cho người khác, **bỏ file `.env` ra**.

## Bước 5 — Thử kết nối

Claude chạy:

```
powershell -ExecutionPolicy Bypass -File "<thư mục skill>/scripts/dang-zernio.ps1" -Csv "<slug>/lich-content.csv" -GuiThu -AnhThu "<một ảnh có sẵn>"
```

Script kiểm khoá, tìm page, tải ảnh thử lên, tạo một **bản nháp** trên Zernio
rồi xoá ngay. Không có gì lên page, CSV không đổi.

Kết quả đúng:

```
Khoá hợp lệ. Page: <tên page> (mã ...)
Tải ảnh thử lên Zernio: OK
Tạo bản nháp: OK (trạng thái draft)
Đã xoá bản nháp. KẾT NỐI SẴN SÀNG.
```

Kiểm tra tên page in ra đúng page của thương hiệu này. Sai page hoặc script báo
nhiều page → thêm dòng `ZERNIO_ACCOUNT_ID=<mã page đúng>` vào file `.env` (script
in sẵn danh sách tên page kèm mã), chạy thử lại.

## Lỗi thường gặp

| Hiện tượng | Nguyên nhân hay gặp | Cách xử lý |
|---|---|---|
| `CHƯA CÓ KHOÁ ZERNIO` | Chưa có file `.env`, hoặc còn chữ `DAN_KHOA_VAO_DAY` | Bước 4 |
| `khoá API sai hoặc đã bị thu hồi (401)` | Dán thiếu ký tự, mất chữ `ZERNIO_API_KEY=`, hoặc khoá đã bị xoá | Mở lại file `.env` kiểm tra; vẫn lỗi thì tạo khoá mới (Bước 3) |
| `chưa nối Facebook Page nào` | Bỏ sót Bước 2, hoặc nối nhầm Instagram | Bước 2 |
| `Zernio đang nối N page Facebook, phải chọn một` | Một tài khoản Zernio nối nhiều page | Thêm `ZERNIO_ACCOUNT_ID=<mã>` vào `.env` |
| `ZERNIO_ACCOUNT_ID ... không khớp page nào` | Page đã bị gỡ khỏi Zernio, hoặc chép sai mã | Xoá dòng đó rồi chạy `-GuiThu` để xem danh sách mã |
| `Zernio báo trùng (409)` | Cùng nội dung đã gửi cho page trong 24 giờ | Kiểm tra lịch trên zernio.com xem bài đã có chưa; có rồi thì không gửi lại |
| `gọi quá nhiều (429)` | Gửi dồn quá nhiều lệnh | Chờ vài phút rồi chạy lại |
| `tải file ... lên Zernio lỗi` | Mạng chập chờn, file quá nặng | Chạy lại; video nên dưới 1 GB, ảnh dưới 8 MB |
| `-CapNhat` báo đăng lỗi, lý do có chữ token / permission / session | Kết nối Facebook trong Zernio hết hạn (đổi mật khẩu Facebook, gỡ quyền app) | Trang Connections → nối lại page (Bước 2), rồi đặt lại `da-duyet` và gửi lại với giờ mới |
| `-CapNhat` báo đăng lỗi về định dạng ảnh/video | Ảnh hỏng, video Reel sai tỉ lệ (phải dọc 9:16) hoặc quá dài | Sửa file, đặt lại `da-duyet`, gửi lại |
| Bài lên nhầm page | `.env` của thư mục này trỏ page khác | Sửa `ZERNIO_ACCOUNT_ID`; xoá bài nhầm trên Facebook |

Xem tình trạng kết nối page: trang Connections trên zernio.com hiện cảnh báo khi
page cần nối lại.
