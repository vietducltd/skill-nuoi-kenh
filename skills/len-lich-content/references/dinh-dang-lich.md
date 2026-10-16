# Định dạng file lich-content.csv — "hợp đồng" giữa len-lich-content, viet-bai-hang-loat, tao-anh-bai-page, dang-bai-tu-dong

`lich-content.csv` là **nguồn dữ liệu chính** của cả chuỗi. len-lich-content tạo dòng,
viet-bai-hang-loat điền caption, tao-anh-bai-page điền ảnh, người dùng duyệt, dang-bai-tu-dong (script đăng qua
Zernio) đọc để hẹn giờ đăng. Vì có máy đọc, tên cột và giá trị phải đúng tuyệt
đối như dưới đây — đổi tên cột là script đăng bài bị hỏng.

## Quy tắc file

- Mã hoá UTF-8 có BOM (để Excel mở trực tiếp không lỗi dấu tiếng Việt;
  Google Sheets cũng đọc được).
- Phân cách bằng dấu phẩy. **Mọi ô đều bọc trong dấu ngoặc kép** `"..."`;
  dấu `"` bên trong nội dung viết thành `""`. Nội dung có xuống dòng (caption)
  vẫn hợp lệ khi nằm trong ngoặc kép.
- Dòng đầu là tên cột, giữ đúng thứ tự trong bảng dưới.
- Một dòng = một bài đăng trên một kênh.

## Các cột

| Cột | Ai điền | Giá trị | Ghi chú |
|---|---|---|---|
| `ma_bai` | len-lich-content | `B001`, `B002`... | Duy nhất, không đổi sau khi tạo — dang-bai-tu-dong dùng để cập nhật đúng dòng. Gia hạn tháng sau thì đánh số tiếp |
| `ngay` | len-lich-content | `YYYY-MM-DD` | |
| `thu` | len-lich-content | `Thứ 2`...`Thứ 7`, `Chủ nhật` | Tính bằng lệnh, không nhẩm |
| `gio` | len-lich-content | `HH:MM` (24 giờ) | Theo `mui_gio` trong hồ sơ |
| `kenh` | len-lich-content | `facebook` | Sau này thêm `instagram`, `threads`... |
| `tuan` | len-lich-content | `1`...`5` | Tuần thứ mấy của lịch |
| `tru_cot` | len-lich-content | Tên trụ cột đã đặt trong chiến lược | Viết y hệt tên trong `chien-luoc-content.md` |
| `giai_doan_pheu` | len-lich-content | `nhan-biet`, `can-nhac`, `chuyen-doi` | |
| `dinh_dang` | len-lich-content | `anh-don`, `album`, `video-ngan`, `bai-chu`, `livestream` | Chỉ dùng định dạng hồ sơ ghi là làm được |
| `series` | len-lich-content | Tên series hoặc để trống | VD "Thứ 3 hỏi đáp <chủ đề>" |
| `chu_de` | len-lich-content | 1 dòng | |
| `hook` | len-lich-content | Câu mở đầu nháp | viet-bai-hang-loat được phép viết lại cho hay hơn |
| `y_chinh` | len-lich-content | 1 câu: người đọc cần nhớ gì | |
| `cta` | len-lich-content | Hành động mong muốn | Bám `cta_chinh` của hồ sơ |
| `cong_thuc` | len-lich-content | `aida`, `pas`, `thong-bao`, `hook-value-cta`, `storytelling`, `bab`, `cau-hoi`, `danh-sach`, `faq` | Gợi ý cho viet-bai-hang-loat |
| `mo_ta_anh` | len-lich-content | Mô tả ảnh/video cần có | tao-anh-bai-page dùng để tạo ảnh |
| `caption` | viet-bai-hang-loat | Nội dung bài hoàn chỉnh | len-lich-content để trống |
| `hashtag` | viet-bai-hang-loat | `#A #B #C` | len-lich-content để trống |
| `file_anh` | tao-anh-bai-page / người dùng | Đường dẫn ảnh/video trên máy, tính từ thư mục thương hiệu (VD `anh/B001.png`), hoặc link công khai; nhiều ảnh (album) cách nhau bằng dấu gạch đứng `\|` | dang-bai-tu-dong tự tải file trên máy lên Zernio. Bài `video-ngan`: 1 file video dọc |
| `trang_thai` | cả chuỗi + người dùng | xem bên dưới | |
| `link_bai` | dang-bai-tu-dong | Link bài trên Facebook | Điền khi bài đã lên page (dang-bai-tu-dong chế độ cập nhật) |
| `ghi_chu` | bất kỳ | Ghi chú tự do, lỗi đăng bài... | dang-bai-tu-dong ghi mã bài Zernio dạng `Zernio: <mã>` — không xoá, dang-bai-tu-dong cần để cập nhật và gỡ lịch |

## Vòng đời `trang_thai`

```
ke-hoach  →  cho-duyet  →  da-duyet  →  da-len-lich  →  da-dang
 (len-lich-content)      (viet-bai-hang-loat)     (NGƯỜI DÙNG)     (dang-bai-tu-dong)         (dang-bai-tu-dong)
                  ↑             │  ↑            │
                  └── can-sua ←─┘  └─ gỡ lịch ──┤
                                                └→ loi (sửa xong đặt lại da-duyet)
```

- `ke-hoach`: mới có ý tưởng, chưa có caption.
- `cho-duyet`: đã có caption, chờ người dùng đọc.
- `can-sua`: người dùng yêu cầu sửa (ghi lý do ở `ghi_chu`).
- `da-duyet`: **chỉ người dùng được đặt giá trị này.** dang-bai-tu-dong chỉ gửi dòng
  `da-duyet` — đây là chốt an toàn để không bài nào tự lên page khi chưa có
  người đọc.
- `da-len-lich`: dang-bai-tu-dong đã hẹn giờ thành công trên Zernio; Zernio tự đăng đúng
  giờ. Xem trên zernio.com (không hiện trong Meta Business Suite). Đổi giờ /
  huỷ: dang-bai-tu-dong gỡ lịch → dòng về `da-duyet`.
- `da-dang`: bài đã lên page, `link_bai` có link (dang-bai-tu-dong chế độ cập nhật).
- `dang-tay`: định dạng chưa đăng tự động được (livestream) — người dùng tự
  làm trên Facebook.
- `loi`: gửi thất bại, lý do ở `ghi_chu`. Sửa nguyên nhân rồi đặt lại
  `da-duyet` để gửi lại.
- `huy`: bỏ bài này.
