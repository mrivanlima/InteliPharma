using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class OrderRepository : IOrderRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public OrderRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Order> CreateOrderAsync(Order order)
        {
            SqlParameter outputOrderId;
            SqlCommand cmd;

            try
            {
                outputOrderId = new SqlParameter("@OrderId", SqlDbType.BigInt);
                outputOrderId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_OrderCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CartId", order.CartId);
                cmd.Parameters.AddWithValue("TotalPrice", order.TotalPrice);
                cmd.Parameters.Add(outputOrderId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                order.OrderId = (long)outputOrderId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return order;
        }

        public async Task<Order> GetOrderAsyncById(long orderId)
        {
            SqlDataReader? sqlDr = null;
            Order order = new Order();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OrderReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@OrderId", orderId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    order.OrderId = orderId;
                    order.CartId = (long)sqlDr["CartId"];
                    order.TotalPrice = (decimal)sqlDr["TotalPrice"];
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
            return order;
        }

        public async Task<IEnumerable<Order>> GetAllOrdersAsync()
        {
            Order order;
            SqlDataReader? sqlDr = null;
            ICollection<Order> orders = new List<Order>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OrderReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    order = new Order();
                    order.OrderId = (long)sqlDr["OrderId"];
                    order.CartId = (long)sqlDr["CartId"];
                    order.TotalPrice = (decimal)sqlDr["TotalPrice"];
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
            return orders;
        }

        public async Task<Order> UpdateOrderAsyncById(Order order)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OrderUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OrderId", order.OrderId);
                cmd.Parameters.AddWithValue("CartId", order.CartId);
                cmd.Parameters.AddWithValue("TotalPrice", order.TotalPrice);
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
            return order;
        }


        public async Task<bool> DeleteOrderAsyncById(long orderId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OrderDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OrderId", orderId);

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
