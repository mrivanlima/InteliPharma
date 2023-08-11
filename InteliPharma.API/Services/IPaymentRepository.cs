using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IPaymentRepository
    {
        Task<Payment> CreatePaymentAsync(Payment payment);
        Task<IEnumerable<Payment>> GetAllPaymentsAsync();
        Task<Payment> GetPaymentAsyncById(byte paymentId);
        Task<Payment> UpdatePaymentAsyncById(Payment payment);
        Task<bool> DeletePaymentAsyncById(byte paymentId);

    }
}
