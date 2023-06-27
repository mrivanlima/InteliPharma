using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography.X509Certificates;
using IDbConnection = InteliPharma.API.Services.DBServices.IDbConnection;

namespace InteliPharma.API.Services
{
    public class StateRepository : IStateRepository
    {
        private readonly IDbConnection _connect;
        private SqlConnection connection { get; set; }

        public StateRepository(IDbConnection connect)
        {
            connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(connect));
        }

        public async Task<State> CreateStateAsync(State state)
        {

            SqlParameter outputStateId = new SqlParameter("@StateId", SqlDbType.TinyInt);
            outputStateId.Direction = ParameterDirection.Output;
            SqlCommand cmd = new SqlCommand("[App].[usp_api_StateCreate]", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("StateName", state.StateName);
            cmd.Parameters.AddWithValue("Longitude", state.Longitude);
            cmd.Parameters.AddWithValue("Latitude", state.Latitude);
            cmd.Parameters.Add(outputStateId);

            connection.Open();

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
                await connection.CloseAsync();
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
