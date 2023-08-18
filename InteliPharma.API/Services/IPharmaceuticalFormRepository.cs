using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IPharmaceuticalFormRepository
    {
        Task<PharmaceuticalForm> CreatePharmaceuticalFormAsync(PharmaceuticalForm pharmaceuticalForm);
        Task<IEnumerable<PharmaceuticalForm>> GetAllPharmaceuticalFormsAsync();
        Task<PharmaceuticalForm> GetPharmaceuticalFormAsyncById(int pharmaceuticalFormId);
        Task<PharmaceuticalForm> UpdatePharmaceuticalFormAsyncById(PharmaceuticalForm pharmaceuticalForm);
        Task<bool> DeletePharmaceuticalFormAsyncById(int pharmaceuticalForm);

    }
}
