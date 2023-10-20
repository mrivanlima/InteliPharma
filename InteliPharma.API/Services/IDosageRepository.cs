using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IDosageRepository
    {
        Task<Dosage> CreateDosageAsync(Dosage dosage);
        Task<IEnumerable<Dosage>> GetAllDosagesAsync();
        Task<Dosage> GetDosageAsyncById(int dosageId);
        Task<Dosage> UpdateDosageAsyncById(Dosage dosage);
        Task<bool> DeleteDosageAsyncById(int dosageId);

    }
}
