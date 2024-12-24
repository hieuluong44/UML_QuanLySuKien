using Model;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface ISuKienBLL
    {
        List<HienThi_SuKien> hienThi_SuKiens_DacBiet();
        List<HienThi_SuKien> hienThi_SuKiens_XuHuong();
        List<HienThi_SuKien> hienThi_SuKiens_DacSac();
        bool TaoSuKien_KhongDangNhap(TaoSuKien_KhongDangNhap taoSuKien_KhongDangNhap);

    }
}
