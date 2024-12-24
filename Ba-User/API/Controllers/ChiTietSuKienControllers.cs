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
    public class ChiTietSuKienControllers : ControllerBase
    {
        private readonly IChiTietSuKienBLL chiTietSuKienBLL;
        public ChiTietSuKienControllers(IChiTietSuKienBLL chiTietSuKien)
        {
            chiTietSuKienBLL = chiTietSuKien;
        }
        [Route("GetChiTiet_SuKien/{IDSuKien}")]
        [HttpGet]
        public get_SuKien Get_SuKien(string IDSuKien)
        {
            return chiTietSuKienBLL.Get_SuKien(IDSuKien);
        }
        [Route("Get_Ve/{IDSuKien}")]
        [HttpGet]
        public List<GetVeModel> getVeModels(string IDSuKien)
        {
            return chiTietSuKienBLL.getVeModels(IDSuKien);
        }
    }
}
