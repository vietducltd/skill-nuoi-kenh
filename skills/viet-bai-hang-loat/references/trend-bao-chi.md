# Quét trend từ báo: viết bài bắt trend liên tưởng tới sản phẩm

Mỗi lô bài, trước khi viết, đọc khoảng **10 bài báo mới nhất** để tìm chuyện
đang được nhiều người nói tới, rồi chọn 1-2 chuyện nối được tự nhiên với sản
phẩm/dịch vụ để viết bài trend. Bài trend là góc "chuyện đang nóng" trong
`references/goc-viet.md`, nhưng làm theo quy trình riêng ở đây vì nó phụ thuộc
ngày viết.

Vì sao: bài nói đúng chuyện người đọc vừa thấy trên báo, trên mạng sáng nay thì
được dừng lại đọc nhiều hơn bài kiến thức chung chung.

## Mục lục
- Khi nào làm
- Bước 1: lấy tin mới
- Bước 2: mở đọc khoảng 10 bài
- Bước 3: lọc trend
- Bước 4: liên tưởng tới sản phẩm
- Bước 5: viết
- Ghi lại

## Khi nào làm

- **Mỗi lô, ngay trước khi viết** — không quét một lần cho cả tháng. Trend
  sống vài ngày; bài trend nên đăng trong **3 ngày** kể từ khi báo đăng tin.
- Lịch len-lich-content có thể đã giữ chỗ `chu_de` = "Bài trend — viet-bai-hang-loat chọn khi viết".
  Không có chỗ giữ thì thêm bài trend vào lô nếu người dùng đồng ý, hoặc thay
  một bài nội dung chưa duyệt và nói rõ trong chat.
- Lô viết trước ngày đăng hơn 3 ngày → ghi `Hạn dùng` trong `ghi_chu` và nhắc
  người dùng kiểm lại trend trước khi duyệt.

## Bước 1: lấy tin mới

Dùng WebFetch (hoặc công cụ đọc web có sẵn). Lấy danh sách tiêu đề mới nhất từ
**ít nhất 4-5 báo khác nhau**, chọn theo khách mục tiêu trong hồ sơ:

| Nguồn | Cách lấy | Hợp với |
|---|---|---|
| VnExpress | RSS `https://vnexpress.net/rss/tin-moi-nhat.rss` (trang chủ hay chặn công cụ đọc) | Chung |
| Tuổi Trẻ | RSS `https://tuoitre.vn/rss/tin-moi-nhat.rss` | Chung |
| Thanh Niên | Trang chủ `https://thanhnien.vn/` | Chung, thể thao, sự kiện |
| Dân trí | `https://dantri.com.vn/tin-moi-nhat.htm` | Chung, sức khoẻ |
| Kênh14 | Trang chủ `https://kenh14.vn/` | Giới trẻ, showbiz, đời sống |
| Znews, VietnamNet, Lao Động | Trang chủ, mục mới nhất | Chung |
| CafeF, VnEconomy | Trang chủ | Kinh doanh, tài chính |
| Google Trends Việt Nam | `https://trends.google.com/trending?geo=VN` | Từ khoá đang được tìm nhiều trong 24 giờ |

Một nguồn lỗi (403, 406) thì đổi nguồn khác hoặc đổi sang RSS; đừng dừng cả
bước. Ngày đăng của bài phải trong **7 ngày** gần nhất, ưu tiên 3 ngày.

## Bước 2: mở đọc khoảng 10 bài

Từ danh sách tiêu đề, chọn khoảng 10 bài có vẻ hợp với khách mục tiêu (từ ít
nhất 4 báo), **mở đọc từng bài**:
- ngày giờ đăng;
- sự thật chính: ai, cái gì, khi nào, ở đâu, con số.

Tiêu đề báo hay giật, có khi trái với nội dung bên trong (VD tiêu đề nói một
đội "vừa vô địch", đọc kỹ mới biết đó là một giải khác).

Hai báo nói khác nhau → đọc thêm báo thứ ba hoặc nguồn chính thức. Không viết
theo tiêu đề.

## Bước 3: lọc trend

Mỗi chuyện qua đủ 4 câu hỏi mới dùng:

1. **Khách mục tiêu có quan tâm không?** Nhìn theo khách trong hồ sơ: nam văn
   phòng, mẹ bỉm, sinh viên... quan tâm chuyện khác nhau.
2. **Nối được với sản phẩm một cách tự nhiên không?** Phải nối qua một **nhu
   cầu thật** (mồ hôi, thời tiết, sức khoẻ, tiền bạc, thời gian...). Phải giải
   thích mối nối dài hơn một câu → bỏ.
3. **Còn nóng tới ngày đăng không?**
4. **An toàn không?** **Không dùng**:
   - Thảm án, tai nạn, thiên tai, dịch bệnh, người chết, người bị thương. Đang
     có lũ, bão ở một vùng thì không đùa về mưa, ngập, và không đăng bài bắt
     trend thời tiết nhắm khách vùng đó.
   - Chính trị, chiến sự, tôn giáo, chuyện biên giới.
   - Vụ án đang điều tra, đang xử; bê bối thực phẩm, thuốc giả của doanh
     nghiệp có tên.
   - Đời tư, scandal của người nổi tiếng.
   - Chuyện của đối thủ trực tiếp.
   - Chuyện có thể khiến page bị xem là trục lợi trên nỗi buồn của người khác.

**Ghi cả chuyện bị loại kèm lý do** vào file quét trend: người dùng biết mình
đã cân nhắc gì, lần sau không phải xét lại.

## Bước 4: liên tưởng tới sản phẩm

Đi theo chuỗi: **chuyện trên báo → khoảnh khắc trong đời người đọc → nhu cầu →
sản phẩm**. Mẫu:

```
<chuyện trên báo: ai, chuyện gì, con số chính>
  → <khoảnh khắc tương tự trong đời người đọc>
  → <nhu cầu thật: mồ hôi, thời tiết, sức khoẻ, tiền bạc, thời gian...>
  → <sản phẩm/dịch vụ trong hồ sơ đáp ứng nhu cầu đó>
```

Các kiểu nối hay gặp:

| Loại trend | Nối sang |
|---|---|
| Thời tiết (nắng nóng, mưa, rét đầu mùa) | Chăm sóc cơ thể, quần áo, sức khoẻ theo mùa |
| Thể thao (trận đấu lớn, giải chạy) | Vận động, mồ hôi, hồi phục, xem bóng cùng nhau |
| Sự kiện, concert, lễ hội | Chuẩn bị đi đông người, ngoại hình, an toàn |
| Dịp lễ (20/10, Trung thu, Tết, mùa cưới) | Quà, chuẩn bị, thói quen |
| Số liệu tiêu dùng, giá cả (xăng, lãi suất) | Tiết kiệm, chi tiêu, thói quen mua |
| Chủ đề đời sống đang được bàn (ứng xử, sức khoẻ, công nghệ) | Kiến thức của chủ page về chủ đề đó |

## Bước 5: viết

- **Mở bằng chuyện trên báo, kể bằng lời của page.**
  - Nêu tên báo khi có con số hay sự thật chính ("theo báo Thanh Niên").
  - Không chép nguyên câu, nguyên đoạn của bài báo; không dùng ảnh, video,
    logo của báo hay của sự kiện.
- **Thân bài là khung kiến thức của chủ page** (mẹo, cách làm), giống các góc
  khác — trend chỉ là cửa vào.
- **Nhắc sản phẩm ở 1-2 câu cuối**, trước CTA, như một gợi ý:
  - Đây là ngoại lệ có chủ ý của quy tắc "chỉ bài bán hàng mới nhắc sản phẩm"
    — người dùng muốn bài trend liên tưởng tới sản phẩm.
  - Chỉ dùng công dụng có trong hồ sơ, không giá, không ưu đãi, không chốt đơn.
  - Hồ sơ cấm nhắc sản phẩm trong bài nội dung → bỏ câu đó hoặc xếp bài vào
    trụ cột Bán hàng.
- **Không gắn tên người, đội bóng, nghệ sĩ, sự kiện với sản phẩm** như thể họ
  dùng hay bảo chứng. Không viết như thể thương hiệu tài trợ sự kiện.
- **Không chê, không mỉa** người trong tin (VD đội thua): giọng đồng cảm hoặc
  trung tính.
- Độ dài, giọng, từ cấm theo hồ sơ như mọi bài.

## Ghi lại

1. **File quét trend** `<slug>/trend/trend-<YYYY-MM-DD>.md`:
   - bảng các bài đã đọc (báo · ngày đăng · tiêu đề · link · tóm tắt 1 dòng);
   - bảng chuyện **dùng** / **loại**, mỗi chuyện kèm lý do;
   - ý tưởng liên tưởng cho từng chuyện được dùng.
2. **`ghi_chu` của bài**:
   ```
   Góc: trend | Trend: <tóm tắt> | Báo: <link> (<ngày đăng>) | Hạn dùng: đăng trước <ngày> | Khung: <...>
   ```
3. **Trong chat**: liệt kê trend đã dùng, trend đã loại, và các link báo để
   người dùng tự mở kiểm.
