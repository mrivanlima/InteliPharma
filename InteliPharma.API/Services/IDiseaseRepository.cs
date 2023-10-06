using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IDiseaseRepository
    {
        Task<Disease> CreateDiseaseAsync(Disease disease);
        Task<IEnumerable<Disease>> GetAllDiseasesAsync();
        Task<Disease> GetDiseaseAsyncById(int diseaseId);
        Task<Disease> UpdateDiseaseAsyncById(Disease disease);
        Task<bool> DeleteDiseaseAsyncById(int diseaseId);

    }
}
