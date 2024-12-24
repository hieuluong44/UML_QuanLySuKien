using BLL.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SuKienBLL : ISuKienBLL
    {
        private ISuKienDAL suKienDAL;
        public SuKienBLL(ISuKienDAL suKien)
        {
            this.suKienDAL = suKien;
        }

        public List<HienThi_SuKien> hienThi_SuKiens_DacBiet()
        {
            return suKienDAL.hienThi_SuKiens_DacBiet();
        }
        public List<HienThi_SuKien> hienThi_SuKiens_XuHuong()
        {
            return suKienDAL.hienThi_SuKiens_XuHuong();
        }
        public List<HienThi_SuKien> hienThi_SuKiens_DacSac()
        {
            return suKienDAL.hienThi_SuKiens_DacSac();
        }

        public bool TaoSuKien_KhongDangNhap(TaoSuKien_KhongDangNhap taoSuKien_KhongDangNhap)
        {
            return suKienDAL.TaoSuKien_KhongDangNhap(taoSuKien_KhongDangNhap);
        }
    }
}
