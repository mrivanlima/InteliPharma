using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface INeighborhoodRepository
    {
        Task<Neighborhood> CreateNeighborhoodAsync(Neighborhood neighborhood);
        Task<IEnumerable<Neighborhood>> GetAllNeighborhoodAsync();
        Task<Neighborhood> GetNeighborhoodAsyncById(short NeighborhoodId);
        Task<Neighborhood> UpdateNeighborhoodAsyncById(Neighborhood neighborhood);
        Task<bool> DeleteNeighborhoodAsyncById(short NeighborhoodId);

    }
}
