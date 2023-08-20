using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class PrescriptionTypeRepository : IPrescriptionTypeRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public PrescriptionTypeRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<PrescriptionType> CreatePrescriptionTypeAsync(PrescriptionType prescriptionType)
        {
            SqlParameter outputPrescriptionTypeId;
            SqlCommand cmd;

            try
            {
                outputPrescriptionTypeId = new SqlParameter("@PrescriptionTypeId", SqlDbType.TinyInt);
                outputPrescriptionTypeId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_PrescriptionTypeCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PrescriptionTypeId", prescriptionType.PrescriptionTypeId);
                cmd.Parameters.AddWithValue("PrescriptionTypeName", prescriptionType.PrescriptionTypeName);
                cmd.Parameters.Add(outputPrescriptionTypeId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                prescriptionType.PrescriptionTypeId = (byte)outputPrescriptionTypeId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return prescriptionType;
        }

        public async Task<PrescriptionType> GetPrescriptionTypeAsyncById(byte prescriptionTypeId)
        {
            SqlDataReader? sqlDr = null;
            PrescriptionType prescriptionType = new PrescriptionType();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PrescriptionTypeReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@PrescriptionTypeId", prescriptionTypeId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    prescriptionType.PrescriptionTypeId = prescriptionTypeId;
                    prescriptionType.PrescriptionTypeName = (string)sqlDr["PrescriptionTypeName"];
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
            return prescriptionType;
        }

        public async Task<IEnumerable<PrescriptionType>> GetAllPrescriptionTypesAsync()
        {
            PrescriptionType prescriptionType;
            SqlDataReader? sqlDr = null;
            ICollection<PrescriptionType> prescriptionTypes = new List<PrescriptionType>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PrescriptionTypeReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    prescriptionType = new PrescriptionType();
                    prescriptionType.PrescriptionTypeId = (byte)sqlDr["PrescriptionTypeId"];
                    prescriptionType.PrescriptionTypeName = (string)sqlDr["PrescriptionTypeName"];
                    prescriptionTypes.Add(prescriptionType);
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
            return prescriptionTypes;
        }

        public async Task<PrescriptionType> UpdatePrescriptionTypeAsyncById(PrescriptionType prescriptionType)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PrescriptionTypeUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PrescriptionTypeId", prescriptionType.PrescriptionTypeId);
                cmd.Parameters.AddWithValue("PrescriptionTypeName", prescriptionType.PrescriptionTypeName);
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
            return prescriptionType;
        }


        public async Task<bool> DeletePrescriptionTypeAsyncById(byte prescriptionTypeId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PrescriptionTypeDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PrescriptionTypeId", prescriptionTypeId);

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
