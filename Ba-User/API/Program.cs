﻿using DAL.Interfaces;
using DAL;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using BLL.Interfaces;
using BLL;
using DAL.Helper.Interfaces;
using DAL.Helper;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.WithOrigins("http://127.0.0.1:5500")  // Specify the allowed origin here
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});
builder.Services.AddControllers();
// Đăng ký DatabaseHelper
builder.Services.AddSingleton<DatabaseHelper>(); // Nếu `DatabaseHelper` không có trạng thái và bạn muốn sử dụng chung một đối tượng cho tất cả
                                                 // hoặc sử dụng AddScoped nếu bạn muốn mỗi request có một đối tượng mới
builder.Services.AddScoped<DatabaseHelper>();
// Cấu hình Swagger để tạo tài liệu API
// Add services to the container
builder.Services.AddControllers();
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>(); // Đăng ký dịch vụ `IDatabaseHelper` được triển khai bởi `DatabaseHelper`
builder.Services.AddTransient<ISuKienDAL, SuKienDAL>();
builder.Services.AddTransient<ISuKienBLL, SuKienBLL>();
builder.Services.AddTransient<ITaiKhoanBLL, TaiKhoanBLL>();
builder.Services.AddTransient<ITaiKhoanDAL, TaiKhoanDAL>();
builder.Services.AddTransient<IChiTietSuKienBLL, ChiTietSuKienBLL>();
builder.Services.AddTransient<IChiTietSuKienDAL, ChiTietSuKienDAL>();
builder.Services.AddTransient<IMuaVeBLL, MuaVeBLL>();
builder.Services.AddTransient<IMuaVeDAL, MuaVeDAL>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
app.UseCors("AllowAll");

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.Run();

