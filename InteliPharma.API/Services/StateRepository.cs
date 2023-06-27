using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class StateRepository : IStateRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public StateRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<State> CreateStateAsync(State state)
        {
            SqlParameter outputStateId = new SqlParameter("@StateId", SqlDbType.TinyInt);
            outputStateId.Direction = ParameterDirection.Output;
            SqlCommand cmd = new SqlCommand("[App].[usp_api_StateCreate]", _connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("StateName", state.StateName);
            cmd.Parameters.AddWithValue("Longitude", state.Longitude);
            cmd.Parameters.AddWithValue("Latitude", state.Latitude);
            cmd.Parameters.Add(outputStateId);

            _connection.Open();

            try
            {
                var result = await cmd.ExecuteNonQueryAsync();
                state.StateId = (byte)outputStateId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally 
            {
                await _connection.CloseAsync();
            }
            return state;
        }

        public Task<State> DeleteStateAsyncById(byte stateId)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<State>> GetAllStatesAsync()
        {
            throw new NotImplementedException();
        }

        public Task<State> GetStateAsyncById(byte stateId)
        {
            throw new NotImplementedException();
        }

        public Task<State> UpdateStateAsyncById(byte stateId)
        {
            throw new NotImplementedException();
        }
    }
}
