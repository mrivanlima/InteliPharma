using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class PharmaceuticalFormRepository : IPharmaceuticalFormRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public PharmaceuticalFormRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<PharmaceuticalForm> CreatePharmaceuticalFormAsync(PharmaceuticalForm pharmaceuticalForm)
        {
            SqlParameter outputPharmaceuticalFormId;
            SqlCommand cmd;

            try
            {
                outputPharmaceuticalFormId = new SqlParameter("@PharmaceuticalFormId", SqlDbType.Int);
                outputPharmaceuticalFormId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_PharmaceuticalFormCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PharmaceuticalFormDescription", pharmaceuticalForm.PharmaceuticalFormDescription);
                cmd.Parameters.Add(outputPharmaceuticalFormId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                pharmaceuticalForm.PharmaceuticalFormId = (int)outputPharmaceuticalFormId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return pharmaceuticalForm;
        }

        public async Task<PharmaceuticalForm> GetPharmaceuticalFormAsyncById(int pharmaceuticalFormId)
        {
            SqlDataReader? sqlDr = null;
            PharmaceuticalForm pharmaceuticalForm = new PharmaceuticalForm();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PharmaceuticalFormReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@PharmaceuticalFormId", pharmaceuticalFormId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    pharmaceuticalForm.PharmaceuticalFormId = pharmaceuticalFormId;
                    pharmaceuticalForm.PharmaceuticalFormDescription = (string)sqlDr["PharmaceuticalFormDescription"];
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
            return pharmaceuticalForm;
        }

        public async Task<IEnumerable<PharmaceuticalForm>> GetAllPharmaceuticalFormsAsync()
        {
            PharmaceuticalForm pharmaceuticalForm;
            SqlDataReader? sqlDr = null;
            ICollection<PharmaceuticalForm> pharmaceuticalForms = new List<PharmaceuticalForm>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PharmaceuticalFormReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    pharmaceuticalForm = new PharmaceuticalForm();
                    pharmaceuticalForm.PharmaceuticalFormId = (int)sqlDr["PharmaceuticalFormId"];
                    pharmaceuticalForm.PharmaceuticalFormDescription = (string)sqlDr["PharmaceuticalFormDescription"];
                    pharmaceuticalForms.Add(pharmaceuticalForm);
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
            return pharmaceuticalForms;
        }

        public async Task<PharmaceuticalForm> UpdatePharmaceuticalFormAsyncById(PharmaceuticalForm pharmaceuticalForm)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PharmaceuticalFormUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PharmaceuticalFormId", pharmaceuticalForm.PharmaceuticalFormId);
                cmd.Parameters.AddWithValue("PharmaceuticalFormDescription", pharmaceuticalForm.PharmaceuticalFormDescription);
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
            return pharmaceuticalForm;
        }


        public async Task<bool> DeletePharmaceuticalFormAsyncById(int pharmaceuticalFormId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PharmaceuticalFormDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PharmaceuticalFormId", pharmaceuticalFormId);

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
