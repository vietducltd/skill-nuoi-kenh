# Bộ skill nuôi kênh và ảnh quảng cáo cho Claude

7 skill tiếng Việt dùng trong Claude (tab **Code** của app Claude, hoặc Claude Code):
làm ảnh quảng cáo Facebook, và nuôi fanpage từ A đến Z: hồ sơ thương hiệu → lịch
content → viết bài → ảnh, video → đăng tự động.

| Skill | Làm gì | Gõ để gọi |
|---|---|---|
| `tao-anh-quang-cao` | Ảnh quảng cáo từ ảnh sản phẩm thật. **Mặc định miễn phí:** Claude chọn phong cách hợp ngành và viết sẵn lệnh, bạn tạo ảnh trên ChatGPT/Gemini bản miễn phí rồi gửi lại để Claude soát; hoặc chèn chữ lên ảnh bạn chụp. Tạo tự động qua API OpenAI (tốn phí) chỉ khi bạn yêu cầu | "làm ảnh quảng cáo cho sản phẩm này" |
| `lap-ho-so-thuong-hieu` | Hồ sơ thương hiệu: sản phẩm, khách hàng, giọng văn, màu, font, từ cấm | "lập hồ sơ thương hiệu", "bắt đầu nuôi fanpage" |
| `len-lich-content` | Trụ cột nội dung và lịch đăng 30 ngày | "lên lịch content" |
| `viet-bai-hang-loat` | Viết caption cả tuần theo lịch, đúng giọng thương hiệu | "viết bài tuần này" |
| `tao-anh-bai-page` | Ảnh chữ, album cho bài page: 7 phong cách, 7 font tiếng Việt, màu và font chọn theo ngành. Video Reels hoạt hình theo 4 loại của [trang video mẫu](https://skillry.dev/ai-videos/opus-5-5): motion graphics, video giải thích, cảnh 3D, trò chơi. Miễn phí | "làm ảnh cho bài", "làm video cho bài" |
| `video-minh-hoa-doc` | Video hoạt hình dọc 9:16 có giọng đọc, phụ đề (Reels, TikTok) | "làm video dọc từ bài này" |
| `dang-bai-tu-dong` | Hẹn giờ đăng bài, ảnh, album, video lên fanpage qua Zernio | "bài đã duyệt rồi, đăng đi" |

Thứ tự nuôi kênh: **lap-ho-so-thuong-hieu → len-lich-content → viet-bai-hang-loat →
tao-anh-bai-page (ảnh) / video-minh-hoa-doc (video) → dang-bai-tu-dong**.
Làm một bài lẻ cũng được: dán bài vào chat rồi nhờ "làm ảnh cho bài này".

**Thiết kế hợp từng ngành.** Mỗi người bán một thứ khác nhau, nên các skill làm hình
không dùng một kiểu chung: Claude lấy màu từ logo, bao bì của bạn, xác định ngành và
phân khúc (bình dân / cao cấp), rồi đề xuất 2-3 phương án màu, font, bố cục, bối
cảnh để bạn chọn. Bảng gợi ý cho 17 ngành nằm ở
`skills/lap-ho-so-thuong-hieu/references/thiet-ke-theo-nganh.md`. Lập hồ sơ thương
hiệu trước thì phương án bạn chọn được lưu lại để mọi skill dùng chung.

**Khổ ảnh theo chỗ đăng.** Claude hỏi bạn đăng ở đâu rồi đề xuất khổ để bạn chọn
(một hay nhiều khổ): dọc 4:5 (bảng tin Facebook, Instagram), vuông 1:1 (Shopee,
Zalo, quảng cáo nhiều thẻ trượt), dọc dài 9:16 (Story, Reels), ngang 16:9 (YouTube,
website), ngang dẹt 1.91:1 (ảnh hiện khi chia sẻ link).

## Cài đặt (Windows)

**Cách 1 — nhờ Claude cài.** Mở app Claude, vào tab **Code**, chọn một thư mục làm
việc, rồi gõ:

> Cài giúp tôi bộ skill ở https://github.com/vietducltd/skill-nuoi-kenh

**Cách 2 — tự chạy một lệnh.** Mở **PowerShell** (bấm Start, gõ PowerShell), dán
lệnh sau rồi Enter:

```powershell
irm https://raw.githubusercontent.com/vietducltd/skill-nuoi-kenh/main/cai-dat.ps1 | iex
```

Lệnh tải 7 skill vào thư mục `C:\Users\<tên bạn>\.claude\skills\`. Xong thì **mở
phiên Claude mới** (đóng phiên đang mở, tạo phiên mới) là dùng được.

**Cập nhật bản mới:** chạy lại đúng lệnh ở cách 2 (hoặc nhắn Claude "cập nhật bộ
skill nuôi kênh"). Skill cùng tên được ghi đè bằng bản mới; bản cũ có tên đánh số
(`fb-04-...`, `fp-01-...`) do bộ này cài trước đây được chuyển sang thư mục
`.claude\skills-cu\` (không xoá) để không bị trùng skill.

**macOS / Linux:** `curl -fsSL https://raw.githubusercontent.com/vietducltd/skill-nuoi-kenh/main/cai-dat.sh | sh`.
Phần lớn script viết bằng PowerShell cho Windows; trên macOS cần cài PowerShell 7,
và phần chèn chữ của `tao-anh-quang-cao` chỉ chạy trên Windows.

**Dùng Claude Code bản dòng lệnh (CLI)?** Có thể cài dạng plugin thay cho cách 2
(đừng cài cả hai, sẽ bị trùng skill):

```
/plugin marketplace add https://github.com/vietducltd/skill-nuoi-kenh
/plugin install nuoi-kenh@litado-skills
```

Skill cài dạng plugin có tên kèm tiền tố, VD `/nuoi-kenh:viet-bai-hang-loat`.

## Cần chuẩn bị gì

| Skill | Cần có |
|---|---|
| Mọi skill | Máy Windows, app Claude (tab Code) hoặc Claude Code |
| `tao-anh-bai-page` | Ảnh: Chrome hoặc Edge (máy Windows có sẵn Edge). Video: Python 3.9+, playwright, ffmpeg (xem dưới) |
| `tao-anh-quang-cao` | Ảnh sản phẩm tự chụp hoặc tự lưu về máy; tài khoản ChatGPT (chatgpt.com) hoặc Gemini bản miễn phí. Khoá API OpenAI **chỉ cần nếu bạn muốn tạo tự động** — skill hỏi rõ lúc bắt đầu; không dùng API thì skill đi theo cách thủ công miễn phí |
| `dang-bai-tu-dong` | Tài khoản Zernio (miễn phí cho 2 fanpage) — skill hướng dẫn tạo và kết nối |
| `video-minh-hoa-doc` | Node.js 18+, ffmpeg, Python 3.9+ kèm numpy, Pillow, playwright, gTTS (xem dưới) |

Cài công cụ làm video (chạy trong PowerShell, mỗi dòng một lệnh):

```powershell
winget install OpenJS.NodeJS.LTS
winget install Gyan.FFmpeg
winget install Python.Python.3.12
pip install numpy pillow playwright gTTS
python -m playwright install chromium
```

Không quen dòng lệnh thì nhắn Claude: "kiểm tra và cài đủ công cụ làm video". Trên Windows, lệnh `python3` trong skill tương đương `python`.

## Lưu ý

- **Khoá API, mật khẩu: không bao giờ dán vào khung chat.** Các skill hướng dẫn tự
  lưu khoá vào file trên máy.
- Ảnh quảng cáo làm bằng AI phải soát chữ và bao bì từng ảnh trước khi chạy (skill
  tự soát và báo lỗi, nhưng người chạy quảng cáo vẫn nên xem lại).
- Skill không tự đăng hay bật quảng cáo khi chưa được bạn đồng ý.

---

### Dành cho Claude (khi người dùng nhờ cài từ link này)

Trên Windows, chạy lệnh PowerShell sau rồi báo người dùng mở phiên mới:

```powershell
irm https://raw.githubusercontent.com/vietducltd/skill-nuoi-kenh/main/cai-dat.ps1 | iex
```

Trên macOS / Linux: `curl -fsSL https://raw.githubusercontent.com/vietducltd/skill-nuoi-kenh/main/cai-dat.sh | sh`.
Lệnh chép các thư mục trong `skills/` vào `~/.claude/skills/` và chuyển các thư mục
tên cũ có đánh số mà bộ này từng cài sang `~/.claude/skills-cu/`, không chạy gì khác.
