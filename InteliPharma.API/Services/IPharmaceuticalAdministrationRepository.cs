using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IPharmaceuticalAdministrationRepository
    {
        Task<PharmaceuticalAdministration> CreatePharmaceuticalAdministrationAsync(PharmaceuticalAdministration pharmaceuticalAdministration);
        Task<IEnumerable<PharmaceuticalAdministration>> GetAllPharmaceuticalAdministrationsAsync();
        Task<PharmaceuticalAdministration> GetPharmaceuticalAdministrationAsyncById(int pharmaceuticalAdministrationId);
        Task<PharmaceuticalAdministration> UpdatePharmaceuticalAdministrationAsyncById(PharmaceuticalAdministration pharmaceuticalAdministration);
        Task<bool> DeletePharmaceuticalAdministrationAsyncById(int pharmaceuticalAdministrationId);

    }
}
