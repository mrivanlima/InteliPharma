using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IPrescriptionTypeRepository
    {
        Task<PrescriptionType> CreatePrescriptionTypeAsync(PrescriptionType prescriptionType);
        Task<IEnumerable<PrescriptionType>> GetAllPrescriptionTypesAsync();
        Task<PrescriptionType> GetPrescriptionTypeAsyncById(byte prescriptionTypeId);
        Task<PrescriptionType> UpdatePrescriptionTypeAsyncById(PrescriptionType prescriptionType);
        Task<bool> DeletePrescriptionTypeAsyncById(byte prescriptionTypeId);

    }
}
