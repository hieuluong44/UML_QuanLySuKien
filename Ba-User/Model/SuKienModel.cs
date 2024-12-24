using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Model
{
    public class HienThi_SuKien
    {
        public string IDSuKien { get; set; }
        public string TenSuKien { get; set; }
        public string HinhAnh { get; set; }
        public DateTime ThoiGianToChuc { get; set; }
        public DateTime ThoiGianKetThuc { get; set; }
        public string DiaDiem { get; set; }
        public decimal GiaVe {  get; set; }
    }
    public class TaoSuKien_KhongDangNhap
    {
        public string IDSuKien { get; set; }
        public string IDLoaiSuKien { get; set; }
        public string HinhAnh { get; set; } 
        public string HoTenNguoiTao {  get; set; }
        public string Email { get; set; }
        public string SoDienThoai { get; set; }
        public string TenSuKien { get; set; }
        public DateTime ThoiGianToChuc { get; set; }
        public DateTime ThoiGianKetThuc { get; set; }
        public int SoLuongKhachDuKien { get; set; }
        public decimal NganSachDuKien { get; set; }
        public string DiaDiem { get; set; }
        public string MoTaSuKien { get; set; }
        public string KieuSuKien { get; set; }
        public string TrangThaiSuKien { get; set; }
    }
}
