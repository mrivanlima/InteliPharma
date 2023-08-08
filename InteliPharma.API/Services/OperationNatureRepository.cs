using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class OperationNatureRepository : IOperationNatureRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public OperationNatureRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<OperationNature> CreateOperationNatureAsync(OperationNature operationnature)
        {
            SqlParameter outputOperationNatureId;
            SqlCommand cmd;

            try
            {
                outputOperationNatureId = new SqlParameter("@OperationNatureId", SqlDbType.SmallInt);
                outputOperationNatureId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_OperationNatureCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OperationNatureName", operationnature.OperationNatureName);
                cmd.Parameters.Add(outputOperationNatureId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                operationnature.OperationNatureId = (byte)outputOperationNatureId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return operationnature;
        }

        public async Task<OperationNature> GetOperationNatureAsyncById(short operationnatureId)
        {
            SqlDataReader? sqlDr = null;
            OperationNature operationnature = new OperationNature();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OperationNatureReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@OperationNatureId", operationnatureId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    operationnature.OperationNatureId = operationnatureId;
                    operationnature.OperationNatureName = (string)sqlDr["OperationNatureName"];
                    
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
            return operationnature;
        }

        public async Task<IEnumerable<OperationNature>> GetAllOperationNatureAsync()
        {
            OperationNature operationnature;
            SqlDataReader? sqlDr = null;
            ICollection<OperationNature> operationnatures = new List<OperationNature>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OperationNatureReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    operationnature = new OperationNature();
                    operationnature.OperationNatureId = (short)sqlDr["OperationNatureId"];
                    operationnature.OperationNatureName = (string)sqlDr["OperationNatureName"];
                    operationnatures.Add(operationnature);
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
            return operationnatures;
        }

        public async Task<OperationNature> UpdateOperationNatureAsyncById(OperationNature operationnature)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OperationNatureUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OperationNatureId", operationnature.OperationNatureId);
                cmd.Parameters.AddWithValue("OperationNatureName", operationnature.OperationNatureName);
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
            return operationnature;
        }


        public async Task<bool> DeleteOperationNatureAsyncById(short operationnatureId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OperationNatureDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OperationNatureId", operationnatureId);

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
