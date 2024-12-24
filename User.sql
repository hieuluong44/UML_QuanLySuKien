use BTL_UML_QuanLySuKien
go


/*sự kiện mua vé*/
create proc Mua_Ve 
    (@IDGiaoDich varchar(10),
     @IDNguoiDung varchar(10),
     @TongSoVe int,
     @NgayThanhToan datetime = getdate,  -- Sửa cú pháp gán giá trị mặc định cho ngày
     @TongTien decimal,
     @TrangThai nvarchar(20),
     @listjson_ChiTiet nvarchar(max)
	)
as	
begin
    
    insert into GiaoDichThanhToan (IDGiaoDich, IDNguoiDung, TongSoVe, NgayThanhToan, TongTien, TrangThai)
    values (@IDGiaoDich, @IDNguoiDung, @TongSoVe, @NgayThanhToan, @TongTien, @TrangThai);
    
    
    If(@listjson_ChiTiet is not null and len(@listjson_ChiTiet) > 0)
    begin 
        insert into ChiTietGiaoDich (IDChiTietGiaoDich, IDGiaoDich, IDVe, SoLuong, GiaTien)
        select 
            JSON_VALUE(p.value, '$.IDChiTietGiaoDich'),
            @IDGiaoDich, 
            JSON_VALUE(p.value, '$.IDVe'),
            JSON_VALUE(p.value, '$.SoLuong'),
            JSON_VALUE(p.value, '$.GiaTien')
        from openjson(@listjson_ChiTiet) as p;
    end;

    -- Thông báo thành công hoặc mã kết quả
    select 'Transaction completed successfully' as Message;
end;
go



/* Đăng ký tạo sự kiện có đăng nhập*/
ALTER procedure TaoSuKienDaDangNhap
    @IDSuKien varchar(10),
    @IDLoaiSuKien varchar(10),
    @HoTenNguoiTao nvarchar(50),
    @Email varchar(30),
    @SoDienThoai varchar(10),
    @TenSuKien nvarchar(100),
    @ThoiGianToChuc datetime,
    @ThoiGianKetThuc datetime,
    @SoLuongKhachDuKien int,
    @DiaDiem nvarchar(max),
    @MoTaSuKien nvarchar(max),
	@KieuSuKien nvarchar(50) = null,
    @TrangThaiSuKien nvarchar(20) = N'Chờ xác nhận', 
    @listjson_DangKy nvarchar(max) = null 
as
begin
  
    insert into SuKien (IDSuKien, IDLoaiSuKien, HoTenNguoiTao, Email, SoDienThoai, TenSuKien, 
                        ThoiGianToChuc, ThoiGianKetThuc, SoLuongKhachDuKien, DiaDiem, MoTaSuKien, KieuSuKien , TrangThaiSuKien)
    values (@IDSuKien, @IDLoaiSuKien, @HoTenNguoiTao, @Email, @SoDienThoai, @TenSuKien, 
            @ThoiGianToChuc, @ThoiGianKetThuc, @SoLuongKhachDuKien, @DiaDiem, @MoTaSuKien, @KieuSuKien , @TrangThaiSuKien);

        if(@listjson_DangKy is not null and len(@listjson_DangKy) > 0)
        begin
            insert into DangKyTaoSuKien (IDDangKy, IDNguoiDung, IDSuKien)
            select 
                JSON_VALUE(p.value, '$.IDDangKy'), 
                JSON_VALUE(p.value, '$.IDNguoiDung'), 
                @IDSuKien
            from openjson(@listjson_DangKy) as p;
        end;

    select 'Tạo sự kiện và yêu cầu đăng ký (nếu có) đã thành công' as Message;
end;
go


/*Đăng ký tạo sự kiện không đăng nhập*/
create procedure TaoSuKienKhongDangNhap
    @IDSuKien varchar(10),
    @IDLoaiSuKien varchar(10),
    @HinhAnh varchar(max) = null,
    @HoTenNguoiTao nvarchar(50),
    @Email varchar(30),
    @SoDienThoai varchar(10),
    @TenSuKien nvarchar(100),
    @ThoiGianToChuc datetime,
    @ThoiGianKetThuc datetime,
    @SoLuongKhachDuKien int,
	@NganSachDuKien decimal,
    @DiaDiem nvarchar(max),
    @MoTaSuKien nvarchar(max),
	@KieuSuKien nvarchar(50) = null,
    @TrangThaiSuKien nvarchar(20) = N'Chờ xác nhận' 
as
begin
    insert into SuKien (IDSuKien, IDLoaiSuKien, HinhAnh, HoTenNguoiTao, Email, SoDienThoai, TenSuKien, 
                        ThoiGianToChuc, ThoiGianKetThuc, SoLuongKhachDuKien, NganSachDuKien, DiaDiem, MoTaSuKien, KieuSuKien, TrangThaiSuKien)
    values (@IDSuKien, @IDLoaiSuKien, @HinhAnh, @HoTenNguoiTao, @Email, @SoDienThoai, @TenSuKien, 
            @ThoiGianToChuc, @ThoiGianKetThuc, @SoLuongKhachDuKien, @NganSachDuKien,  @DiaDiem, @MoTaSuKien, @KieuSuKien, @TrangThaiSuKien);
end;
go


/* Lấy thông tin sự kiện đặc biêt*/
alter procedure HienThi_SuKien_DacBiet
as
begin
    select SK.IDSuKien, 
           SK.TenSuKien, 
           SK.HinhAnh, 
           SK.ThoiGianToChuc, 
           SK.ThoiGianKetThuc, 
           SK.DiaDiem,
           COALESCE(MIN(V.GiaVe), 0) as GiaVe  -- Thay NULL bằng 0 nếu không có vé
    from SuKien SK
    left join Ve V on SK.IDSuKien = V.IDSuKien
    where SK.KieuSuKien like N'Đặc biệt'
      and (SK.TrangThaiSuKien = N'Chưa bắt đầu' or SK.TrangThaiSuKien = N'Đang diễn ra')
    group by SK.IDSuKien, 
             SK.TenSuKien, 
             SK.HinhAnh, 
             SK.ThoiGianToChuc, 
             SK.ThoiGianKetThuc, 
             SK.DiaDiem
    order by GiaVe asc;
end;



/* Lấy thông tin sự kiện xu hướng*/
alter procedure HienThi_SuKien_XuHuong
as
begin
    select SK.IDSuKien, 
           SK.TenSuKien, 
           SK.HinhAnh, 
           SK.ThoiGianToChuc, 
           SK.ThoiGianKetThuc, 
           SK.DiaDiem, 
           COALESCE(MIN(V.GiaVe), 0) as GiaVe  
    from SuKien SK
    left join Ve V on SK.IDSuKien = V.IDSuKien
    where SK.KieuSuKien like N'Xu hướng'
      and (SK.TrangThaiSuKien = N'Chưa bắt đầu' or SK.TrangThaiSuKien = N'Đang diễn ra')
    group by SK.IDSuKien, 
             SK.TenSuKien, 
             SK.HinhAnh, 
             SK.ThoiGianToChuc, 
             SK.ThoiGianKetThuc, 
             SK.DiaDiem
    order by GiaVe asc;  
end;


/* Lấy thông tin sự kiện đặc sắc*/
alter procedure HienThi_SuKien_DacSac
as
begin
    select SK.IDSuKien, 
           SK.TenSuKien, 
           SK.HinhAnh, 
           SK.ThoiGianToChuc, 
           SK.ThoiGianKetThuc, 
           SK.DiaDiem, 
           min(V.GiaVe) as GiaVe
    from SuKien SK
    left join Ve V on SK.IDSuKien = V.IDSuKien
    where SK.KieuSuKien like N'Đặc sắc'
      or (SK.TrangThaiSuKien = N'Chưa bắt đầu' or SK.TrangThaiSuKien = N'Đang diễn ra')
    group by SK.IDSuKien, 
             SK.TenSuKien, 
             SK.HinhAnh, 
             SK.ThoiGianToChuc, 
             SK.ThoiGianKetThuc, 
             SK.DiaDiem
    order by GiaVe asc;  
end;
go




/* lấy thông tin chi tiết từng sự kiện*/
create proc get_Ve 
	@IDSuKien varchar(10)
as
begin 
	select * from Ve where IDSuKien = @IDSuKien
end;
go

alter proc get_SuKien 
	@IDSuKien varchar(10)
as
begin
	select SK.IDSuKien, 
           SK.TenSuKien, 
           SK.HinhAnh, 
           SK.ThoiGianToChuc, 
           SK.ThoiGianKetThuc, 
           SK.DiaDiem, 
		   SK.MoTaSuKien,
           COALESCE(MIN(V.GiaVe), 0) as GiaVe  
    from SuKien SK
    left join Ve V on SK.IDSuKien = V.IDSuKien
	where SK.IDSuKien = @IDSuKien
	group by SK.IDSuKien, 
             SK.TenSuKien, 
             SK.HinhAnh, 
             SK.ThoiGianToChuc, 
             SK.ThoiGianKetThuc, 
             SK.DiaDiem,
			 SK.MoTaSuKien
    order by GiaVe asc;  
end;
go

	


