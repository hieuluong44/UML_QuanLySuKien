using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Model;
using System;

namespace DAL
{
    public class MuaVeDAL : IMuaVeDAL
    {
        private readonly IDatabaseHelper _databaseHelper;

        public MuaVeDAL(IDatabaseHelper databaseHelper)
        {
            _databaseHelper = databaseHelper;
        }

        // Phương thức tạo GiaoDichThanhToan cùng với ChiTietGiaoDich
        public bool CreateGiaoDichThanhToan(GiaoDichThanhToanModel giaoDichThanhToan)
        {
            try
            {
                // Gọi stored procedure để tạo GiaoDichThanhToan
                var result = _databaseHelper.ExecuteSProcedure("Mua_Ve",
                    "@IDGiaoDich", giaoDichThanhToan.IDGiaoDich,
                    "@IDNguoiDung", giaoDichThanhToan.IDNguoiDung ?? (object)DBNull.Value,
                    "TongSoVe", giaoDichThanhToan.TongSoVe,
                    "@NgayThanhToan", giaoDichThanhToan.NgayThanhToan,
                    "@TongTien", giaoDichThanhToan.TongTien,
                    "@TrangThai", giaoDichThanhToan.TrangThai ?? "Chưa thanh toán",
                    "@listChiTietGiaoDich", giaoDichThanhToan.ListChiTietGiaoDich?.Count > 0
                        ? MessageConvert.SerializeObject(giaoDichThanhToan.ListChiTietGiaoDich)
                        : null);

                // Kiểm tra kết quả trả về có lỗi không
                if (result != null && !string.IsNullOrEmpty(result.ToString()))
                {
                    throw new Exception($"Lỗi khi thực thi stored procedure: {result.ToString()}");
                }

                return true;
            }
            catch (Exception ex)
            {
                throw new Exception($"Có lỗi khi tạo giao dịch với IDGiaoDich: {giaoDichThanhToan.IDGiaoDich}", ex);
            }
        }
    }
}
