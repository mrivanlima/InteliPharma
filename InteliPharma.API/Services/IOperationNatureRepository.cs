using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IOperationNatureRepository
    {
        Task<OperationNature> CreateOperationNatureAsync(OperationNature operationnature);
        Task<IEnumerable<OperationNature>> GetAllOperationNatureAsync();
        Task<OperationNature> GetOperationNatureAsyncById(short OperationNatureId);
        Task<OperationNature> UpdateOperationNatureAsyncById(OperationNature operationnature);
        Task<bool> DeleteOperationNatureAsyncById(short OperationNatureId);

    }
}
