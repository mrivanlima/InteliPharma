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
            SqlParameter outputStateId;
            SqlCommand cmd;

            try
            {
                outputStateId = new SqlParameter("@StateId", SqlDbType.TinyInt);
                outputStateId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_StateCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("StateName", state.StateName);
                cmd.Parameters.AddWithValue("StateName", state.StateAbbreviation);
                cmd.Parameters.AddWithValue("Longitude", state.Longitude);
                cmd.Parameters.AddWithValue("Latitude", state.Latitude);
                cmd.Parameters.Add(outputStateId);

                _connection.Open();

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

        public async Task<State> GetStateAsyncById(byte stateId)
        {
            SqlDataReader? sqlDr = null;
            State state = new State();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_StateReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@StateId", stateId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    state.StateId = stateId;
                    state.StateName = (string)sqlDr["StateName"];
                    state.StateAbbreviation = (string)sqlDr["StateAbbreviation"];
                    state.Longitude = (decimal)sqlDr["Longitude"];
                    state.Latitude = (decimal)sqlDr["Latitude"];
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                _connection.Close();
                if (sqlDr != null)
                {
                    sqlDr.Close();
                }
            }
            return state;
        }

        public async Task<IEnumerable<State>> GetAllStatesAsync()
        {
            State state;
            SqlDataReader? sqlDr = null;
            ICollection<State> states = new List<State>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_StateReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    state = new State();
                    state.StateId = (byte)sqlDr["StateId"];
                    state.StateAbbreviation = (string)sqlDr["StateAbbreviation"];
                    state.StateName = (string)sqlDr["StateName"];
                    state.Longitude = (decimal)sqlDr["Longitude"];
                    state.Latitude = (decimal)sqlDr["Latitude"];
                    states.Add(state);  
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                _connection.Close();
                if (sqlDr != null)
                {
                    sqlDr.Close();
                }
            }
            return states;
        }

        public async Task<State> UpdateStateAsyncById(State state)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_StateUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("StateId", state.StateId);
                cmd.Parameters.AddWithValue("StateName", state.StateName);
                cmd.Parameters.AddWithValue("StateAbbreviation", state.StateAbbreviation);
                cmd.Parameters.AddWithValue("Longitude", state.Longitude);
                cmd.Parameters.AddWithValue("Latitude", state.Latitude);
                _connection.Open();
                var result = await cmd.ExecuteNonQueryAsync();
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


        public async Task<bool> DeleteStateAsyncById(byte stateId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_StateDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("StateId", stateId);

                _connection.Open();
                var result = await cmd.ExecuteNonQueryAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                isDeleted = false;
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return isDeleted;
        }
    }
}
