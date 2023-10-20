using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class DosageRepository : IDosageRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public DosageRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Dosage> CreateDosageAsync(Dosage dosage)
        {
            SqlParameter outputDiseaseId;
            SqlCommand cmd;

            try
            {
                outputDiseaseId = new SqlParameter("@DosageId", SqlDbType.Int);
                outputDiseaseId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_DosageCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DosageValue", dosage.DosageValue);
                cmd.Parameters.Add(outputDiseaseId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                dosage.DosageId = (int)outputDiseaseId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return dosage;
        }

        public async Task<Dosage> GetDosageAsyncById(int dosageId)
        {
            SqlDataReader? sqlDr = null;
            Dosage dosage = new Dosage();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_DosageReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DosageId", dosageId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    dosage.DosageId = dosageId;
                    dosage.DosageValue = (string)sqlDr["DosageValue"];
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
            return dosage;
        }

        public async Task<IEnumerable<Dosage>> GetAllDosagesAsync()
        {
            Dosage dosage;
            SqlDataReader? sqlDr = null;
            ICollection<Dosage> dosages = new List<Dosage>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_DosageReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    dosage = new Dosage();
                    dosage.DosageId = (int)sqlDr["DosageId"];
                    dosage.DosageValue = (string)sqlDr["DosageValue"];
                    dosages.Add(dosage);
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
            return dosages;
        }

        public async Task<Dosage> UpdateDosageAsyncById(Dosage dosage)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_DosageUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DosageId", dosage.DosageId);
                cmd.Parameters.AddWithValue("DosageName", dosage.DosageValue);
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
            return dosage;
        }


        public async Task<bool> DeleteDosageAsyncById(int dosageId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_DosageDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DosageId", dosageId);

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
