using System;
using System.Collections.Generic;
using Model;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class GetVeModel
    {
        public string IDVe {  get; set; }
        public string IDSuKien { get; set; }
        public string LoaiVe { get; set; }
        public decimal GiaVe { get; set; }
        public int SoLuongVe { get; set; }
        public string TrangThai { get; set; }
    }
    public class get_SuKien
    {
        public string IDSuKien { get; set; }
        public string HinhAnh { get; set; }
        public string TenSuKien { get; set; }
        public DateTime ThoiGianToChuc { get; set; }
        public DateTime ThoiGianKetThuc { get; set; }
        public string DiaDiem { get; set; }
        public string MoTaSuKien { get; set; }
        public decimal GiaVe { get; set; }

    }
}
