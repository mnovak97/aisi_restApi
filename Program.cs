using Microsoft.EntityFrameworkCore;
using RestApi.Context;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddControllers(opt => opt.SuppressAsyncSuffixInActionNames = false);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddEntityFrameworkNpgsql().AddDbContext<DatabaseContext>(opt => opt.UseNpgsql(builder.Configuration.GetConnectionString("MyConnectionString")));

var app = builder.Build();


if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

