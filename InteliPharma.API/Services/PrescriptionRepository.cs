using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class PrescriptionRepository : IPrescriptionRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public PrescriptionRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Prescription> CreatePrescriptionAsync(Prescription prescription)
        {
            SqlParameter outputPrescriptionId;
            SqlCommand cmd;

            try
            {
                outputPrescriptionId = new SqlParameter("@PrescriptionId", SqlDbType.BigInt);
                outputPrescriptionId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_PrescriptionCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProfessionalId", prescription.ProfessionalId);
                cmd.Parameters.AddWithValue("PatientId", prescription.PatientId);
                cmd.Parameters.AddWithValue("PrescriptionDate", prescription.PrescriptionDate);
                cmd.Parameters.Add(outputPrescriptionId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                prescription.PrescriptionId = (long)outputPrescriptionId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return prescription;
        }

        public async Task<Prescription> GetPrescriptionAsyncById(long prescriptionId)
        {
            SqlDataReader? sqlDr = null;
            Prescription prescription = new Prescription();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PrescriptionReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@PrescriptionId", prescriptionId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    prescription.PrescriptionId = prescriptionId;
                    prescription.ProfessionalId = (int)sqlDr["ProfessionalId"];
                    prescription.PatientId = (int)sqlDr["PatientId"];
                    prescription.PrescriptionDate = (DateTime)sqlDr["PrescriptionDate"];
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
            return prescription;
        }

        public async Task<IEnumerable<Prescription>> GetAllPrescriptionsAsync()
        {
            Prescription prescription;
            SqlDataReader? sqlDr = null;
            ICollection<Prescription> prescriptions = new List<Prescription>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PrescriptionReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    prescription = new Prescription();
                    prescription.PrescriptionId = (long)sqlDr["PrescriptionId"];
                    prescription.ProfessionalId = (int)sqlDr["ProfessionalId"];
                    prescription.PatientId = (int)sqlDr["PatientId"];
                    prescription.PrescriptionDate = (DateTime)sqlDr["PrescriptionDate"];
                    prescriptions.Add(prescription);
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
            return prescriptions;
        }

        public async Task<Prescription> UpdatePrescriptionAsyncById(Prescription prescription)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PrescriptionUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PrescriptionId", prescription.PrescriptionId);
                cmd.Parameters.AddWithValue("ProfessionalId", prescription.ProfessionalId);
                cmd.Parameters.AddWithValue("PatientId", prescription.PatientId);
                cmd.Parameters.AddWithValue("PrescriptionDate", prescription.PrescriptionDate);
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
            return prescription;
        }


        public async Task<bool> DeletePrescriptionAsyncById(long prescriptionId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PrescriptionDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PrescriptionId", prescriptionId);

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
