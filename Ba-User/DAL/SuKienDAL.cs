using DAL.Helper;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;

namespace DAL
{
    public class SuKienDAL : ISuKienDAL
    {
        private readonly IDatabaseHelper _databaseHelper;

        public SuKienDAL(IDatabaseHelper databaseHelper)
        {
            _databaseHelper = databaseHelper;
        }

        public List<HienThi_SuKien> hienThi_SuKiens_DacBiet()
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteSProcedureReturnDataTable(out msgError, "HienThi_SuKien_DacBiet");

                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                return result.ConvertTo<HienThi_SuKien>().ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<HienThi_SuKien> hienThi_SuKiens_XuHuong()
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteSProcedureReturnDataTable(out msgError, "HienThi_SuKien_XuHuong");

                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                return result.ConvertTo<HienThi_SuKien>().ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public List<HienThi_SuKien> hienThi_SuKiens_DacSac()
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteSProcedureReturnDataTable(out msgError, "HienThi_SuKien_DacSac");

                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                return result.ConvertTo<HienThi_SuKien>().ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool TaoSuKien_KhongDangNhap(TaoSuKien_KhongDangNhap suKien)
        {
            try
            {
                var result = _databaseHelper.ExecuteSProcedure("TaoSuKienKhongDangNhap",
                    "@IDSuKien", suKien.IDSuKien,
                    "@IDLoaiSuKien", suKien.IDLoaiSuKien,
                    "@HinhAnh", suKien.HinhAnh ?? (object)DBNull.Value,
                    "@HoTenNguoiTao", suKien.HoTenNguoiTao,
                    "@Email", suKien.Email,
                    "@SoDienThoai", suKien.SoDienThoai,
                    "@TenSuKien", suKien.TenSuKien,
                    "@ThoiGianToChuc", suKien.ThoiGianToChuc,
                    "@ThoiGianKetThuc", suKien.ThoiGianKetThuc,
                    "@SoLuongKhachDuKien", suKien.SoLuongKhachDuKien,
                    "@NganSachDuKien", suKien.NganSachDuKien,
                    "@DiaDiem", suKien.DiaDiem,
                    "@MoTaSuKien", suKien.MoTaSuKien,
                    "@KieuSuKien", suKien.KieuSuKien ?? (object)DBNull.Value,
                    "@TrangThaiSuKien", suKien.TrangThaiSuKien ?? "Chờ xác nhận");

                if (result != null && !string.IsNullOrEmpty(result.ToString()))
                {
                    throw new Exception($"Lỗi khi thực thi stored procedure: {result.ToString()}");
                }

                return true;
            }
            catch (Exception ex)
            {
                throw new Exception($"Có lỗi khi tạo sự kiện với IDSuKien: {suKien.IDSuKien}", ex);
            }
        }
    }
}
