---
name: viet-bai-hang-loat
description: "Bộ skill nuôi fanpage: VIẾT CAPTION HÀNG LOẠT theo lịch content (lich-content.csv của len-lich-content), từng lô 1 tuần, đúng giọng và từ cấm trong hồ sơ thương hiệu (lap-ho-so-thuong-hieu). Mỗi bài nội dung = khung kiến thức của chủ page + một GÓC VIẾT xoay vòng trong lô (case thật có nguồn, tình huống ai cũng gặp, các kiểu người, đối thoại, lật hiểu lầm, so sánh, quan điểm, lá thư, mùa vụ...); mỗi lô QUÉT TREND từ khoảng 10 bài báo mới nhất để viết 1-2 bài bắt trend liên tưởng tới sản phẩm; số liệu, nhân vật thật thì tự tìm và đọc nguồn. Chuẩn Facebook, không bịa lời khách, thiếu dữ kiện để [CHÈN: ...]. Ghi CSV (cho-duyet) + file duyệt bai-viet/tuan-N.md; xử lý vòng sửa/duyệt (da-duyet). Dùng khi gõ \"viet-bai-hang-loat\", \"viết bài tuần này\", \"viết caption cho lịch\", \"viết content hàng loạt\", \"sửa bài B003\", \"duyệt B001-B004\". KHÔNG dùng khi chưa có lịch (len-lich-content) hay chỉ cần 1 bài quảng cáo lẻ."
---

# Viết bài hàng loạt theo lịch

Vị trí trong bộ skill nuôi fanpage:

```
lap-ho-so-thuong-hieu → len-lich-content → [viet-bai-hang-loat + duyệt]
→ tao-anh-bai-page (ảnh) / video-minh-hoa-doc (video) → dang-bai-tu-dong
```

Đầu vào là lịch đã có sẵn chủ đề, hook nháp, ý chính, CTA cho từng bài. Việc
của skill này là biến mỗi dòng thành một bài đăng hoàn chỉnh **nghe như chủ
page tự viết** — rồi đưa cho người dùng duyệt. Bài sai giọng, sáo rỗng hay có
chi tiết bịa còn tệ hơn không đăng, vì người theo dõi page nhận ra ngay.

Mỗi bài nội dung có hai lớp: **khung kiến thức** của chủ page (nguyên tắc,
công thức trong hồ sơ và tài liệu họ đưa) và **một góc viết** làm bài hấp dẫn:
case thật có nguồn, tình huống ai cũng gặp, các kiểu người, đối thoại, lật
hiểu lầm, so sánh, quan điểm, lá thư, mùa vụ... Chép nguyên tài liệu thì bài
đọc như giáo trình; nhưng cả lô cùng một góc (VD toàn nghiên cứu, dẫn chứng)
thì cũng thành chuỗi bài giảng đều đều. Vì vậy góc phải xoay vòng trong lô.
Menu góc: `references/goc-viet.md`; góc case thật: `references/case-thuc-te.md`.

Viết theo **lô 1 tuần** (khoảng 3-7 bài). Lý do: chất lượng giảm rõ khi viết
30 bài một lúc, người dùng đọc duyệt 30 bài một lần sẽ đọc lướt, và góp ý của
tuần trước giúp tuần sau viết đúng hơn.

## Bước 0 — Đọc dữ liệu

1. **Hồ sơ** `<slug>/ho-so-thuong-hieu.md` — đọc toàn bộ. Quan trọng nhất:
   mục 3 Giọng (xưng hô, emoji, độ dài, bảng ✅/❌), mục 4 Giới hạn (từ cấm,
   cam kết cấm, cụm sáo rỗng), mục 1 sản phẩm/điểm khác biệt/bằng chứng thật,
   mục 2 chất liệu Vấn đề–Mong muốn, mục 6 CTA mẫu và kênh liên hệ.
2. **Lịch** `<slug>/lich-content.csv` — định dạng cột xem
   `len-lich-content/references/dinh-dang-lich.md` nếu có; tóm tắt: caption
   và hashtag ghi vào cột `caption`, `hashtag`; `trang_thai` đi theo
   `ke-hoach → cho-duyet → da-duyet`.
3. `<slug>/chien-luoc-content.md` — khung của series, chủ đề tuần.
4. Các file `<slug>/bai-viet/tuan-*.md` đã có — để giữ giọng nhất quán, không
   lặp ý/câu mở bài đã dùng, và đọc lại các góp ý cũ.
5. File nghiên cứu khách hàng người dùng có sẵn — thêm chất liệu.
6. Số liệu, nhận xét về bài cũ người dùng đưa — góc viết, kiểu hook, CTA đã
   chứng minh hiệu quả bằng số thật thì ưu tiên; kiểu YẾU thì đổi cách viết.

Chưa có lịch → đề nghị chạy `len-lich-content`. Chưa có hồ sơ → `lap-ho-so-thuong-hieu`.

## Bước 1 — Chọn lô và gom nguyên liệu thật

- Mặc định: tuần sớm nhất còn bài `ke-hoach` hoặc `can-sua`. Người dùng có
  thể chỉ định (`tuần 2`, `B005-B008`). Nếu họ muốn viết cả tháng, vẫn làm
  nhưng chia thành từng tuần, xong tuần nào ghi file tuần đó.
- Đọc cột `ghi_chu` của các bài trong lô: bài nào cần dữ kiện thật (câu
  chuyện, feedback, bảng thành phần, mức ưu đãi, số lượng...) → gom thành
  **một** tin nhắn hỏi người dùng. Họ đưa được thì dùng; chưa có thì vẫn viết
  và giữ chỗ `[CHÈN: ...]` — không chặn cả lô vì thiếu một dữ kiện.
- **Quét trend** (đọc `references/trend-bao-chi.md`): lấy tin mới từ 4-5 báo,
  mở đọc khoảng 10 bài trong 7 ngày gần nhất, lọc chuyện khách quan tâm, nối
  tự nhiên với sản phẩm, còn nóng, an toàn (loại thảm án, thiên tai, chính
  trị, vụ án, scandal). Chọn 1-2 trend cho lô — vào chỗ lịch đã giữ
  "Bài trend", hoặc thêm/thay bài và nói rõ với người dùng. Ghi
  `<slug>/trend/trend-<ngày>.md` (bài đã đọc, trend dùng/loại kèm lý do).
- **Chọn góc viết cho từng bài nội dung** (đọc `references/goc-viet.md`):
  hợp với chủ đề, không quá 2 bài cùng góc trong lô, case thật khoảng 1/3 số
  bài trở xuống (trừ khi hồ sơ/người dùng muốn nhiều hơn). Đọc `Góc:` trong
  `ghi_chu` các tuần trước để không lặp nhịp; dùng `Góc gợi ý` / `Case gợi ý`
  của len-lich-content nếu hợp.
- **Bài video (`video-ngan`)**: nếu `mo_ta_anh` chưa ghi `Kiểu: ...` thì chọn
  loại video (4 loại của trang mẫu, hoặc video có giọng đọc) và cách thể hiện hợp
  góc viết theo `tao-anh-bai-page/references/kieu-video.md`, ghi vào `mo_ta_anh`
  và `ghi_chu` (`Kiểu video: ...`). Caption viết sao cho video và chữ khớp nhau:
  mọi chữ, số trên video phải có trong caption. Trong chat, báo kiểu đã chọn
  cho từng bài video.
- **Tìm nguồn cho bài có sự thật** (góc case thật, lật hiểu lầm, mẹo sức khoẻ,
  số liệu...; đọc `references/case-thuc-te.md`): tra web, mở đọc nguồn, chỉ giữ
  con số đọc được ở nguồn đáng tin; xen Việt Nam và quốc tế, không lặp case với
  các tuần trước. Không tìm được nguồn đủ tin thì đổi sang góc không cần nguồn
  và báo người dùng — không bịa.

## Bước 2 — Viết từng bài

Đọc `references/cong-thuc-bai-page.md` và `references/quy-tac-facebook.md`.

Với mỗi dòng trong lô:
1. Bắt đầu từ `hook`, `y_chinh`, `cta`, `cong_thuc` của lịch. Được viết lại
   hook cho sắc hơn nhưng giữ đúng ý chính và chủ đề — người dùng đã duyệt lịch
   theo chủ đề đó.
2. Viết theo công thức. Độ dài theo hồ sơ (mục 3); hồ sơ không ghi thì bài
   nội dung dài 200-300 chữ (bảng cuối `references/cong-thuc-bai-page.md`).
3. Series thì theo đúng khung series trong chiến lược, để các tuần giống nhau
   về cấu trúc.
4. Dùng chi tiết của chính thương hiệu này (tên sản phẩm, giá, con số, câu
   chuyện, nơi chốn trong hồ sơ). Phép thử: thay tên thương hiệu khác vào mà
   bài vẫn đúng → bài quá chung, viết lại.
5. **Chỉ bài trụ cột bán hàng mới nhắc tới sản phẩm/khoá học** (giá, lịch,
   ưu đãi, CTA mua, hashtag sản phẩm). Ngoại lệ thứ nhất: **câu dẫn mềm cuối
   bài** nếu hồ sơ (mục 6) chọn cách này — đặt ở dòng cuối cùng, sau CTA, chỉ
   ở bài có nội dung khớp một module/hạng mục có thật trong hồ sơ; tên module
   lấy từ hồ sơ, chưa có thì `[CHÈN: tên module]`. Bài không khớp sản phẩm nào
   thì không gắn — gắn gượng làm người đọc thấy bị bán hàng. Ngoại lệ thứ hai:
   **bài trend** được liên tưởng tới sản phẩm ở 1-2 câu cuối, trước CTA
   (`references/trend-bao-chi.md` Bước 5) — công dụng trong hồ sơ, không giá,
   không chốt đơn. Bài khác không chào bán, không kèm CTA
   về sản phẩm, không câu "cầu nối" kiểu "đây là lúc bạn cần <sản phẩm>"
   dẫn sang sản phẩm — người đọc nhận ra ngay và page thành tờ rơi.
6. **Viết theo góc đã chọn, rồi dẫn về khung kiến thức.** Góc nào cũng phải
   chở được `y_chinh` và một điều người đọc làm được hoặc nhớ được.
   - Góc case thật: case khoảng 40%, khung + cách làm khoảng 60%; kể bằng lời
     chủ page, có mốc thời gian và con số, nhắc nguồn ngay trong bài với con
     số quan trọng ("Theo Tổng cục Thống kê..."). Con số tự tính thì tính bằng
     lệnh và ghi giả định. Chuyện chưa chắc thì viết "được cho là".
   - Góc hư cấu (tình huống, các kiểu người, đối thoại, lá thư): đọc ra là
     chuyện chung, chuyện vui — không gán cho một khách/học viên cụ thể.
   - Hài: đùa về thói quen, không đùa ngoại hình, giới tính, vùng miền.
   Tuân giới hạn hồ sơ mục 4 (VD cấm nêu tên chê công ty → kể trung lập sự kiện
   đã công khai), không dùng logo thương hiệu được nhắc tới. Ghi vào
   `ghi_chu`: `Góc: ... | Khung: ... | Case: ... | Nguồn: <link> · <link>`
   (Case, Nguồn chỉ khi bài có sự thật cần nguồn).
7. Bằng chứng, lời khách, con số, ưu đãi **về chính thương hiệu** chỉ lấy
   **từ hồ sơ hoặc từ người dùng** (case thật bên ngoài theo mục 6 là chuyện
   khác — vẫn không được thay cho lời khách). Không có thì `[CHÈN: ...]`. Lời khách bịa đưa lên page là lừa người
   đọc, và rủi ro pháp lý với ngành có quy định quảng cáo.
8. Viết `hashtag` riêng (2-5 cái, có hashtag thương hiệu).
9. Viết thêm **1 hook dự phòng** khác kiểu cho mỗi bài (chỉ để trong file
   duyệt, không vào CSV) — người dùng thích hook nào thì chọn.

## Bước 3 — Tự soát từng bài

- [ ] Dòng đầu là hook đứng được một mình, không phải lời chào
- [ ] Đúng xưng hô, mức emoji trong hồ sơ; khớp cột ✅, tránh cột ❌
- [ ] Độ dài đúng hồ sơ (mặc định 200-300 chữ) — đếm bằng lệnh, không ước lượng
- [ ] Không từ cấm, không cam kết cấm, không cụm sáo rỗng trong hồ sơ
- [ ] Không markdown (`**`, `#`, `[..](..)`); hashtag không nằm trong caption
- [ ] Không có chi tiết bịa; mọi chỗ thiếu đã là `[CHÈN: ...]`
- [ ] Bài nội dung có góc viết rõ (ghi `Góc:` trong `ghi_chu`) và vẫn chở được
      khung kiến thức của chủ page, không thành bài kể chuyện người khác hay
      bài đùa suông
- [ ] Mọi con số, nghiên cứu, mốc thời gian, tên người truy được về nguồn đã
      mở đọc, link nằm trong `ghi_chu`; không lặp case trong lô và các tuần
      trước
- [ ] Bài trend: sự thật lấy từ bài báo đã mở đọc (không theo tiêu đề), link +
      ngày đăng trong `ghi_chu`, còn trong hạn dùng; không gắn người/sự kiện
      với sản phẩm như bảo chứng; không dính thảm án, thiên tai, chính trị
- [ ] Góc hư cấu không gán cho khách/học viên cụ thể; hài không đụng ngoại
      hình, giới tính, vùng miền
- [ ] CTA khớp cột `cta` và kênh liên hệ trong hồ sơ
- [ ] Bài video: đã chọn kiểu (`Kiểu: ...` trong `mo_ta_anh`), chữ trên video có trong caption
- [ ] Không trùng câu mở / ý với bài khác trong lô và các tuần trước

Cả lô: đọc liền các bài theo thứ tự ngày — nếu nghe lặp nhịp (cùng góc, cùng
kiểu mở bài, cùng câu kết) thì sửa cho đa dạng. Không quá 2 bài cùng góc; case
thật khoảng 1/3 số bài nội dung trở xuống, trừ khi người dùng muốn khác.

## Bước 4 — Ghi file duyệt

Tạo `<slug>/bai-viet/tuan-<N>.md` (N = cột `tuan`). Đây là file người dùng
đọc và góp ý, nên trình bày để đọc dễ trên màn hình.

Cách nhanh và khớp tuyệt đối với CSV: ghi CSV trước (Bước 5), ghi hook dự
phòng vào một file tạm dạng `B001<TAB>câu hook` mỗi dòng, rồi chạy
`scripts/tao-file-duyet.ps1` (gọi thẳng trong PowerShell, không qua `-File`,
để danh sách tuần không bị gộp):
`& "<thư mục skill>/scripts/tao-file-duyet.ps1" -Csv "<slug>/lich-content.csv" -OutDir "<slug>/bai-viet" -ThuongHieu "<tên>" -Tuan @(1,2) -HookFile "<file hook>"`.
Cấu trúc file (tự viết tay cũng theo mẫu này):

```markdown
# Bài viết tuần <N> — <Tên thương hiệu>

Cách duyệt: đọc từng bài, ghi góp ý ngay dưới dòng "Góp ý:" (để trống = ổn).
Xong thì nói với Claude: "sửa theo góp ý tuần <N>" hoặc "duyệt B001, B002".

---

## B001 · Thứ 3 06/10 · 20:30 · <trụ cột> · faq
Trạng thái: cho-duyet

<caption nguyên văn, đúng như sẽ đăng>

<hashtag>

Hook dự phòng: <câu>
Ảnh cần: <mo_ta_anh>
Ghi chú: <ghi_chu — gồm Góc, Khung, Case, Nguồn>
Còn thiếu: <các chỗ [CHÈN] nếu có, hoặc "không">

Góp ý:

---
```

## Bước 5 — Ghi vào CSV

Cập nhật từng dòng của lô bằng **Edit** (không viết lại cả file bằng Write
— viết lại cả file dễ làm sai các dòng khác, kể cả dòng đã duyệt):

- `old_string` = nguyên dòng hiện tại của bài đó (bắt đầu bằng `"B00x",`).
- `new_string` = cùng dòng, chỉ đổi: `caption`, `hashtag`, `trang_thai` =
  `cho-duyet`, `ghi_chu` (thêm "còn [CHÈN]" nếu có), và `hook` / `cong_thuc`
  nếu đã đổi.
- Caption xuống dòng bình thường **bên trong** ngoặc kép; mọi dấu `"` trong
  caption phải viết thành `""`. Giữ nguyên các cột khác từng ký tự.

Sau khi ghi, đọc thử CSV để chắc file không vỡ: PowerShell
`Import-Csv <file> -Encoding UTF8` (đếm số dòng không đổi, `caption` của lô
không rỗng, `trang_thai` hợp lệ), hoặc `python3` với module `csv`.

## Bước 6 — Trình bày

Trong chat: đường dẫn file duyệt, danh sách bài của lô (mã · ngày · góc viết
· 1 dòng hook · case nếu có), bài nào còn `[CHÈN]` và cần gì, và danh sách link
nguồn để người dùng tự mở kiểm. Hướng dẫn 3 cách phản hồi:
1. Ghi góp ý trong file duyệt rồi nói "sửa theo góp ý tuần N"
2. Nói thẳng trong chat: "B003 ngắn lại, bỏ emoji"
3. "Duyệt B001, B002" (hoặc "duyệt cả tuần")

## Vòng duyệt / sửa

**Sửa** (góp ý trong file duyệt hoặc trong chat):
- Viết lại đúng bài được góp ý, cập nhật cả file duyệt và CSV, giữ
  `cho-duyet`. Trong file duyệt, xoá góp ý đã xử lý và ghi "Đã sửa: <tóm tắt>".
- Góp ý mang tính **chung** ("ngắn hơn", "đừng dùng chữ 'hành trình'", "bớt
  emoji") → đề nghị ghi vào hồ sơ (mục 3 bảng ✅/❌ hoặc mục 4 cụm tránh
  dùng, tăng `phien_ban`) để mọi tuần sau tự áp dụng. Đây là cách page "học"
  giọng của chủ.

**Duyệt** — chỉ đặt `da-duyet` khi người dùng **nói rõ** mã bài được duyệt
(hoặc "duyệt cả tuần N"); không tự duyệt thay họ, vì `da-duyet` là tín hiệu
cho dang-bai-tu-dong đăng thật lên page.
- Bài còn `[CHÈN` → không duyệt; báo lại cần điền gì.
- Cập nhật `trang_thai` trong CSV và dòng "Trạng thái:" trong file duyệt.
- Khi cả lô đã duyệt, gợi ý bước tiếp: viết tuần sau (viet-bai-hang-loat), hoặc chuyển
  bài đã duyệt sang đăng tự động (dang-bai-tu-dong).

Nhắc người dùng: muốn sửa tay thì sửa trong file duyệt `.md` hoặc nói với
Claude — không mở CSV bằng Excel rồi bấm Lưu, vì Excel có thể đổi mã hoá và
làm hỏng dấu tiếng Việt hoặc cấu trúc ô xuống dòng.
