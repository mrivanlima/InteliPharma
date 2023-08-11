using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class OrderPaymentRepository : IOrderPaymentRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public OrderPaymentRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<OrderPayment> CreateOrderPaymentAsync(OrderPayment orderPayment)
        {
            SqlParameter outputOrderPaymentId;
            SqlCommand cmd;

            try
            {
                outputOrderPaymentId = new SqlParameter("@OrderPaymentId", SqlDbType.BigInt);
                outputOrderPaymentId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_OrderPaymentCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OrderId", orderPayment.OrderId);
                cmd.Parameters.AddWithValue("PaymentId", orderPayment.PaymentId);
                cmd.Parameters.Add(outputOrderPaymentId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                orderPayment.OrderPaymentId = (long)outputOrderPaymentId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return orderPayment;
        }

        public async Task<OrderPayment> GetOrderPaymentAsyncById(long orderPaymentId)
        {
            SqlDataReader? sqlDr = null;
            OrderPayment orderPayment = new OrderPayment();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OrderPaymentReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@OrderPaymentId", orderPaymentId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    orderPayment.OrderPaymentId = orderPaymentId;
                    orderPayment.OrderId = (long)sqlDr["OrderId"];
                    orderPayment.PaymentId = (byte)sqlDr["PaymentId"];
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
            return orderPayment;
        }

        public async Task<IEnumerable<OrderPayment>> GetAllOrdersPaymentAsync()
        {
            OrderPayment orderPayment;
            SqlDataReader? sqlDr = null;
            ICollection<OrderPayment> ordersPayment = new List<OrderPayment>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OrderPaymentReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    orderPayment = new OrderPayment();
                    orderPayment.OrderId = (long)sqlDr["OrderId"];
                    orderPayment.PaymentId = (byte)sqlDr["PaymentId"];
                    ordersPayment.Add(orderPayment);
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
            return ordersPayment;
        }

        public async Task<OrderPayment> UpdateOrderPaymentAsyncById(OrderPayment orderPayment)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OrderPaymentUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OrderPaymentId", orderPayment.OrderPaymentId);
                cmd.Parameters.AddWithValue("OrderId", orderPayment.OrderId);
                cmd.Parameters.AddWithValue("PaymentId", orderPayment.PaymentId);
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
            return orderPayment;
        }


        public async Task<bool> DeleteOrderPaymentAsyncById(long orderPayemntId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OrderPaymentDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OrderPaymentId", orderPayemntId);

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
