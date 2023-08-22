using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class ProductCartUserRepository : IProductCartUserRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public ProductCartUserRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<ProductCartUser> CreateProductCartUserAsync(ProductCartUser productCartUser)
        {
            SqlParameter outputProductCartUserId;
            SqlCommand cmd;

            try
            {
                outputProductCartUserId = new SqlParameter("@ProductCartUserId", SqlDbType.BigInt);
                outputProductCartUserId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_ProductCartUserCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductId", productCartUser.ProductId);
                cmd.Parameters.AddWithValue("CartId", productCartUser.CartId);
                cmd.Parameters.AddWithValue("UserId", productCartUser.UserId);
                cmd.Parameters.AddWithValue("AddedOn", productCartUser.AddedOn);
                cmd.Parameters.AddWithValue("Active", productCartUser.Active);
                cmd.Parameters.Add(outputProductCartUserId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                productCartUser.ProductCartUserId = (long)outputProductCartUserId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return productCartUser;
        }

        public async Task<ProductCartUser> GetProductCartUserAsyncById(long productCartUserId)
        {
            SqlDataReader? sqlDr = null;
            ProductCartUser productCartUser = new ProductCartUser();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_ProductCartUserReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ProductCartUserId", productCartUserId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    productCartUser.ProductCartUserId = productCartUserId;
                    productCartUser.ProductId = (long)sqlDr["ProductId"];
                    productCartUser.CartId = (long)sqlDr["CartId"];
                    productCartUser.UserId = (int)sqlDr["UserId"];
                    productCartUser.AddedOn = (DateTime)sqlDr["AddedOn"];
                    productCartUser.Active = (bool)sqlDr["Active"];
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
            return productCartUser;
        }

        public async Task<IEnumerable<ProductCartUser>> GetAllProductCartUsersAsync()
        {
            ProductCartUser productCartUser;
            SqlDataReader? sqlDr = null;
            ICollection<ProductCartUser> productCartUsers = new List<ProductCartUser>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_ProductCartUserReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    productCartUser = new ProductCartUser();
                    productCartUser.ProductCartUserId = (long)sqlDr["ProductCartUserId"];
                    productCartUser.ProductId = (long)sqlDr["ProductId"];
                    productCartUser.CartId = (long)sqlDr["CartId"];
                    productCartUser.UserId = (int)sqlDr["UserId"];
                    productCartUser.AddedOn = (DateTime)sqlDr["AddedOn"];
                    productCartUser.Active = (bool)sqlDr["Active"];
                    productCartUsers.Add(productCartUser);
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
            return productCartUsers;
        }

        public async Task<ProductCartUser> UpdateProductCartUserAsyncById(ProductCartUser productCartUser)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_ProductCartUserUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductCartUserId", productCartUser.ProductCartUserId);
                cmd.Parameters.AddWithValue("ProductId", productCartUser.ProductId);
                cmd.Parameters.AddWithValue("CartId", productCartUser.CartId);
                cmd.Parameters.AddWithValue("UserId", productCartUser.UserId);
                cmd.Parameters.AddWithValue("AddedOn", productCartUser.AddedOn);
                cmd.Parameters.AddWithValue("Active", productCartUser.Active);
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
            return productCartUser;
        }


        public async Task<bool> DeleteProductCartUserAsyncById(long productCartUserId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_ProductCartUserDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductCartUserId", productCartUserId);

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
