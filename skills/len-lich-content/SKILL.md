---
name: len-lich-content
description: "Bộ skill nuôi fanpage: từ hồ sơ thương hiệu (lap-ho-so-thuong-hieu) lên CHIẾN LƯỢC CONTENT và LỊCH ĐĂNG 30 NGÀY cho fanpage — gợi ý khoảng 10 trụ cột nội dung đặt tên theo thương hiệu để người dùng chọn 4-5, tỷ lệ theo giai đoạn page, series lặp hằng tuần, khung 4 tuần (làm quen → niềm tin → chứng minh → chốt), dịp lễ, rồi rải từng bài với ngày, giờ, trụ cột, phễu, định dạng, chủ đề, hook, CTA, công thức viết, mô tả ảnh. Xuất chien-luoc-content.md (người đọc) + lich-content.csv (máy đọc được, là nguồn dữ liệu cho viet-bai-hang-loat viết bài và dang-bai-tu-dong đăng tự động qua Zernio). Cũng dùng để GIA HẠN lịch tháng tiếp theo hoặc sửa lịch. Dùng khi gõ \"/len-lich-content\", \"lên lịch content\", \"lịch đăng bài\", \"kế hoạch content 30 ngày\", \"content plan\", \"trụ cột nội dung\", \"content pillar\", \"tháng này đăng gì\", \"lên kế hoạch nuôi page\" — kể cả khi người dùng chỉ hỏi \"page tôi nên đăng gì mỗi ngày\". KHÔNG dùng để viết caption hoàn chỉnh (viet-bai-hang-loat) hay 1 bài quảng cáo lẻ."
---

# Chiến lược & lịch content 30 ngày

Vị trí trong bộ skill nuôi fanpage:

```
lap-ho-so-thuong-hieu → [len-lich-content] → viet-bai-hang-loat
→ tao-anh-bai-page (ảnh) / video-minh-hoa-doc (video) → duyệt → dang-bai-tu-dong
```

Skill này trả lời câu hỏi "mỗi ngày đăng gì, vì sao". Đầu ra gồm 2 file
trong thư mục thương hiệu:

- `chien-luoc-content.md` — cho **người** đọc: trụ cột, tỷ lệ, series, khung
  4 tuần, bảng lịch xem nhanh.
- `lich-content.csv` — cho **máy và các bước sau**: mỗi dòng một bài, viet-bai-hang-loat
  điền caption, dang-bai-tu-dong đọc để hẹn giờ đăng qua Zernio. Định dạng chi tiết ở
  `references/dinh-dang-lich.md` — đọc file này trước khi ghi CSV, vì sai tên
  cột là kịch bản tự động của học viên bị hỏng.

Một lịch tốt không phải là 30 ý tưởng rời rạc, mà là một **kế hoạch có nhịp**:
người lướt page thấy được con người thật, học được điều có ích, tin dần,
rồi mới được mời mua. Mỗi dòng trong lịch phải cụ thể tới mức viet-bai-hang-loat viết
được ngay mà không phải đoán.

## Bước 0 — Đọc dữ liệu có sẵn

1. **Hồ sơ thương hiệu** `**/ho-so-thuong-hieu.md` — bắt buộc. Có nhiều thư
   mục thương hiệu thì hỏi làm cho thương hiệu nào. Chưa có hồ sơ thì đề
   nghị chạy `lap-ho-so-thuong-hieu` trước (khoảng 10 phút) — lịch dựng
   không có hồ sơ sẽ chung chung và các bước sau phải hỏi lại từ đầu.
   Từ hồ sơ lấy: `giai_doan_page`, `muc_tieu_chinh`, `so_bai_moi_tuan`,
   `khung_gio_dang`, `cta_chinh`, sản phẩm, điểm khác biệt, khách hàng, chất
   liệu Vấn đề–Mong muốn, giới hạn & từ cấm, định dạng làm được, nguồn lực,
   tài nguyên có sẵn, mục "Còn thiếu".
2. File nghiên cứu khách hàng người dùng có sẵn — thêm chất liệu cho hook.
3. File nghiên cứu đối thủ người dùng có sẵn — góc đối thủ chưa khai thác,
   hook đối thủ chạy lâu.
4. Số liệu, nhận xét về bài cũ của page mà người dùng đưa (bài nào nhiều tương
   tác, khung giờ nào tốt): trụ cột, góc viết, khung giờ NỔI thì tăng, YẾU thì
   giảm. Nói rõ trong chiến lược đã dùng nhận xét nào.
5. `<slug>/lich-content.csv` đã tồn tại → chuyển sang **Chế độ gia hạn / sửa
   lịch** (cuối file).

## Bước 1 — Hỏi những gì hồ sơ chưa có (một lượt)

Hầu hết thông tin đã nằm trong hồ sơ; chỉ hỏi phần thiếu, gộp vào một lượt
AskUserQuestion (tối đa 4 câu, phương án khuyên dùng đặt đầu):

- **Ngày bắt đầu lịch** — mặc định Thứ 2 tuần tới (đủ thời gian viết và
  duyệt tuần đầu).
- **Trong 30 ngày tới có gì đặc biệt?** — ưu đãi, ra mắt sản phẩm/lớp mới,
  sự kiện, ngày nghỉ không đăng. Có thì đó là "điểm neo" của cả lịch.
- **Series muốn có** — đề xuất 1-2 series hợp thương hiệu để người dùng chọn.
- Chỉ hỏi lại `so_bai_moi_tuan` nếu hồ sơ trống hoặc nguồn lực mâu thuẫn
  (VD 1 người làm mà đòi 14 bài/tuần).

Sau đó tự tra dịp lễ trong khoảng 30 ngày ở `references/ngay-le-dip.md`, chỉ
giữ dịp liên quan tới khách hàng của thương hiệu.

## Bước 2 — Gợi ý trụ cột cho người dùng chọn, rồi dựng chiến lược

Đọc `references/tru-cot-noi-dung.md` trước. Bước này có 2 điểm dừng: người
dùng **chọn trụ cột** (2a), rồi **xác nhận chiến lược** (2b).

### 2a. Gợi ý khoảng 10 trụ cột, người dùng chọn 4-5

Không tự chốt trụ cột thay người dùng. Chủ page biết mình có chất liệu gì và
thích nói về điều gì — trụ cột do họ chọn thì họ mới theo được cả tháng, và
đỡ phải sửa lại sau khi lịch đã rải xong.

**Dựng danh sách khoảng 10 ứng viên (8-12)**, đủ rộng để có cái mà chọn:

| Nhóm | Số ứng viên | Lấy từ đâu |
|---|---|---|
| Giá trị / kiến thức sát sản phẩm | 2-3 | Chất liệu Vấn đề–Mong muốn trong hồ sơ, "Gợi ý trụ cột theo ngành" |
| Mở rộng (khách quan tâm dù không định mua) | 3-4 | Mục "Trụ cột mở rộng", tra theo khách mục tiêu |
| Câu chuyện / hậu trường | 1-2 | Câu chuyện thương hiệu, tài nguyên thật trong hồ sơ |
| Bằng chứng | 1 | Feedback / case thật |
| Tương tác | 1 | |
| Bán hàng / ưu đãi | 0-1 | Bỏ nếu hồ sơ ghi "câu dẫn mềm cuối bài" (xem 2b) |

- Mỗi ứng viên quy về 1 trong 5 trụ cột gốc nhưng **đặt tên theo thương
  hiệu** (VD "Chuyện <tên thương hiệu>", "Hỏi nhanh đáp gọn về <vấn đề của
  khách>"). Tên riêng giúp học viên nhớ và giúp bài viết có cá tính.
- Các ứng viên phải khác nhau thật về nội dung, không phải hai cái tên cho
  cùng một loại bài.
- **Nhiều sản phẩm chính** (VD 2 khoá học khác mảng): mỗi sản phẩm có ít nhất
  một ứng viên kiến thức riêng mang đúng mảng của nó. Đừng gộp mảng của một
  sản phẩm vào trụ cột chung — gộp vào thì mảng đó chỉ còn vài bài, sản phẩm
  kia chiếm gần hết lịch, và người dùng phải nhắc lại.
- Trụ cột cần thứ hồ sơ chưa có (VD Bằng chứng khi feedback còn
  `[CẦN BỔ SUNG]`) vẫn đưa vào, nhưng ghi rõ điều kiện ở cột "Đăng gì".

**Trình bày** thành bảng đánh số ngay trong chat:

| # | Tên trụ cột | Loại | Đăng gì | Ví dụ 1 chủ đề | Khuyên chọn |
|---|---|---|---|---|---|

- "Loại" = trụ cột gốc, hoặc "Mở rộng".
- "Ví dụ 1 chủ đề" viết bằng chi tiết của chính thương hiệu này, để người
  dùng hình dung được bài thật trông ra sao.
- Đánh dấu ⭐ một **bộ 4-5 trụ cột khuyên chọn** và nói lý do trong 1-2 câu.
  Bộ khuyên chọn phải có 1-2 trụ cột mở rộng, và đủ trụ cột kiến thức cho
  từng sản phẩm chính.

Rồi hỏi người dùng chọn bằng cách **gõ số trong chat** (VD "1 3 4 7 9"), hoặc
gõ "theo đề xuất"; nói rõ họ có thể đổi tên hoặc thêm trụ cột của riêng mình.
Không dùng AskUserQuestion ở đây — mỗi câu chỉ chứa được 4 phương án, không
đủ cho 10 trụ cột.

**Khi người dùng đã chọn**, soát lại rồi mới đi tiếp. Gặp các trường hợp dưới
đây thì nói rõ hệ quả, gợi ý cách chỉnh, và làm theo quyết định cuối của họ:

- **Ít hơn 3 hoặc nhiều hơn 6 trụ cột** — ít thì page đơn điệu; nhiều thì mỗi
  trụ cột chỉ còn 1-2 bài/tháng, người theo dõi không nhận ra nhịp.
- **Không có trụ cột mở rộng nào** — lịch chỉ xoay quanh sản phẩm sẽ đọc như
  tờ rơi. Gợi ý thêm 1.
- **Một sản phẩm chính không có trụ cột kiến thức nào** — hỏi lại có chủ ý
  bỏ sản phẩm đó khỏi lịch tháng này không.
- **Thiếu hẳn Tương tác hoặc Câu chuyện** — nhắc một câu, không ép.

Nếu người dùng đã dặn "cứ làm luôn" thì dùng bộ khuyên chọn, vẫn in bảng ứng
viên trong chat và ghi trong chiến lược rằng trụ cột là do skill đề xuất.

### 2b. Dựng chiến lược từ các trụ cột đã chọn và xin xác nhận

1. **Tỷ lệ và số bài mỗi trụ cột**: lấy bảng tỷ lệ theo giai đoạn page, chỉnh
   theo mục tiêu, quy ra số bài cụ thể trong 30 ngày. Bảng tỷ lệ tính theo
   trụ cột gốc, nên quy đổi sang các trụ cột đã chọn — nhiều trụ cột cùng một
   gốc thì chia nhau phần của gốc đó; gốc nào không được chọn thì phần của nó
   dồn sang trụ cột đã chọn gần mục đích nhất. Trụ cột mở rộng tính riêng:
   page `moi` hoặc mục tiêu `nhan-dien`/`tuong-tac` thì khoảng 1/3 số bài trở
   lên thuộc chủ đề mở rộng. Nhiều sản phẩm chính thì số bài cân theo mức ưu
   tiên người dùng chọn.
2. **Cách dẫn về sản phẩm**: xem mục 6 hồ sơ —
   nếu là "câu dẫn mềm cuối bài" thì có thể bỏ hẳn trụ cột Bán hàng, và ghi
   vào `ghi_chu` từng bài có nội dung khớp sản phẩm nào ("câu dẫn: <sản phẩm>")
   để viet-bai-hang-loat gắn câu dẫn. **Ngoài câu dẫn đó, chỉ bài trụ cột Bán hàng mới nhắc
   tới sản phẩm/khoá học** (giá, lịch, ưu đãi, CTA mua). Bài các trụ cột khác không
   chào bán, không CTA về sản phẩm, không làm "cầu nối" dẫn sang bài bán — được
   nói về chủ đề gần sản phẩm nhưng phải có ích tự thân. Nếu người dùng muốn
   nhiều bài bán hơn mức khuyên, nói rõ hệ quả ("page sẽ đọc như tờ rơi, người
   mới theo dõi dễ bỏ") trước khi làm theo.
3. **1-2 series** lặp vào cùng một thứ trong tuần.
4. **Khung 4 tuần** (làm quen → niềm tin → chứng minh → chốt), xoay để tuần
   chốt trùng dịp lễ/ưu đãi nếu có.
5. **Bằng chứng thật**: đếm xem hồ sơ có bao nhiêu feedback/case thật. Bài
   Bằng chứng chỉ được dựa trên thứ có thật; nếu hồ sơ ghi feedback là
   `[CẦN BỔ SUNG]` thì vẫn xếp bài nhưng ghi `ghi_chu` "cần feedback thật từ
   chủ page" — tuyệt đối không để viet-bai-hang-loat phải bịa lời khách.

Trình bày chiến lược thật gọn (bảng các trụ cột đã chọn + số bài, series, chủ
đề 4 tuần) và hỏi "Ổn chưa hay muốn chỉnh gì?" trước khi rải chi tiết — sửa ở
bước này rẻ hơn nhiều so với sửa 20 dòng lịch. Nếu người dùng đã dặn "cứ làm
luôn", bỏ qua bước hỏi này.

## Bước 3 — Rải lịch

- **Số bài** = `so_bai_moi_tuan` × số tuần thực tế của 30 ngày (làm tròn).
- **Chọn ngày**: rải đều trong tuần; series cố định đúng thứ đã chọn.
- **Tính ngày và thứ bằng lệnh, không nhẩm** — nhẩm thứ trong tuần rất dễ sai
  và một ngày sai thứ làm hỏng cả series. VD Git Bash:
  `date -d 2026-10-01 +%u` (1 = Thứ 2 ... 7 = Chủ nhật); PowerShell:
  `(Get-Date '2026-10-01').DayOfWeek`.
- **Giờ**: lấy từ `khung_gio_dang`; bài tương tác và bài dài ưu tiên khung
  tối, bài ngắn ưu tiên khung trưa.
- Tuân theo "Quy tắc rải lịch" trong `references/tru-cot-noi-dung.md` (không 2
  bài bán liền nhau, bài bán đứng sau bài bằng chứng/giá trị cùng chủ đề...).

## Bước 4 — Viết nội dung cho từng dòng

Mỗi dòng điền đủ các cột của len-lich-content (xem `references/dinh-dang-lich.md`):

- **chu_de**: cụ thể, không trùng trong tháng. Dùng "30 dạng chủ đề" để đa
  dạng.
- **hook**: câu mở đầu nháp **viết bằng chi tiết của chính thương hiệu này**
  — lấy từ chất liệu Vấn đề–Mong muốn, câu chuyện, con số trong hồ sơ. Đổi
  kiểu hook liên tục ("12 kiểu hook"). Hook phải qua được phép thử: thay tên
  thương hiệu khác vào mà vẫn đúng → quá chung, viết lại.
- **y_chinh**: một câu — đọc xong người xem nhớ gì. Không đưa con số, tỷ lệ
  hay sự kiện không có trong hồ sơ vào `hook` / `y_chinh` (VD tự thêm "<một
  nửa khách hàng> ..." khi hồ sơ không có số này) — viet-bai-hang-loat sẽ viết
  theo như sự thật.
- **cta**: bám `cta_chinh`; bài giá trị/tương tác dùng CTA nhẹ (bình luận,
  lưu bài, theo dõi), bài bán dùng CTA rõ.
- **cong_thuc**: gợi ý công thức cho viet-bai-hang-loat theo bảng trụ cột gốc. Bài bán ở
  page mới nên dùng `thong-bao` (thông báo nhẹ) thay vì `aida`.
- **Góc gợi ý**: bài nội dung ở viet-bai-hang-loat = khung kiến thức của chủ page + một
  góc viết (case thật, tình huống ai cũng gặp, các kiểu người, đối thoại, lật
  hiểu lầm, so sánh, quan điểm, lá thư, mùa vụ, hậu trường, thử thách, ẩn dụ —
  menu ở `viet-bai-hang-loat/references/goc-viet.md`). Với mỗi bài nội
  dung, ghi vào `ghi_chu` `Góc gợi ý: <đúng tên một góc trong menu>` hợp với chủ đề (ghi chú thêm để sau dấu `|`, giữ đúng tên góc để sau này so góc nào hiệu quả); mỗi tuần không
  quá 2 bài cùng góc, case thật khoảng 1/3 số bài nội dung trở xuống (trừ khi
  người dùng muốn nhiều hơn). Rải góc để `hook` cũng đổi kiểu theo.
- **Chỗ cho bài trend**: mỗi tuần giữ 1-2 dòng `chu_de` = "Bài trend — viet-bai-hang-loat
  chọn khi viết", `hook` / `y_chinh` để "viet-bai-hang-loat điền". Trend sống vài ngày
  nên không đoán trước cả tháng; viet-bai-hang-loat sẽ đọc khoảng 10 bài báo mới nhất lúc
  viết lô (`viet-bai-hang-loat/references/trend-bao-chi.md`).
- **Case gợi ý** (chỉ bài góc case thật): thêm `Case gợi ý: <tên case, 1 câu>`
  nối được với `y_chinh` — xen case Việt Nam và quốc tế, không lặp trong
  tháng. Chỉ chọn sự kiện nổi tiếng, có nguồn công khai, không đụng
  giới hạn hồ sơ mục 4. Chưa cần số liệu: viet-bai-hang-loat sẽ tra và kiểm chứng
  (`viet-bai-hang-loat/references/case-thuc-te.md`), nên **không** đưa
  con số của case vào `hook` / `y_chinh`. Ghi thêm "không dùng logo/hình ảnh
  của thương hiệu được nhắc tới".
- **mo_ta_anh**: ưu tiên tài nguyên thật trong hồ sơ (ảnh nơi làm, ảnh sản
  phẩm, ảnh lớp học...). Ghi rõ "ảnh thật: ..." hay "cần tạo: ...". Không thêm
  chi tiết sản phẩm mà hồ sơ không có (VD một dòng chữ trên nhãn, bao bì mà hồ
  sơ không nhắc) — viet-bai-hang-loat sẽ coi mô tả ảnh là sự thật và viết theo.
- **Bài `video-ngan`**: chọn loại video theo `tao-anh-bai-page/references/kieu-video.md`:
  video hoạt hình HTML theo 4 loại của trang mẫu https://skillry.dev/ai-videos/opus-5-5
  (Motion graphics, Explainers, 3D scenes, Games), hoặc video có giọng đọc
  (`video-minh-hoa-doc`). Ghi vào `mo_ta_anh`: `Video dọc 1080x1920. Kiểu: <loại> —
  <cách thể hiện>: <các cảnh chính>`. Không lặp cách thể hiện trong tháng. Người dùng muốn xen video mà không nói nhịp thì cứ 2-3 ảnh 1 video.
- **caption, hashtag, file_anh, link_bai** để trống; **trang_thai** =
  `ke-hoach`.
- Giọng, xưng hô, từ cấm trong hook và CTA theo đúng hồ sơ.

## Bước 5 — Tự soát trước khi ghi file

Kiểm tra và sửa nếu sai:

- [ ] Lịch chỉ dùng các trụ cột người dùng đã chọn ở Bước 2a
- [ ] Số bài mỗi trụ cột khớp kế hoạch ở Bước 2b (đếm lại thật)
- [ ] Mọi `thu` khớp với `ngay` (đã tính bằng lệnh)
- [ ] Không 2 bài bán liền nhau; trụ cột được rải đều (hoặc dồn có chủ đích đã ghi rõ)
- [ ] Không chủ đề trùng; không kiểu hook nào quá 3 lần/tuần
- [ ] Không dùng từ cấm / cam kết cấm trong hồ sơ
- [ ] Chỉ dùng định dạng hồ sơ ghi là làm được
- [ ] Mỗi bài `video-ngan` có `Kiểu: ...` trong `mo_ta_anh`, không lặp cách thể hiện
- [ ] `ma_bai` duy nhất, liên tục

## Bước 6 — Ghi file

Lưu vào thư mục thương hiệu (`<slug>/`, cùng chỗ với hồ sơ):

**`chien-luoc-content.md`** gồm:
1. Tóm tắt đầu vào (mục tiêu, giai đoạn page, nhịp đăng, ngày bắt đầu – kết
   thúc, dịp đặc biệt)
2. Bảng trụ cột đã chọn: tên | trụ cột gốc | mục đích | số bài | % | định
   dạng chính. Ngay dưới bảng, liệt kê **trụ cột dự phòng** — các ứng viên ở
   Bước 2a chưa được chọn (tên + đăng gì) — để tháng sau có sẵn cái mà thay
3. Series: tên, thứ trong tuần, khung bài
4. Khung 4 tuần: chủ đề tuần và trọng tâm
5. Bảng lịch xem nhanh: mã | ngày | thứ | giờ | trụ cột | định dạng | chủ đề |
   hook (ghi rõ: bảng này là bản xem lúc tạo — nguồn chính là CSV)
6. Việc cần chuẩn bị: ảnh thật cần chụp, feedback cần xin, video cần quay —
   gom từ `ghi_chu` và `mo_ta_anh`, kèm hạn (trước ngày đăng bài đó)
7. Cách đo sau 30 ngày: chỉ số theo mục tiêu trong hồ sơ, gợi ý mỗi Chủ nhật
   xem lại Insights 10 phút

**`lich-content.csv`** đúng định dạng `references/dinh-dang-lich.md` (mẫu:
`assets/mau-lich-content.csv`). Ghi file bằng Write, rồi thêm BOM UTF-8 để
Excel mở không lỗi dấu, VD Git Bash:
`printf '\xEF\xBB\xBF' | cat - lich-content.csv > tmp.csv && mv tmp.csv lich-content.csv`.
Sau đó đọc thử bằng công cụ có sẵn (PowerShell
`Import-Csv lich-content.csv | Measure-Object`, hoặc `python3 -c` với module
`csv`) để chắc số dòng và số cột đúng.

## Bước 7 — Trình bày và bước tiếp theo

Tóm tắt ngắn trong chat: đường dẫn 2 file, bảng trụ cột đã chọn + số bài, series,
việc cần chuẩn bị trong tuần 1. Hướng dẫn xem lịch: mở `lich-content.csv`
bằng Excel để xem (không bấm Lưu trong Excel — dễ hỏng dấu tiếng Việt), hoặc
Google Sheets → Tệp → Nhập → Tải lên. dang-bai-tu-dong đọc thẳng file CSV này để hẹn
giờ đăng qua Zernio, không cần Google Sheets.

Gợi ý bước tiếp: **`viet-bai-hang-loat` — viết caption cho lô tuần 1** (viết theo từng
tuần để người dùng duyệt kịp và chất lượng không bị loãng).

## Chế độ gia hạn / sửa lịch

**Sửa lịch** (VD "đổi bài ngày 15 sang chủ đề ưu đãi", "bỏ bài thứ 7"):
- Sửa đúng dòng, giữ nguyên `ma_bai`. Bỏ bài thì đặt `trang_thai` = `huy`,
  không xoá dòng (dòng có thể đã được dang-bai-tu-dong gửi đi).
- Nếu đổi chủ đề của bài đã có caption (`cho-duyet`, `da-duyet`) → xoá
  caption, đặt lại `ke-hoach`, ghi lý do ở `ghi_chu`, và báo người dùng bài
  đó cần viết/duyệt lại.
- Chạy lại checklist Bước 5 cho phần đã sửa.

**Gia hạn tháng tiếp theo:**
1. Đọc CSV cũ: chủ đề đã dùng, `ma_bai` lớn nhất, bài nào `huy`/`loi`.
2. Hỏi người dùng 3-5 bài được tương tác tốt nhất / kém nhất tháng qua (hoặc
   đọc số liệu nếu có file báo cáo) và mục tiêu có đổi không (nếu đổi, gợi ý
   cập nhật hồ sơ bằng lap-ho-so-thuong-hieu).
3. Giữ trụ cột và series đang hiệu quả, tăng tỷ lệ loại bài chạy tốt, thay
   loại bài kém. Không hỏi lại cả 10 trụ cột như Bước 2a: chỉ khi cần thay
   trụ cột kém thì đưa 2-3 ứng viên (ưu tiên lấy từ "trụ cột dự phòng" trong
   `chien-luoc-content.md`) cho người dùng chọn. Cân nhắc nâng
   `giai_doan_page` nếu tương tác đã lên.
4. **Nối thêm** dòng mới vào CSV (đánh số `ma_bai` tiếp), không tạo file mới;
   thêm mục "Tháng N" vào `chien-luoc-content.md`.
