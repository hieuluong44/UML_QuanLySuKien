using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public interface IChiTietSuKienBLL
    {
        List<GetVeModel> getVeModels(string IDSuKien);
        get_SuKien Get_SuKien(string IDSuKien);
    }
}
