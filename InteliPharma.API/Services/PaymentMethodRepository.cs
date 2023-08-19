using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class PaymentMethodRepository : IPaymentMethodRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public PaymentMethodRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<PaymentMethod> CreatePaymentMethodAsync(PaymentMethod paymentMethod)
        {
            SqlParameter outputPaymentMethodId;
            SqlCommand cmd;

            try
            {
                outputPaymentMethodId = new SqlParameter("@PaymentMethodId", SqlDbType.TinyInt);
                outputPaymentMethodId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_PaymentMethodCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PaymentMethodName", paymentMethod.PaymentMethodName);
                cmd.Parameters.Add(outputPaymentMethodId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                paymentMethod.PaymentMethodId = (byte)outputPaymentMethodId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return paymentMethod;
        }

        public async Task<PaymentMethod> GetPaymentMethodAsyncById(byte paymentMethodId)
        {
            SqlDataReader? sqlDr = null;
            PaymentMethod paymentMethod = new PaymentMethod();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PaymentMethodReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@PaymentMethodId", paymentMethodId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    paymentMethod.PaymentMethodId = paymentMethodId;
                    paymentMethod.PaymentMethodName = (string)sqlDr["PaymentMethodName"];
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
            return paymentMethod;
        }

        public async Task<IEnumerable<PaymentMethod>> GetAllPaymentMethodsAsync()
        {
            PaymentMethod paymentMethod;
            SqlDataReader? sqlDr = null;
            ICollection<PaymentMethod> paymentMethods = new List<PaymentMethod>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PaymentMethodReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    paymentMethod = new PaymentMethod();
                    paymentMethod.PaymentMethodId = (byte)sqlDr["PaymentMethodId"];
                    paymentMethod.PaymentMethodName = (string)sqlDr["PaymentMethodName"];
                    paymentMethods.Add(paymentMethod);
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
            return paymentMethods;
        }

        public async Task<PaymentMethod> UpdatePaymentMethodAsyncById(PaymentMethod paymentMethod)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PaymentMethodUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PaymentMethodId", paymentMethod.PaymentMethodId);
                cmd.Parameters.AddWithValue("PaymentMethodName", paymentMethod.PaymentMethodName);
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
            return paymentMethod;
        }


        public async Task<bool> DeletePaymentMethodAsyncById(byte paymentMethodId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PaymentMethodDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PaymentMethodId", paymentMethodId);

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
