using DAL.Helper;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;


namespace DAL
{
    public class ChiTietSuKienDAL : IChiTietSuKienDAL
    {
        private readonly IDatabaseHelper _databaseHelper;

        // Constructor để Dependency Injection
        public ChiTietSuKienDAL(IDatabaseHelper databaseHelper)
        {
            _databaseHelper = databaseHelper;
        }
        public List<GetVeModel> getVeModels(string IDSuKien)
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteSProcedureReturnDataTable(out msgError, "get_Ve",
                    "@IDSuKien", IDSuKien);

                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                return result.ConvertTo<GetVeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public get_SuKien Get_SuKien(string IDSuKien)
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteSProcedureReturnDataTable(out msgError, "get_SuKien",
                    "@IDSuKien", IDSuKien);

                if (!string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(msgError);
                }

                return result.ConvertTo<get_SuKien>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
