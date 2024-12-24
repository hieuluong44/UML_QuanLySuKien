create database BTL_UML_QuanLySuKien
use BTL_UML_QuanLySuKien
go

-- Bảng Người dùng
create table NguoiDung (
    IDNguoiDung varchar(10) primary key not null,
	HinhAnh varchar(max) null,
    TenNguoiDung nvarchar(50) not null,
    Email varchar(50) not null unique,
    SoDienThoai varchar(10) not null unique,
    GioiTinh nvarchar(10) null,
	NgaySinh date null,
    MatKhau varchar(20) not null,
	QuyenHan nvarchar(20) null check (QuyenHan in (N'Khách', N'Quản trị'))
);
go

-- Bảng loại sự kiện
create table LoaiSuKien (
    IDLoaiSuKien varchar(10) primary key not null, 
    TenLoai nvarchar(50) not null, 
    MoTa nvarchar(200) null
);
go

-- Bảng Sự kiện
create table SuKien (
    IDSuKien varchar(10) primary key not null,
    IDLoaiSuKien varchar(10) foreign key references LoaiSuKien(IDLoaiSuKien) not null,
	HinhAnh varchar(max) null,
	HoTenNguoiTao nvarchar(50) not null,
	Email varchar(30) not null,
	SoDienThoai varchar(10) not null,
    TenSuKien nvarchar(100) not null,
    ThoiGianToChuc datetime not null,
    ThoiGianKetThuc datetime not null,
    SoLuongKhachDuKien int not null,
	NganSachDuKien decimal not null,
    DiaDiem nvarchar(max) not null,
    MoTaSuKien nvarchar(max) not null,
	KieuSuKien nvarchar(50) null check (KieuSuKien in (N'Đặc biệt', N'Xu hướng', N'Đặc sắc', N'Thường')),
	TrangThaiSuKien nvarchar(20) default N'Chờ xác nhận' check (TrangThaiSuKien in (N'Chờ xác nhận',N'Đã xác nhận' ,N'Chưa bắt đầu', N'Đang diễn ra', N'Hoàn thành', N'Hủy'))
);
go

-- Bảng đăng ký tạo sự kiện
create table DangKyTaoSuKien (
	IDDangKy varchar(10) primary key not null,
    IDNguoiDung varchar(10) foreign key references NguoiDung(IDNguoiDung) not null,
	IDSuKien varchar(10) foreign key references SuKien(IDSuKien) not null,
);
go

-- Bảng Vé
create table Ve (
    IDVe varchar(10) primary key not null,
    IDSuKien varchar(10) not null foreign key references SuKien(IDSuKien), 
    LoaiVe nvarchar(10) not null,  
    GiaVe decimal not null, 
	SoLuongVe int not null,
    TrangThai nvarchar(20) default N'Còn vé' check (TrangThai in (N'Còn vé', N'Hết vé', N'Hủy'))
);
go

-- Bảng giao dịch
create table GiaoDichThanhToan (
    IDGiaoDich varchar(10) primary key not null,
    IDNguoiDung varchar(10) foreign key references NguoiDung(IDNguoiDung) not null,
	TongSoVe int not null,
    NgayThanhToan datetime default getdate() not null,
    TongTien decimal default 0 not null,
    TrangThai nvarchar(20) not null  check (TrangThai in (N'Chưa thanh toán', N'Đã thanh toán'))
);
go

-- Bảng chi tiết giao dịch
create table ChiTietGiaoDich (
    IDChiTietGiaoDich varchar(10) primary key not null, 
    IDGiaoDich varchar(10) foreign key references GiaoDichThanhToan(IDGiaoDich),  
    IDVe varchar(10) foreign key references Ve(IDVe),  
    SoLuong int not null, 
    GiaTien decimal not null 
);
go

-- Bảng nhom nhân viên
create table NhomNhanVien (
	IDNhom varchar(10) primary key not null,
	LoaiNhom nvarchar(200) not null,
	IDSuKien varchar(10) foreign key references SuKien(IDSuKien) null,
	SoLuongNhanVien int default 0,
	NhiemVu nvarchar(200) not null
);
go

-- Bảng Nhân viên
create table NhanVien (
    IDNhanVien varchar(10) primary key not null,
	IDNhom varchar(10) foreign key references NhomNhanVien(IDNhom) not null,
	HinhAnh varchar(max) null, 
    TenNhanVien nvarchar(50) not null,
    SoDienThoai varchar(10) not null unique ,
    Email varchar(50) not null unique,
	QuyenHan nvarchar(50) not null check (QuyenHan in (N'Trưởng nhóm', N'Phó trưởng nhóm',N'Thành viên'))
);
go

-- Bảng Đánh giá
create table DanhGia (
    IDDanhGia varchar(10) primary key not null,
    IDSuKien varchar(10) foreign key references SuKien(IDSuKien) not null,
    IDNguoiDung varchar(10) foreign key references NguoiDung(IDNguoiDung) not null,
    DanhGia int not null,
    NhanXet nvarchar(200) null,
	ThoiGianPhanHoi datetime default getdate() not null
);
go


-- Drop tables that reference other tables
DROP TABLE IF EXISTS PhanHoi;
DROP TABLE IF EXISTS ThanhToan;
DROP TABLE IF EXISTS NhanVien;
DROP TABLE IF EXISTS Ve;
DROP TABLE IF EXISTS ChiTietGiaoDich;
DROP TABLE IF EXISTS GiaoDichThanhToan;
DROP TABLE IF EXISTS DanhGia;
DROP TABLE IF EXISTS NhomNhanVien;
DROP TABLE IF EXISTS DangKyTaoSuKien;
go

-- Drop tables that are referenced by others
DROP TABLE IF EXISTS SuKien;
DROP TABLE IF EXISTS LoaiSuKien;
DROP TABLE IF EXISTS NguoiDung;
GO



insert into NguoiDung (IDNguoiDung, HinhAnh, TenNguoiDung, Email, SoDienThoai, GioiTinh, NgaySinh, MatKhau, QuyenHan)
values
('ND001', null, N'Nguyễn Văn A', N'nguyenvana@example.com', '0912345678', N'Nam', '1990-01-01', 'password123', N'Khách'),
('ND002', null, N'Trần Thị B', N'tranthib@example.com', '0912345679', N'Nữ', '1992-02-02', 'password456', N'Khách'),
('ND003', null, N'Lê Minh C', N'leminhc@example.com', '0912345680', N'Nam', '1994-03-03', 'password789', N'Khách'),
('ND004', null, N'Phan Mai D', N'phanmaid@example.com', '0912345681', N'Nữ', '1996-04-04', 'password012', N'Khách'),
('ND005', null, N'Ngô Anh E', N'ngoanhe@example.com', '0912345682', N'Nam', '1998-05-05', 'password345', N'Khách');

insert into LoaiSuKien (IDLoaiSuKien, TenLoai, MoTa)
values
('LSK001', N'Hội nghị', N'Sự kiện tập trung thảo luận, chia sẻ về các vấn đề cụ thể'),
('LSK002', N'Hội thảo', N'Sự kiện trao đổi thông tin, kiến thức về một chủ đề'),
('LSK003', N'Buổi hòa nhạc', N'Chương trình âm nhạc, biểu diễn nghệ thuật'),
('LSK004', N'Lễ hội', N'Sự kiện lớn, bao gồm các hoạt động văn hóa, giải trí'),
('LSK005', N'Workshop', N'Sự kiện thực hành, chia sẻ kiến thức và kỹ năng thực tế');


-- Thêm sự kiện với ngân sách dự kiến
INSERT INTO SuKien (IDSuKien, IDLoaiSuKien, HinhAnh, HoTenNguoiTao, Email, SoDienThoai, TenSuKien, ThoiGianToChuc, ThoiGianKetThuc, SoLuongKhachDuKien, NganSachDuKien, DiaDiem, MoTaSuKien, KieuSuKien, TrangThaiSuKien)
VALUES
('SK001', 'LSK001', 'HoiNghiCongNghe2024.jpg', N'Nguyễn Văn A', N'nguyenvana@example.com', '0912345678', N'Hội nghị Công nghệ 2024', '2024-06-01 09:00:00', '2024-06-01 17:00:00', 300, 5000000.00, N'Hà Nội', N'Hội nghị về xu hướng công nghệ mới', N'Xu hướng', N'Chờ xác nhận'),
('SK002', 'LSK001', 'HoiNghiMarketing.jpg', N'Trần Thị B', N'tranthib@example.com', '0912345679', N'Hội nghị Marketing', '2024-07-01 08:00:00', '2024-07-01 16:00:00', 500, 7000000.00, N'TP.HCM', N'Hội nghị về các chiến lược Marketing hiện đại', N'Thường', N'Chờ xác nhận'),
('SK003', 'LSK002', 'HoiThaoDigitalMarketing.jpg', N'Lê Minh C', N'leminhc@example.com', '0912345680', N'Hội thảo Digital Marketing', '2024-08-01 09:00:00', '2024-08-01 18:00:00', 150, 3000000.00, N'Đà Nẵng', N'Hội thảo về xu hướng Digital Marketing', N'Thường', N'Chờ xác nhận'),
('SK004', 'LSK003', 'BuoiHoaNhacMuaHe.jpg', N'Phan Mai D', N'phanmaid@example.com', '0912345681', N'Buổi hòa nhạc Mùa hè', '2024-06-15 18:00:00', '2024-06-15 22:00:00', 200, 4000000.00, N'Hà Nội', N'Chương trình âm nhạc mùa hè đặc sắc', N'Đặc biệt', N'Chờ xác nhận'),
('SK005', 'LSK004', 'LeHoiAmNhacQuocTe.jpg', N'Ngô Anh E', N'ngoanhe@example.com', '0912345682', N'Lễ hội âm nhạc quốc tế', '2024-09-01 15:00:00', '2024-09-01 23:00:00', 1000, 15000000.00, N'TP.HCM', N'Lễ hội âm nhạc lớn với sự tham gia của nhiều nghệ sĩ quốc tế', N'Xu hướng', N'Chờ xác nhận'),
('SK006', 'LSK004', 'LeHoiAmNhacQuocTe2.jpg', N'Ngô Anh E', N'ngoanhe@example.com', '0912345682', N'Lễ hội âm nhạc quốc tế', '2024-09-01 15:00:00', '2024-09-01 23:00:00', 1000, 15000000.00, N'TP.HCM', N'Lễ hội âm nhạc lớn với sự tham gia của nhiều nghệ sĩ quốc tế', N'Xu hướng', N'Chưa bắt đầu'),
('SK007', 'LSK001', 'HoiNghiCongNgheAI.jpg', N'Nguyễn Văn A', N'nguyenvana@example.com', '0912345678', N'Hội nghị Công nghệ AI', '2024-06-10 09:00:00', '2024-06-10 17:00:00', 300, 6000000.00, N'Hà Nội', N'Hội nghị về trí tuệ nhân tạo', N'Xu hướng', N'Chưa bắt đầu'),
('SK008', 'LSK001', 'HoiNghiMarketingOnline.jpg', N'Trần Thị B', N'tranthib@example.com', '0912345679', N'Hội nghị Marketing Online', '2024-07-10 08:00:00', '2024-07-10 16:00:00', 500, 7500000.00, N'TP.HCM', N'Hội nghị về marketing trực tuyến', N'Thường', N'Chưa bắt đầu'),
('SK009', 'LSK001', 'HoiNghiKinhTeQuocTe.jpg', N'Lê Minh C', N'leminhc@example.com', '0912345680', N'Hội nghị Kinh tế Quốc tế', '2024-08-05 09:00:00', '2024-08-05 17:00:00', 250, 6000000.00, N'Đà Nẵng', N'Hội nghị về nền kinh tế toàn cầu', N'Đặc sắc', N'Chờ xác nhận'),
('SK010', 'LSK001', 'HoiNghiDuLich.jpg', N'Phan Mai D', N'phanmaid@example.com', '0912345681', N'Hội nghị về Du lịch', '2024-09-01 09:00:00', '2024-09-01 17:00:00', 400, 5000000.00, N'Hà Nội', N'Hội nghị về phát triển du lịch bền vững', N'Xu hướng', N'Chờ xác nhận'),
('SK011', 'LSK001', 'HoiNghiBaoVeMoiTruong.jpg', N'Ngô Anh E', N'ngoanhe@example.com', '0912345682', N'Hội nghị Về Bảo vệ Môi Trường', '2024-10-01 09:00:00', '2024-10-01 17:00:00', 600, 8000000.00, N'TP.HCM', N'Hội nghị chia sẻ các giải pháp bảo vệ môi trường', N'Đặc biệt', N'Chưa bắt đầu'),
('SK012', 'LSK002', 'HoiThaoPhatTrienBanThan.jpg', N'Nguyễn Văn A', N'nguyenvana@example.com', '0912345678', N'Hội thảo Phát triển bản thân', '2024-07-05 09:00:00', '2024-07-05 17:00:00', 200, 3500000.00, N'Hà Nội', N'Hội thảo về phát triển bản thân', N'Xu hướng', N'Chưa bắt đầu'),
('SK013', 'LSK002', 'HoiThaoDigitalMarketing2.jpg', N'Trần Thị B', N'tranthib@example.com', '0912345679', N'Hội thảo Digital Marketing', '2024-07-15 09:00:00', '2024-07-15 18:00:00', 150, 4000000.00, N'TP.HCM', N'Hội thảo chia sẻ chiến lược Digital Marketing', N'Thường', N'Chưa bắt đầu'),
('SK014', 'LSK002', 'HoiThaoBigData.jpg', N'Lê Minh C', N'leminhc@example.com', '0912345680', N'Hội thảo về Big Data', '2024-08-01 09:00:00', '2024-08-01 17:00:00', 100, 5000000.00, N'Đà Nẵng', N'Hội thảo chia sẻ kiến thức về Big Data', N'Đặc sắc', N'Chưa bắt đầu'),
('SK015', 'LSK002', 'HoiThaoAI.jpg', N'Phan Mai D', N'phanmaid@example.com', '0912345681', N'Hội thảo về AI', '2024-09-01 09:00:00', '2024-09-01 17:00:00', 250, 6000000.00, N'Hà Nội', N'Hội thảo chia sẻ về ứng dụng AI', N'Xu hướng', N'Chờ xác nhận'),
('SK016', 'LSK002', 'HoiThaoPhatTrienStartup.jpg', N'Ngô Anh E', N'ngoanhe@example.com', '0912345682', N'Hội thảo Phát triển Startup', '2024-10-01 09:00:00', '2024-10-01 17:00:00', 500, 7000000.00, N'TP.HCM', N'Hội thảo chia sẻ kinh nghiệm phát triển startup', N'Đặc biệt', N'Chờ xác nhận'),
('SK017', 'LSK003', 'BuoiHoaNhacMuaHe2024.jpg', N'Nguyễn Văn A', N'nguyenvana@example.com', '0912345678', N'Buổi hòa nhạc Mùa hè 2024', '2024-06-20 18:00:00', '2024-06-20 22:00:00', 300, 4500000.00, N'Hà Nội', N'Chương trình âm nhạc mùa hè', N'Đặc biệt', N'Chờ xác nhận'),
('SK018', 'LSK003', 'BuoiHoaNhacQuocTe.jpg', N'Trần Thị B', N'tranthib@example.com', '0912345679', N'Buổi hòa nhạc Quốc tế', '2024-07-15 18:00:00', '2024-07-15 22:00:00', 500, 7000000.00, N'Đà Nẵng', N'Buổi hòa nhạc quốc tế với các nghệ sĩ nổi tiếng', N'Đặc sắc', N'Chưa bắt đầu'),
('SK019', 'LSK003', 'BuoiHoaNhacRock.jpg', N'Lê Minh C', N'leminhc@example.com', '0912345680', N'Buổi hòa nhạc Rock', '2024-08-05 18:00:00', '2024-08-05 22:00:00', 600, 8000000.00, N'Đà Nẵng', N'Buổi hòa nhạc Rock với các ban nhạc quốc tế', N'Đặc sắc', N'Chờ xác nhận'),
('SK020', 'LSK003', 'BuoiHoaNhacPop.jpg', N'Phan Mai D', N'phanmaid@example.com', '0912345681', N'Buổi hòa nhạc Pop', '2024-09-10 18:00:00', '2024-09-10 22:00:00', 700, 9000000.00, N'Hà Nội', N'Buổi hòa nhạc Pop với các nghệ sĩ nổi tiếng', N'Xu hướng', N'Chờ xác nhận'),
('SK021', 'LSK003', 'BuoiHoaNhacAcoustic.jpg', N'Ngô Anh E', N'ngoanhe@example.com', '0912345682', N'Buổi hòa nhạc Acoustic', '2024-10-01 18:00:00', '2024-10-01 22:00:00', 200, 4000000.00, N'TP.HCM', N'Buổi hòa nhạc acoustic với các nghệ sĩ tài năng', N'Đặc biệt', N'Chưa bắt đầu'),
('SK022', 'LSK004', 'LeHoiAmNhacQuocTe.jpg', N'Nguyễn Văn A', N'nguyenvana@example.com', '0912345678', N'Lễ hội âm nhạc Quốc tế', '2024-09-10 15:00:00', '2024-09-10 23:00:00', 1000, 12000000.00, N'Hà Nội', N'Lễ hội âm nhạc với sự tham gia của nhiều nghệ sĩ quốc tế', N'Xu hướng', N'Chờ xác nhận'),
('SK023', 'LSK004', 'LeHoiAmNhacDacBiet.jpg', N'Trần Thị B', N'tranthib@example.com', '0912345679', N'Lễ hội âm nhạc Đặc biệt', '2024-10-01 15:00:00', '2024-10-01 23:00:00', 800, 10000000.00, N'TP.HCM', N'Lễ hội âm nhạc đặc biệt', N'Đặc sắc', N'Chưa bắt đầu'),
('SK024', 'LSK004', 'LeHoiDuongPho.jpg', N'Lê Minh C', N'leminhc@example.com', '0912345680', N'Lễ hội đường phố', '2024-11-01 15:00:00', '2024-11-01 23:00:00', 600, 8500000.00, N'Đà Nẵng', N'Lễ hội đường phố với các hoạt động giải trí', N'Xu hướng', N'Chờ xác nhận'),
('SK025', 'LSK004', 'LeHoiTruyenThong.jpg', N'Phan Mai D', N'phanmaid@example.com', '0912345681', N'Lễ hội truyền thống', '2024-12-01 15:00:00', '2024-12-01 23:00:00', 1000, 11000000.00, N'Hà Nội', N'Lễ hội truyền thống với các hoạt động văn hóa', N'Đặc biệt', N'Chờ xác nhận'),
('SK026', 'LSK004', 'LeHoiMuaDong.jpg', N'Ngô Anh E', N'ngoanhe@example.com', '0912345682', N'Lễ hội mùa đông', '2024-12-15 15:00:00', '2024-12-15 23:00:00', 1200, 13000000.00, N'TP.HCM', N'Lễ hội mùa đông với các hoạt động vui chơi giải trí', N'Xu hướng', N'Chưa bắt đầu');

insert into DangKyTaoSuKien (IDDangKy, IDNguoiDung, IDSuKien)
values
('DK001', 'ND001', 'SK001'),
('DK002', 'ND002', 'SK002'),
('DK003', 'ND003', 'SK003'),
('DK004', 'ND004', 'SK004'),
('DK005', 'ND005', 'SK005');

insert into Ve (IDVe, IDSuKien, LoaiVe, GiaVe, SoLuongVe, TrangThai)
values
('V001', 'SK001', N'VIP', 500000, 50, N'Còn vé'),
('V002', 'SK001', N'Thường', 200000, 200, N'Còn vé'),
('V003', 'SK002', N'VIP', 600000, 30, N'Còn vé'),
('V004', 'SK002', N'Thường', 250000, 300, N'Còn vé'),
('V005', 'SK003', N'VIP', 400000, 40, N'Còn vé'),
('V006', 'SK004', N'VIP', 500000, 50, N'Còn vé'),
('V007', 'SK005', N'Thường', 200000, 200, N'Còn vé'),
('V008', 'SK005', N'VIP', 600000, 30, N'Còn vé'),
('V009', 'SK006', N'Thường', 250000, 300, N'Còn vé'),
('V010', 'SK006', N'VIP', 400000, 40, N'Còn vé'),
('V011', 'SK007', N'VIP', 500000, 50, N'Còn vé'),
('V012', 'SK007', N'Thường', 200000, 200, N'Còn vé'),
('V013', 'SK008', N'VIP', 600000, 30, N'Còn vé'),
('V014', 'SK008', N'Thường', 250000, 300, N'Còn vé'),
('V015', 'SK009', N'VIP', 400000, 40, N'Còn vé'),
('V016', 'SK009', N'VIP', 500000, 50, N'Còn vé'),
('V017', 'SK010', N'Thường', 200000, 200, N'Còn vé'),
('V018', 'SK010', N'VIP', 600000, 30, N'Còn vé'),
('V019', 'SK011', N'Thường', 250000, 300, N'Còn vé'),
('V020', 'SK011', N'VIP', 400000, 40, N'Còn vé');

insert into GiaoDichThanhToan (IDGiaoDich, IDNguoiDung, TongSoVe, NgayThanhToan, TongTien, TrangThai)
values
('GD001', 'ND001', 2, '2024-06-01 10:00:00', 1000000, N'Đã thanh toán'),
('GD002', 'ND002', 3, '2024-07-01 14:00:00', 1500000, N'Đã thanh toán'),
('GD003', 'ND003', 1, '2024-08-01 09:30:00', 400000, N'Chưa thanh toán'),
('GD004', 'ND004', 4, '2024-06-15 19:00:00', 1000000, N'Chưa thanh toán'),
('GD005', 'ND005', 5, '2024-09-01 16:00:00', 2000000, N'Đã thanh toán');

insert into ChiTietGiaoDich (IDChiTietGiaoDich, IDGiaoDich, IDVe, SoLuong, GiaTien)
values
('CTGD001', 'GD001', 'V001', 1, 500000),
('CTGD002', 'GD001', 'V002', 1, 200000),
('CTGD003', 'GD002', 'V003', 1, 600000),
('CTGD004', 'GD002', 'V004', 2, 250000),
('CTGD005', 'GD003', 'V005', 1, 400000);

insert into NhomNhanVien (IDNhom, LoaiNhom, IDSuKien, SoLuongNhanVien, NhiemVu)
values
('NH001', N'Quản lý sự kiện', 'SK001', 1, N'Chỉ đạo và quản lý toàn bộ sự kiện'),
('NH002', N'Phó quản lý sự kiện', 'SK001', 2, N'Hỗ trợ điều phối và giám sát các hoạt động trong sự kiện'),
('NH003', N'Thành viên', 'SK001', 5, N'Hỗ trợ công tác tổ chức và thực hiện các công việc cụ thể trong sự kiện'),
('NH004', N'Quản lý chương trình', 'SK002', 1, N'Quản lý và điều phối các hoạt động chương trình'),
('NH005', N'Thành viên', 'SK002', 4, N'Hỗ trợ tổ chức buổi hội thảo và các hoạt động liên quan');

insert into NhanVien (IDNhanVien, IDNhom, HinhAnh, TenNhanVien, SoDienThoai, Email, QuyenHan)
values
('NV001', 'NH001', null, N'Nguyễn Văn K', '0912345690', N'nguyenvank@example.com', N'Trưởng nhóm'),
('NV002', 'NH002', null, N'Trần Minh L', '0912345691', N'tranminhl@example.com', N'Phó trưởng nhóm'),
('NV003', 'NH003', null, N'Lê Quốc M', '0912345692', N'lequocm@example.com', N'Thành viên'),
('NV004', 'NH004', null, N'Phan Quang N', '0912345693', N'phanquangn@example.com', N'Trưởng nhóm'),
('NV005', 'NH005', null, N'Ngô Hải O', '0912345694', N'ngohaiO@example.com', N'Thành viên');
