using BLL.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;
using System;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MuaVeControllers : ControllerBase
    {
        private readonly IMuaVeBLL _muaVeBLL;

        // Constructor để Dependency Injection
        public MuaVeControllers(IMuaVeBLL muaVeBLL)
        {
            _muaVeBLL = muaVeBLL;
        }

        [Route("Create")]
        [HttpPost]
        public ActionResult<GiaoDichThanhToanModel> CreateGiaoDichThanhToan([FromBody] GiaoDichThanhToanModel giaoDichThanhToan)
        {
            if (giaoDichThanhToan.ListChiTietGiaoDich != null)
            {
                foreach (var item in giaoDichThanhToan.ListChiTietGiaoDich)
                {
                    item.IDGiaoDich = giaoDichThanhToan.IDGiaoDich;
                }
            }

            try
            {
                var result = _muaVeBLL.CreateGiaoDichThanhToan(giaoDichThanhToan);

                if (result)
                {
                    return Ok(giaoDichThanhToan); 
                }
                else
                {
                    return BadRequest("Không thể tạo giao dịch thanh toán. Vui lòng thử lại."); 
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
