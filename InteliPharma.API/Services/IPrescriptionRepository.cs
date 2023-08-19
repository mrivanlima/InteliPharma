using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IPrescriptionRepository
    {
        Task<Prescription> CreatePrescriptionAsync(Prescription prescription);
        Task<IEnumerable<Prescription>> GetAllPrescriptionsAsync();
        Task<Prescription> GetPrescriptionAsyncById(long prescriptionId);
        Task<Prescription> UpdatePrescriptionAsyncById(Prescription prescription);
        Task<bool> DeletePrescriptionAsyncById(long prescriptionId);

    }
}
