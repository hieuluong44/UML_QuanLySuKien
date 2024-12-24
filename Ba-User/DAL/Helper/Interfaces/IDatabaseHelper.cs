﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Helper.Interfaces
{
    public class StoreParameterInfo
    {
        public string StoreProceduceName { get; set; }
        public List<Object> StoreProcedureParams { get; set; }
    }
    public interface IDatabaseHelper
    {
        void SetConnectionString(string connectionString);
        string OpenConnection();
        string CloseConnection();
        string ExecuteNoneQuery(string strQuery, string v);
        DataTable ExecuteQueryToDataTable(string strQuery, out string msgError);
        object ExecuteScalar(string strQuery, out string msgError);

        #region Execute StoreProcedure

        /// <summary>
        /// Execute Procedure None Query
        /// </summary>
        /// <param name="sprocedureName">Store Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>String.Empty when run query success or Message Error when run query happen issue</returns>
        string ExecuteSProcedure(string sprocedureName, params object[] paramObjects);
        /// <summary>
        /// Execute Procedure return DataTale
        /// </summary>
        /// <param name="msgError">String.Empty when run query success or Message Error when run query happen issue</param>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>Table result</returns>
        DataTable ExecuteSProcedureReturnDataTable(out string msgError, string sprocedureName, params object[] paramObjects);
        /// <summary>
        ///  Execute Scalar Procedure query
        /// </summary>
        /// <param name="msgError">String.Empty when run query success or Message Error when run query happen issue</param>
        /// <param name="strConnectionString">Connection String use to connect to PostGresDB</param>
        /// <param name="sprocedureName">Procedure Name</param>
        /// <param name="paramObjects">List Param Objects, Each Item include 'ParamName' and 'ParamValue'</param>
        /// <returns>Value return from Store</returns>
        object ExecuteScalarSProcedure(out string msgError, string sprocedureName, params object[] paramObjects);
        object ExecuteScalarSProcedureWithTransaction(string v1, string v2, string iDDonBan, string v3, string iDNguoiDung, string v4, string hoTenNguoiNhan, string v5, string soDienThoaiNguoiNhan, string v6, string diaChiNguoiNhan, string v7, string v, DateTime ngayBan, string v8, string trangThai, string v9, string ghiChu, string v10, decimal tongTien, string v11, string? v12);
        object ExecuteScalarSProcedureWithTransaction(string v1, string v2, string iDDonBan, string v3, string iDNguoiDung, string v4, string hoTenNguoiNhan, string v5, string soDienThoaiNguoiNhan, string v6, string diaChiNguoiNhan, string v7, DateTime ngayBan, string v8, string trangThai, string v9, string ghiChu, string v10, decimal tongTien, string v11, string? v12);
        #endregion
    }
}
