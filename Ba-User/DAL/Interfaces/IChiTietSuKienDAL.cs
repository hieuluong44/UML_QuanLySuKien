﻿using System;
using System.Collections.Generic;
using Model;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public interface IChiTietSuKienDAL
    {
        List<GetVeModel> getVeModels(string IDSuKien);
        get_SuKien Get_SuKien(string IDSuKien);
    }
}
