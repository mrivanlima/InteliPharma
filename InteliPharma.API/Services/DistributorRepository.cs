using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class DistributorRepository : IDistributorRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public DistributorRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Distributor> CreateDistributorAsync(Distributor distributor)
        {
            SqlParameter outputDistributorId;
            SqlCommand cmd;

            try
            {
                outputDistributorId = new SqlParameter("@DistributorId", SqlDbType.Int);
                outputDistributorId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_DistributorCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DistributorName", distributor.DistributorName);
                cmd.Parameters.AddWithValue("AddressId", distributor.AddressId);
                cmd.Parameters.AddWithValue("CNPJ", distributor.CNPJ);
                cmd.Parameters.AddWithValue("StateSubscription", distributor.StateSubscription);
                cmd.Parameters.Add(outputDistributorId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                distributor.DistributorId = (int)outputDistributorId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return distributor;
        }

        public async Task<Distributor> GetDistributorAsyncById(int distributorId)
        {
            SqlDataReader? sqlDr = null;
            Distributor distributor = new Distributor();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_DistributorReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DistributorId", distributorId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    distributor.DistributorId = distributorId;
                    distributor.DistributorName = (string)sqlDr["DistributorName"];
                    distributor.AddressId = (int)sqlDr["AddressId"];
                    distributor.CNPJ = (string)sqlDr["CNPJ"];
                    distributor.StateSubscription = (string)sqlDr["StateSubscription"];
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
            return distributor;
        }

        public async Task<IEnumerable<Distributor>> GetAllDistributorsAsync()
        {
            Distributor distributor;
            SqlDataReader? sqlDr = null;
            ICollection<Distributor> distributors = new List<Distributor>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_DistributorReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    distributor = new Distributor();
                    distributor.DistributorId = (int)sqlDr["DistributorId"];
                    distributor.DistributorName = (string)sqlDr["DistributorName"];
                    distributor.AddressId = (int)sqlDr["AddressId"];
                    distributor.CNPJ = (string)sqlDr["CNPJ"];
                    distributor.StateSubscription = (string)sqlDr["StateSubscription"];
                    distributors.Add(distributor);
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
            return distributors;
        }

        public async Task<Distributor> UpdateDistributorAsyncById(Distributor distributor)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_DistributorUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DistributorId", distributor.DistributorId);
                cmd.Parameters.AddWithValue("DistributorName", distributor.DistributorName);
                cmd.Parameters.AddWithValue("AddressId", distributor.AddressId);
                cmd.Parameters.AddWithValue("CNPJ", distributor.CNPJ);
                cmd.Parameters.AddWithValue("StateSubscription", distributor.StateSubscription);
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
            return distributor;
        }


        public async Task<bool> DeleteDistributorAsyncById(int distributorId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_DistributorDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DistributorId", distributorId);

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
