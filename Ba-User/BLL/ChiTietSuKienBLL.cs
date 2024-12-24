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
    public class ChiTietSuKienBLL : IChiTietSuKienBLL
    {
        private IChiTietSuKienDAL chiTietMatHang;
        public ChiTietSuKienBLL(IChiTietSuKienDAL ChiTietMatHang)
        {
            this.chiTietMatHang = ChiTietMatHang;
        }

        public List<GetVeModel> getVeModels(string IDSuKien)
        {
            return chiTietMatHang.getVeModels(IDSuKien);
        }

        public get_SuKien Get_SuKien(string IDSuKien)
        {
            return chiTietMatHang.Get_SuKien(IDSuKien);
        }
    }
}
