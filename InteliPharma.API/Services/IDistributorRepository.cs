using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IDistributorRepository
    {
        Task<Distributor> CreateDistributorAsync(Distributor distributor);
        Task<IEnumerable<Distributor>> GetAllDistributorsAsync();
        Task<Distributor> GetDistributorAsyncById(int distributorId);
        Task<Distributor> UpdateDistributorAsyncById(Distributor distributor);
        Task<bool> DeleteDistributorAsyncById(int distributorId);

    }
}
