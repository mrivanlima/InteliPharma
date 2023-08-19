using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IPaymentMethodRepository
    {
        Task<PaymentMethod> CreatePaymentMethodAsync(PaymentMethod paymentMethod);
        Task<IEnumerable<PaymentMethod>> GetAllPaymentMethodsAsync();
        Task<PaymentMethod> GetPaymentMethodAsyncById(byte paymentMethodId);
        Task<PaymentMethod> UpdatePaymentMethodAsyncById(PaymentMethod paymentMethod);
        Task<bool> DeletePaymentMethodAsyncById(byte paymentMethodId);

    }
}
