using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IOrderRepository
    {
        Task<Order> CreateOrderAsync(Order order);
        Task<IEnumerable<Order>> GetAllOrdersAsync();
        Task<Order> GetOrderAsyncById(long orderId);
        Task<Order> UpdateOrderAsyncById(Order order);
        Task<bool> DeleteOrderAsyncById(long orderId);

    }
}
