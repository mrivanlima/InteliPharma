using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class ProductRepository : IProductRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public ProductRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Product> CreateProductAsync(Product product)
        {
            SqlParameter outputProductId;
            SqlCommand cmd;

            try
            {
                outputProductId = new SqlParameter("@ProductId", SqlDbType.Int);
                outputProductId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_ProductCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductBarCode", product.ProductBarCode);
                cmd.Parameters.AddWithValue("Price", product.Price);
                cmd.Parameters.AddWithValue("Active", product.Active);
                cmd.Parameters.Add(outputProductId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                product.ProductId = (int)outputProductId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return product;
        }

        public async Task<Product> GetProductAsyncById(int productId)
        {
            SqlDataReader? sqlDr = null;
            Product product = new Product();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_ProductReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ProductId", productId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    product.ProductId = productId;
                    product.ProductBarCode = (String)sqlDr["ProductBarCode"];
                    product.Price = (decimal)sqlDr["Price"];
                    product.Active = (bool)sqlDr["Active"];
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
            return product;
        }

        public async Task<IEnumerable<Product>> GetAllProductsAsync()
        {
            Product product;
            SqlDataReader? sqlDr = null;
            ICollection<Product> products = new List<Product>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_ProductReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    product = new Product();
                    product.ProductId = (int)sqlDr["ProductId"];
                    product.ProductBarCode = (String)sqlDr["ProductBarCode"];
                    product.Price = (decimal)sqlDr["Price"];
                    product.Active = (bool)sqlDr["Active"];
                    products.Add(product);
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
            return products;
        }

        public async Task<Product> UpdateProductAsyncById(Product product)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_ProductUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductId", product.ProductId);
                cmd.Parameters.AddWithValue("ProductBarCode", product.ProductBarCode);
                cmd.Parameters.AddWithValue("Price", product.Price);
                cmd.Parameters.AddWithValue("Active", product.Active);
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
            return product;
        }


        public async Task<bool> DeleteProductAsyncById(int productId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_ProductDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductId", productId);

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
