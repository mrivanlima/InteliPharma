using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class DiseaseRepository : IDiseaseRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public DiseaseRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Disease> CreateDiseaseAsync(Disease disease)
        {
            SqlParameter outputDiseaseId;
            SqlCommand cmd;

            try
            {
                outputDiseaseId = new SqlParameter("@DiseaseId", SqlDbType.SmallInt);
                outputDiseaseId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_DiseaseCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DiseaseName", disease.DiseaseName);
                cmd.Parameters.Add(outputDiseaseId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                disease.DiseaseId = (int)outputDiseaseId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return disease;
        }

        public async Task<Disease> GetDiseaseAsyncById(int diseaseId)
        {
            SqlDataReader? sqlDr = null;
            Disease disease = new Disease();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_DiseaseReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@DiseaseId", diseaseId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    disease.DiseaseId = diseaseId;
                    disease.DiseaseName = (string)sqlDr["DiseaseName"];
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
            return disease;
        }

        public async Task<IEnumerable<Disease>> GetAllDiseasesAsync()
        {
            Disease disease;
            SqlDataReader? sqlDr = null;
            ICollection<Disease> diseases = new List<Disease>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_DiseaseReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    disease = new Disease();
                    disease.DiseaseId = (int)sqlDr["DiseaseId"];
                    disease.DiseaseName = (string)sqlDr["DiseaseName"];
                    diseases.Add(disease);
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
            return diseases;
        }

        public async Task<Disease> UpdateDiseaseAsyncById(Disease disease)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_DiseaseUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DiseaseId", disease.DiseaseId);
                cmd.Parameters.AddWithValue("DiseaseName", disease.DiseaseName);
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
            return disease;
        }


        public async Task<bool> DeleteDiseaseAsyncById(int diseaseId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_DiseaseDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DiseaseId", diseaseId);

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
