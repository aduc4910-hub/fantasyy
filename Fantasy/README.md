# Ashen Press — The Art Book Shelf (3D Web Experience)

Dự án giao diện 3D tương tác mô phỏng kệ sách nghệ thuật ("The Art Book Shelf") từ file `1.txt`, đã được thiết lập hoàn chỉnh để chạy trực tiếp trên **Localhost**.

---

## 🚀 Cách khởi động Localhost

### Cách 1: Chạy bằng file Batch (Nhanh nhất - 1 click)
- Nhấp đúp chuột vào file **`start-localhost.bat`**.
- Server sẽ tự động khởi chạy và mở trình duyệt tại: **`http://localhost:8080/`**.

### Cách 2: Chạy qua PowerShell
Mở PowerShell tại thư mục này và gõ:
```powershell
.\server.ps1
```
*(Nếu cổng 8080 đang bận, server sẽ tự động chuyển sang cổng kế tiếp như 8081, 8082,... và hiển thị thông báo)*.

---

## 📂 Cấu trúc thư mục

- **`index.html`**: Toàn bộ mã nguồn giao diện web (HTML5, WebGL Shaders, Canvas 2D, Three.js 3D Book Shelf, CSS hiệu ứng).
- **`three.module.js`**: Thư viện Three.js bản chuẩn (ES module), được lưu cục bộ giúp website chạy nhanh, không phụ thuộc vào kết nối mạng ngoài.
- **`server.ps1`**: Bộ server HTTP cục bộ viết bằng PowerShell, hỗ trợ MIME types chuẩn (`.html`, `.js`, `.css`, `.webp`,...), không cần cài đặt Node.js hay Python.
- **`start-localhost.bat`**: File script khởi động tiện lợi chỉ với 1 click.
- **`1.txt`**: File thiết kế gốc được lưu trữ nguyên bản.

---

## ✨ Các tính năng nổi bật của thiết kế

1. **Hiệu ứng kệ sách 3D (3D Wooden Bookshelf)**:
   - Các thanh gỗ sồi tự nhiên được tạo vân và hiệu ứng ánh sáng bề mặt bóng mờ (satin sheen).
   - Tường limewash với chất liệu giấy cổ điển, đổ bóng mềm thực tế.
2. **Mô phỏng sách 3D chân thực (Realistic 3D Hardcover Volumes)**:
   - 10 tập sách nghệ thuật danh tiếng (*Nightreign, Shadow of the Erdtree, Armored Core VI, Elden Ring, Sekiro, Dark Souls I-III, Bloodborne, Demon's Souls*).
   - Bìa sách có hiệu ứng gân vải, mạ vàng (gold foil stamping), gáy rỗng (hollow back) và thớ giấy trang sách.
3. **Tương tác trực quan**:
   - Rê chuột (hover): Sách tự nâng lên nhẹ và nghiêng theo góc nhìn chuột.
   - Nhấp chuột (click): Sách di chuyển ra phía trước để soi chi tiết; bảng thông tin giấy xé (torn sheet) trượt ra từ bên trái.
   - Xoay sách: Kéo chuột để xoay 360 độ hoặc bấm **"Look inside"** / phím **Space** để lật mặt sau xem tranh minh họa.
   - Đóng: Nhấn **"Close"** hoặc phím **Escape**.
   - Hỗ trợ đầy đủ chế độ Responsive cho cả máy tính để bàn (Desktop) và di động (Mobile).

