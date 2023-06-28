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



        //public async Task<User> GetUserAsyncById(int userId)
        //{
        //    SqlDataReader sqlDr = null;
        //    SqlCommand command = new SqlCommand("[dbo].[sp_API_GetUserById]", connection);
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.Parameters.Add(new SqlParameter("@UserID", userId));

        //    connection.Open();
        //    sqlDr = await command.ExecuteReaderAsync();

        //    var user = new User();
        //    while (sqlDr.Read())
        //    {
        //        user = new User();
        //        user.UserId = (int)sqlDr["UserId"];
        //        user.FirstName = (string)sqlDr["FirstName"];
        //        user.LastName = (string)sqlDr["LastName"];
        //        user.BirthDate = (DateTime)sqlDr["BirthDate"];// ? null : (DateTime)sqlDr["BirthDate"];
        //        user.Email = (string)sqlDr["Email"];
        //        user.cpf = (string)sqlDr["cpf"];
        //        user.Gender = (Boolean)sqlDr["Gender"];
        //        user.PhoneNumber = (string)sqlDr["LastName"];
        //    }
        //    connection.Close();
        //    sqlDr.Close();
        //    return user;

        //}




        public Task<State> DeleteStateAsyncById(byte stateId)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<State>> GetAllStatesAsync()
        {
            throw new NotImplementedException();
        }

        //public Task<State> GetStateAsyncById(byte stateId)
        //{
        //    throw new NotImplementedException();
        //}

        public Task<State> UpdateStateAsyncById(byte stateId)
        {
            throw new NotImplementedException();
        }
    }
}
