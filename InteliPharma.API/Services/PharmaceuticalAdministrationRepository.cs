using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class PharmaceuticalAdministrationRepository : IPharmaceuticalAdministrationRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public PharmaceuticalAdministrationRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<PharmaceuticalAdministration> CreatePharmaceuticalAdministrationAsync(PharmaceuticalAdministration pharmaceuticalAdministration)
        {
            SqlParameter outputPharmaceuticalAdministrationId;
            SqlCommand cmd;

            try
            {
                outputPharmaceuticalAdministrationId = new SqlParameter("@PharmaceuticalAdministrationId", SqlDbType.Int);
                outputPharmaceuticalAdministrationId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_PharmaceuticalAdministrationCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PharmaceuticalAdministrationDescription", pharmaceuticalAdministration.PharmaceuticalAdministrationDescription);
                cmd.Parameters.Add(outputPharmaceuticalAdministrationId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                pharmaceuticalAdministration.PharmaceuticalAdministrationId = (int)outputPharmaceuticalAdministrationId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return pharmaceuticalAdministration;
        }

        public async Task<PharmaceuticalAdministration> GetPharmaceuticalAdministrationAsyncById(int pharmaceuticalAdministrationId)
        {
            SqlDataReader? sqlDr = null;
            PharmaceuticalAdministration pharmaceuticalAdministration = new PharmaceuticalAdministration();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PharmaceuticalAdministrationReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@PharmaceuticalAdministrationId", pharmaceuticalAdministrationId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    pharmaceuticalAdministration.PharmaceuticalAdministrationId = pharmaceuticalAdministrationId;
                    pharmaceuticalAdministration.PharmaceuticalAdministrationDescription = (string)sqlDr["PharmaceuticalAdministrationDescription"];
                    
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
            return pharmaceuticalAdministration;
        }

        public async Task<IEnumerable<PharmaceuticalAdministration>> GetAllPharmaceuticalAdministrationsAsync()
        {
            PharmaceuticalAdministration pharmaceuticalAdministration;
            SqlDataReader? sqlDr = null;
            ICollection<PharmaceuticalAdministration> pharmaceuticalAdministrations = new List<PharmaceuticalAdministration>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PharmaceuticalAdministrationReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    pharmaceuticalAdministration = new PharmaceuticalAdministration();
                    pharmaceuticalAdministration.PharmaceuticalAdministrationId = (int)sqlDr["PharmaceuticalAdministrationId"];
                    pharmaceuticalAdministration.PharmaceuticalAdministrationDescription = (string)sqlDr["PharmaceuticalAdministrationDescription"];
                    pharmaceuticalAdministrations.Add(pharmaceuticalAdministration);
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
            return pharmaceuticalAdministrations;
        }

        public async Task<PharmaceuticalAdministration> UpdatePharmaceuticalAdministrationAsyncById(PharmaceuticalAdministration pharmaceuticalAdministration)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PharmaceuticalAdministrationUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PharmaceuticalAdministrationId", pharmaceuticalAdministration.PharmaceuticalAdministrationId);
                cmd.Parameters.AddWithValue("PharmaceuticalAdministrationDescription", pharmaceuticalAdministration.PharmaceuticalAdministrationDescription);
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
            return pharmaceuticalAdministration;
        }


        public async Task<bool> DeletePharmaceuticalAdministrationAsyncById(int pharmaceuticalAdministrationId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PharmaceuticalAdministrationDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PharmaceuticalAdministrationId", pharmaceuticalAdministrationId);

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
