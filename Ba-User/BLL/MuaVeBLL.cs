using BLL.Interfaces;
using DAL.Interfaces;
using Model;
using System;

namespace BLL
{
    public class MuaVeBLL : IMuaVeBLL
    {
        private readonly IMuaVeDAL _muaVeDAL;

        public MuaVeBLL(IMuaVeDAL muaVeDAL)
        {
            _muaVeDAL = muaVeDAL;
        }

        public bool CreateGiaoDichThanhToan(GiaoDichThanhToanModel giaoDichThanhToan)
        {
            try
            {
                return _muaVeDAL.CreateGiaoDichThanhToan(giaoDichThanhToan);
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
