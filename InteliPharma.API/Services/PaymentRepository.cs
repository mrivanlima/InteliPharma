using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class PaymentRepository : IPaymentRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public PaymentRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Payment> CreatePaymentAsync(Payment payment)
        {
            SqlParameter outputPaymentId;
            SqlCommand cmd;

            try
            {
                outputPaymentId = new SqlParameter("@PaymentId", SqlDbType.TinyInt);
                outputPaymentId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_PaymentCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PaymentId", payment.PaymentId);
                cmd.Parameters.AddWithValue("PaymentMethodId", payment.PaymentMethodId);
                cmd.Parameters.Add(outputPaymentId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                payment.PaymentId = (byte)outputPaymentId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return payment;
        }

        public async Task<Payment> GetPaymentAsyncById(byte paymentId)
        {
            SqlDataReader? sqlDr = null;
            Payment payment = new Payment();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PaymentReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@PaymentId", paymentId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    payment.PaymentId = paymentId;
                    payment.PaymentMethodId = (byte)sqlDr["PaymentMethodId"];
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
            return payment;
        }

        public async Task<IEnumerable<Payment>> GetAllPaymentsAsync()
        {
            Payment payment;
            SqlDataReader? sqlDr = null;
            ICollection<Payment> payments = new List<Payment>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_PaymentReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    payment = new Payment();
                    payment.PaymentId = (byte)sqlDr["PaymentId"];
                    payment.PaymentMethodId = (byte)sqlDr["PaymentMethodId"];
                    payments.Add(payment);
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
            return payments;
        }

        public async Task<Payment> UpdatePaymentAsyncById(Payment payment)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PaymentUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PaymentId", payment.PaymentId);
                cmd.Parameters.AddWithValue("PaymentMethodId", payment.PaymentMethodId);
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
            return payment;
        }


        public async Task<bool> DeletePaymentAsyncById(byte paymentId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_PaymentDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("PaymentId", paymentId);

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
