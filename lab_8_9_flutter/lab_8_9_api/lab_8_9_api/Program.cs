using lab_8_9_api.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(o =>
{
    o.AddPolicy("_myAllowSpecificOrigins", p =>
    p.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

var mdfPath = Path.GetFullPath(
    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "..", "..", "..", "lab_8_9.mdf"));
var connectionString = builder.Configuration.GetConnectionString("lab_8_9_apiContext")!
    .Replace("|DataDirectory|", Path.GetDirectoryName(mdfPath)!);

builder.Services.AddDbContext<lab_8_9_apiContext>(options =>
    options.UseSqlServer(connectionString));

// Force-close any existing connections so the .mdf file is not locked on attach
try
{
    using var masterConn = new Microsoft.Data.SqlClient.SqlConnection(
        "Server=(localdb)\\mssqllocaldb;Database=master;Integrated Security=True");
    masterConn.Open();
    using var cmd = masterConn.CreateCommand();
    cmd.CommandText = @"
IF DB_ID(N'lab_8_9') IS NOT NULL
BEGIN
    ALTER DATABASE [lab_8_9] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    EXEC sp_detach_db N'lab_8_9';
END";
    cmd.ExecuteNonQuery();
}
catch { }

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("_myAllowSpecificOrigins");
app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseAuthorization();
app.MapControllers();

app.Run();