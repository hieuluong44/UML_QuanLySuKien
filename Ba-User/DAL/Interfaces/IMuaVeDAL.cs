using System;
using Model;

namespace DAL.Interfaces
{
    public interface IMuaVeDAL
    {
        bool CreateGiaoDichThanhToan(GiaoDichThanhToanModel giaoDichThanhToan);
    }
}
