using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IOrderDeliveryRepository
    {
        Task<OrderDelivery> CreateOrderDeliveryAsync(OrderDelivery orderDelivery);
        Task<IEnumerable<OrderDelivery>> GetAllOrderDeliveriesAsync();
        Task<OrderDelivery> GetOrderDeliveryAsyncById(long orderDeliveryId);
        Task<OrderDelivery> UpdateOrderDeliveryAsyncById(OrderDelivery orderDelivery);
        Task<bool> DeleteOrderDeliveryAsyncById(long orderDeliveryId);

    }
}
