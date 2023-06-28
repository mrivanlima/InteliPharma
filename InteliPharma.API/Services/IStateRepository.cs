using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IStateRepository
    {
        Task<State> CreateStateAsync(State state);
        Task<IEnumerable<State>> GetAllStatesAsync();
        Task<State> GetStateAsyncById(byte stateId);
        Task<State> UpdateStateAsyncById(State state);
        Task<bool> DeleteStateAsyncById(byte stateId);

    }
}
