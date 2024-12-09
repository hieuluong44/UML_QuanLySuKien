create database BTL_UML_QuanLySuKien
use BTL_UML_QuanLySuKien
go

-- Bảng Người dùng
create table NguoiDung (
    IDNguoiDung varchar(10) primary key not null,
    TenNguoiDung nvarchar(50) not null,
    Email varchar(50) not null unique,
    SoDienThoai varchar(10) not null unique,
    GioiTinh nvarchar(10) not null,
    MatKhau varchar(20) not null,
    TenCongTy nvarchar(100) null, 
    DiaChiCongTy nvarchar(200) null,
	QuyDinh nvarchar(20) null check (QuyDinh in (N'Khách mời', N'Khách thường')),
	LoaiNguoiDung nvarchar(20) not null check (LoaiNguoiDung in (N'Cá nhân', N'Công ty', N'Quản trị'))
);
go

-- Bảng nhà tài trợ
create table NhaTaiTro (
    IDNhaTaiTro varchar(10) primary key not null, 
    TenNhaTaiTro nvarchar(100) not null,
    Email varchar(50) not null unique, 
    SoDienThoai varchar(10) not null unique,
    DiaChi nvarchar(200) null, 
    GhiChu nvarchar(200) null 
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
	IDNguoiDung varchar(10) foreign key references NguoiDung(IDNguoiDung) null,
    TenSuKien nvarchar(100) not null,
	PhanLoai nvarchar(20) null check (PhanLoai in (N'Nội bộ', N'Khách thuê')),
    ThoiGianToChuc datetime not null,
    ThoiGianKetThuc datetime not null,
    SoLuongKhachDuKien int not null,
    DoTuoiThamGia nvarchar(50) not null,  
    DiaDiem nvarchar(max) not null,
    MucDich nvarchar(50) not null,
	QuyDinh nvarchar(20) not null check (QuyDinh in (N'Phải mua vé', N'Không phải mua vé')),
	TrangThaiSuKien nvarchar(20) default N'Chờ xác nhận' check (TrangThaiSuKien in (N'Chờ xác nhận',N'Đã xác nhận' ,N'Chưa bắt đầu', N'Đang diễn ra', N'Hoàn thành', N'Hủy')));
go

-- Bảng tài trợ
create table PhieuTaiTroSuKien (
    IDTaiTro varchar(10) primary key not null, 
    IDNhaTaiTro varchar(10) foreign key references NhaTaiTro(IDNhaTaiTro) not null, 
    IDSuKien varchar(10) foreign key references SuKien(IDSuKien) not null,
    SoTienTaiTro float not null, 
    NgayTaiTro datetime default getdate() not null
);
go

-- Bảng Vé
create table Ve (
    IDVe varchar(10) primary key not null,
    IDSuKien varchar(10) not null foreign key references SuKien(IDSuKien),
    LoaiVe nvarchar(10) not null,
    GiaVe float default 0 not null,
	ViTriNgoi nvarchar(10) null,
);
go

-- Bảng Thanh toán
create table ThanhToan (
    IDThanhToan varchar(10) primary key not null,
    IDVe varchar(10) foreign key references Ve(IDVe) not null,
    IDNguoiDung varchar(10) foreign key references NguoiDung(IDNguoiDung) not null,
    NgayThanhToan datetime default getdate() not null,
    TienThanhToan float default 0 not null,
    TrangThai nvarchar(20) not null  check (TrangThai in (N'Chưa thanh toán', N'Đã thanh toán'))
);
go

-- Bảng nhom nhân viên
create table NhomNhanVien (
	IDNhom varchar(10) primary key not null,
	LoaiNhom nvarchar(10) not null,
	IDSuKien varchar(10) foreign key references SuKien(IDSuKien) null,
	SoLuongNhanVien int default 0,
	NhiemVu nvarchar(50) not null,
);
go

-- Bảng Nhân viên
create table NhanVien (
    IDNhanVien varchar(10) primary key not null,
	IDNhom varchar(10) foreign key references NhomNhanVien(IDNhom) not null,
    TenNhanVien nvarchar(50) not null,
    SoDienThoai varchar(10) not null unique ,
    Email varchar(50) not null unique ,
);
go

-- Bảng Phản hồi
create table PhanHoi (
    IDPhanHoi varchar(10) primary key not null,
    IDSuKien varchar(10) foreign key references SuKien(IDSuKien) not null,
    IDNguoiDung varchar(10) foreign key references NguoiDung(IDNguoiDung) not null,
    DanhGia int not null,
    NhanXet nvarchar(200) null,
	ThoiGianPhanHoi datetime default getdate() not null
);
go


DROP TABLE IF EXISTS PhanHoi;
DROP TABLE IF EXISTS ThanhToan;
DROP TABLE IF EXISTS NhanVien;
DROP TABLE IF EXISTS Ve;
DROP TABLE IF EXISTS TaiTroSuKien;
DROP TABLE IF EXISTS SuKien;
DROP TABLE IF EXISTS LoaiSuKien;
DROP TABLE IF EXISTS NhaTaiTro;
DROP TABLE IF EXISTS NhomNhanVien;
DROP TABLE IF EXISTS NguoiDung;
GO


