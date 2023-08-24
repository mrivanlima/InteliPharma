

using InteliPharma.API.Services;
using InteliPharma.API.Services.DBServices;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers(options =>
{
    options.ReturnHttpNotAcceptable = true;
}).AddXmlSerializerFormatters();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<IDbConn, DbConnection>();

builder.Services.AddScoped<INeighborhoodRepository, NeighborhoodRepository>();
builder.Services.AddScoped<IOperationNatureRepository, OperationNatureRepository>();
builder.Services.AddScoped<IOrderDeliveryRepository, OrderDeliveryRepository>();
builder.Services.AddScoped<IOrderPaymentRepository, OrderPaymentRepository>();
builder.Services.AddScoped<IOrderRepository, OrderRepository>();
builder.Services.AddScoped<IPaymentMethodRepository, PaymentMethodRepository>();
builder.Services.AddScoped<IPaymentRepository, PaymentRepository>();
builder.Services.AddScoped<IPharmaceuticalAdministrationRepository, PharmaceuticalAdministrationRepository>();
builder.Services.AddScoped<IPharmaceuticalFormRepository, PharmaceuticalFormRepository>();
builder.Services.AddScoped<IPrescriptionRepository, PrescriptionRepository>();
builder.Services.AddScoped<IPrescriptionTypeRepository, PrescriptionTypeRepository>();
builder.Services.AddScoped<IProductCartUserRepository, ProductCartUserRepository>();
builder.Services.AddScoped<IProductPurchaseRepository, ProductPurchaseRepository>();
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<IStateRepository, StateRepository>();




builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
