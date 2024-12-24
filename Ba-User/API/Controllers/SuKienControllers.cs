using BLL.Interfaces;
using BLL;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;
using System.Numerics;
using DAL;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SuKienControllers : ControllerBase
    {
        private readonly ISuKienBLL suKienBLL;
        public SuKienControllers(ISuKienBLL suKien)
        {
            suKienBLL = suKien;
        }
        [Route("HienThi_SuKien_DacBiet")]
        [HttpGet]
        public List<HienThi_SuKien> hienThi_SuKiens_DacBiet()
        {
            return suKienBLL.hienThi_SuKiens_DacBiet();
        }

        [Route("HienThi_SuKien_XuHuong")]
        [HttpGet]
        public List<HienThi_SuKien> hienThi_SuKiens_XuHuong()
        {
            return suKienBLL.hienThi_SuKiens_XuHuong();
        }

        [Route("HienThi_SuKien_DacSac")]
        [HttpGet]
        public List<HienThi_SuKien> hienThi_SuKiens_DacSac()
        {
            return suKienBLL.hienThi_SuKiens_DacSac();
        }

        [Route("TaoSuKien_KhongDangNhap")]
        [HttpPost]
        public bool TaoSuKien_KhongDangNhap(TaoSuKien_KhongDangNhap taoSuKien_KhongDangNhap)
        {
            return suKienBLL.TaoSuKien_KhongDangNhap(taoSuKien_KhongDangNhap);
        }

    }
}
