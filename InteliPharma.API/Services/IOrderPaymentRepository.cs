using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IOrderPaymentRepository
    {
        Task<OrderPayment> CreateOrderPaymentAsync(OrderPayment orderPayment);
        Task<IEnumerable<OrderPayment>> GetAllOrdersPaymentAsync();
        Task<OrderPayment> GetOrderPaymentAsyncById(long orderPaymentId);
        Task<OrderPayment> UpdateOrderPaymentAsyncById(OrderPayment orderPayment);
        Task<bool> DeleteOrderPaymentAsyncById(long orderPaymentId);

    }
}
