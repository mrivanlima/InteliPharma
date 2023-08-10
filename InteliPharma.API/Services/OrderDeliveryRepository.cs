using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class OrderDeliveryRepository : IOrderDeliveryRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public OrderDeliveryRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<OrderDelivery> CreateOrderDeliveryAsync(OrderDelivery orderDelivery)
        {
            SqlParameter outputOrderDeliveryId;
            SqlCommand cmd;

            try
            {
                outputOrderDeliveryId = new SqlParameter("@OrderDeliveryId", SqlDbType.BigInt);
                outputOrderDeliveryId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_OrderDeliveryCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("DeliveryId", orderDelivery.DeliveryId);
                cmd.Parameters.AddWithValue("OrderId", orderDelivery.OrderId);
                cmd.Parameters.AddWithValue("DriverId", orderDelivery.DriverId);
                cmd.Parameters.AddWithValue("AddressId", orderDelivery.AddressId);
                cmd.Parameters.AddWithValue("ProductCartUserId", orderDelivery.ProductCartUserId);
                cmd.Parameters.AddWithValue("DeliveryStartDate", orderDelivery.DeliveryStartDate);
                cmd.Parameters.AddWithValue("DeliveryEndDate", orderDelivery.DeliveryEndDate);
                cmd.Parameters.AddWithValue("Completed", orderDelivery.Completed);
                cmd.Parameters.Add(outputOrderDeliveryId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                orderDelivery.OrderDeliveryId = (long)outputOrderDeliveryId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return orderDelivery;
        }

        public async Task<OrderDelivery> GetOrderDeliveryAsyncById(long orderDeliveryId)
        {
            SqlDataReader? sqlDr = null;
            OrderDelivery orderDelivery = new OrderDelivery();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OrderDeliveryReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@OrderDeliveryId", orderDeliveryId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    orderDelivery.OrderDeliveryId = orderDeliveryId;
                    orderDelivery.DeliveryId = (long)sqlDr["DeliveryId"];
                    orderDelivery.OrderId = (int)sqlDr["OrderId"];
                    orderDelivery.DriverId = (int)sqlDr["DriverId"];
                    orderDelivery.AddressId = (int)sqlDr["AddressId"];
                    orderDelivery.ProductCartUserId = (long)sqlDr["ProductCartUserId"];
                    orderDelivery.DeliveryStartDate = (DateTime)sqlDr["DeliveryStartDate"];
                    orderDelivery.DeliveryEndDate = (DateTime)sqlDr["DeliveryEndDate"];
                    orderDelivery.Completed = (bool)sqlDr["Completed"];
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
            return orderDelivery;
        }

        public async Task<IEnumerable<OrderDelivery>> GetAllOrderDeliveriesAsync()
        {
            OrderDelivery orderDelivery;
            SqlDataReader? sqlDr = null;
            ICollection<OrderDelivery> orderDeliveries = new List<OrderDelivery>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_OrderDeliveryReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    orderDelivery = new OrderDelivery();
                    orderDelivery.OrderDeliveryId = (long)sqlDr["OrderDeliveryId"];
                    orderDelivery.DeliveryId = (long)sqlDr["DeliveryId"];
                    orderDelivery.OrderId = (int)sqlDr["OrderId"];
                    orderDelivery.DriverId = (int)sqlDr["DriverId"];
                    orderDelivery.AddressId = (int)sqlDr["AddressId"];
                    orderDelivery.ProductCartUserId = (long)sqlDr["ProductCartUserId"];
                    orderDelivery.DeliveryStartDate = (DateTime)sqlDr["DeliveryStartDate"];
                    orderDelivery.DeliveryEndDate = (DateTime)sqlDr["DeliveryEndDate"];
                    orderDelivery.Completed = (bool)sqlDr["Completed"];
                    orderDeliveries.Add(orderDelivery);
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
            return orderDeliveries;
        }

        public async Task<OrderDelivery> UpdateOrderDeliveryAsyncById(OrderDelivery orderDelivery)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OrderDeliveryUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OrderDeliveryId", orderDelivery.OrderDeliveryId);
                cmd.Parameters.AddWithValue("DeliveryId", orderDelivery.DeliveryId);
                cmd.Parameters.AddWithValue("OrderId", orderDelivery.OrderId);
                cmd.Parameters.AddWithValue("DriverId", orderDelivery.DriverId);
                cmd.Parameters.AddWithValue("AddressId", orderDelivery.AddressId);
                cmd.Parameters.AddWithValue("ProductCartUserId", orderDelivery.ProductCartUserId);
                cmd.Parameters.AddWithValue("DeliveryStartDate", orderDelivery.DeliveryStartDate);
                cmd.Parameters.AddWithValue("DeliveryEndDate", orderDelivery.DeliveryEndDate);
                cmd.Parameters.AddWithValue("Completed", orderDelivery.Completed);
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
            return orderDelivery;
        }


        public async Task<bool> DeleteOrderDeliveryAsyncById(long orderDeliveryId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_OrderDeliveryDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("OrderDeliveryId", orderDeliveryId);

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
