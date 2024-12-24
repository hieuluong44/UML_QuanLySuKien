using System;
using System.Collections.Generic;

namespace Model
{
    public class GiaoDichThanhToanModel
    {
        public string IDGiaoDich { get; set; } 
        public string IDNguoiDung { get; set; }
        public int TongSoVe {  get; set; }
        public DateTime NgayThanhToan { get; set; } = DateTime.Now;
        public decimal TongTien { get; set; } = 0;

        public string TrangThai { get; set; } = "Chờ thanh toán"; 
        public List<ChiTietGiaoDichModel> ListChiTietGiaoDich { get; set; } = new List<ChiTietGiaoDichModel>();
    }

    public class ChiTietGiaoDichModel
    {
        public string IDChiTietGiaoDich { get; set; } 
        public string IDGiaoDich { get; set; }
        public string IDVe { get; set; } 
        public int SoLuong { get; set; }
        public decimal GiaTien { get; set; }
    }
}
