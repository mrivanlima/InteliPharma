using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class ProductPurchaseRepository : IProductPurchaseRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public ProductPurchaseRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<ProductPurchase> CreateProductPurchaseAsync(ProductPurchase productPurchase)
        {
            SqlParameter outputProductPurchaseId;
            SqlCommand cmd;

            try
            {
                outputProductPurchaseId = new SqlParameter("@ProductPurchaseId", SqlDbType.Int);
                outputProductPurchaseId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_ProductPurchaseCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductId", productPurchase.ProductId);
                cmd.Parameters.AddWithValue("PurchaseId", productPurchase.PurchaseId);
                cmd.Parameters.AddWithValue("Quantity", productPurchase.Quantity);
                cmd.Parameters.AddWithValue("Price", productPurchase.Price);
                cmd.Parameters.AddWithValue("PurchaseDate", productPurchase.PurchaseDate);
                cmd.Parameters.AddWithValue("Serial", productPurchase.Serial);
                cmd.Parameters.AddWithValue("ProductBarCode", productPurchase.ProductBarCode);
                cmd.Parameters.AddWithValue("ProductCode", productPurchase.ProductCode);
                cmd.Parameters.AddWithValue("NCMSH", productPurchase.NCMSH);
                cmd.Parameters.AddWithValue("CMCST", productPurchase.CMCST);
                cmd.Parameters.AddWithValue("CFOP", productPurchase.CFOP);
                cmd.Parameters.AddWithValue("UN", productPurchase.UN);
                cmd.Parameters.AddWithValue("UnitValue", productPurchase.UnitValue);
                cmd.Parameters.AddWithValue("TotalValue", productPurchase.TotalValue);
                cmd.Parameters.AddWithValue("ICMSBaseCalculation", productPurchase.ICMSBaseCalculation);
                cmd.Parameters.AddWithValue("ICMSValue", productPurchase.ICMSValue);
                cmd.Parameters.AddWithValue("IPIValue", productPurchase.IPIValue);
                cmd.Parameters.AddWithValue("ICMSPercent", productPurchase.ICMSPercent);
                cmd.Parameters.AddWithValue("IPIPercent", productPurchase.IPIPercent);

                cmd.Parameters.Add(outputProductPurchaseId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                productPurchase.ProductPurchaseId = (int)outputProductPurchaseId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return productPurchase;
        }

        public async Task<ProductPurchase> GetProductPurchaseAsyncById(int productPurchaseId)
        {
            SqlDataReader? sqlDr = null;
            ProductPurchase productPurchase = new ProductPurchase();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_ProductPurchaseReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ProductPurchaseId", productPurchaseId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    productPurchase.ProductPurchaseId = productPurchaseId;
                    productPurchase.ProductId = (int)sqlDr["ProductId"];
                    productPurchase.PurchaseId = (int)sqlDr["PurchaseId"];
                    productPurchase.Quantity = (int)sqlDr["Quantity"];
                    productPurchase.Price = (decimal)sqlDr["Price"];
                    productPurchase.PurchaseDate = (DateTime)sqlDr["PurchaseDate"];
                    productPurchase.Serial = (string)sqlDr["Serial"];
                    productPurchase.ProductBarCode = (string)sqlDr["ProductBarCode"];
                    productPurchase.ProductCode = (string)sqlDr["ProductCode"];
                    productPurchase.NCMSH = (string)sqlDr["NCMSH"];
                    productPurchase.CMCST = (string)sqlDr["CMCST"];
                    productPurchase.CFOP = (string)sqlDr["CFOP"];
                    productPurchase.UN = (short)sqlDr["UN"];
                    productPurchase.UnitValue = (decimal)sqlDr["UnitValue"];
                    productPurchase.TotalValue = (decimal)sqlDr["TotalValue"];
                    productPurchase.ICMSBaseCalculation = (decimal)sqlDr["ICMSBaseCalculation"];
                    productPurchase.ICMSValue = (decimal)sqlDr["ICMSValue"];
                    productPurchase.IPIValue = (decimal)sqlDr["IPIValue"];
                    productPurchase.ICMSPercent = (decimal)sqlDr["ICMSPercent"];
                    productPurchase.IPIPercent = (decimal)sqlDr["IPIPercent"];
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
            return productPurchase;
        }

        public async Task<IEnumerable<ProductPurchase>> GetAllProductsPurchaseAsync()
        {
            ProductPurchase productPurchase;
            SqlDataReader? sqlDr = null;
            ICollection<ProductPurchase> productsPurchase = new List<ProductPurchase>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_ProductPurchaseReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    productPurchase = new ProductPurchase();
                    productPurchase.ProductPurchaseId = (int)sqlDr["ProductPurchaseId"];
                    productPurchase.ProductId = (int)sqlDr["ProductId"];
                    productPurchase.PurchaseId = (int)sqlDr["PurchaseId"];
                    productPurchase.Quantity = (int)sqlDr["Quantity"];
                    productPurchase.Price = (decimal)sqlDr["Price"];
                    productPurchase.PurchaseDate = (DateTime)sqlDr["PurchaseDate"];
                    productPurchase.Serial = (string)sqlDr["Serial"];
                    productPurchase.ProductBarCode = (string)sqlDr["ProductBarCode"];
                    productPurchase.ProductCode = (string)sqlDr["ProductCode"];
                    productPurchase.NCMSH = (string)sqlDr["NCMSH"];
                    productPurchase.CMCST = (string)sqlDr["CMCST"];
                    productPurchase.CFOP = (string)sqlDr["CFOP"];
                    productPurchase.UN = (short)sqlDr["UN"];
                    productPurchase.UnitValue = (decimal)sqlDr["UnitValue"];
                    productPurchase.TotalValue = (decimal)sqlDr["TotalValue"];
                    productPurchase.ICMSBaseCalculation = (decimal)sqlDr["ICMSBaseCalculation"];
                    productPurchase.ICMSValue = (decimal)sqlDr["ICMSValue"];
                    productPurchase.IPIValue = (decimal)sqlDr["IPIValue"];
                    productPurchase.ICMSPercent = (decimal)sqlDr["ICMSPercent"];
                    productPurchase.IPIPercent = (decimal)sqlDr["IPIPercent"];

                    productsPurchase.Add(productPurchase);
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
            return productsPurchase;
        }

        public async Task<ProductPurchase> UpdateProductPurchaseAsyncById(ProductPurchase productPurchase)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_ProductPurchaseUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductPurchaseId", productPurchase.ProductPurchaseId);
                cmd.Parameters.AddWithValue("ProductId", productPurchase.ProductId);
                cmd.Parameters.AddWithValue("PurchaseId", productPurchase.PurchaseId);
                cmd.Parameters.AddWithValue("Quantity", productPurchase.Quantity);
                cmd.Parameters.AddWithValue("Price", productPurchase.Price);
                cmd.Parameters.AddWithValue("PurchaseDate", productPurchase.PurchaseDate);
                cmd.Parameters.AddWithValue("Serial", productPurchase.Serial);
                cmd.Parameters.AddWithValue("ProductBarCode", productPurchase.ProductBarCode);
                cmd.Parameters.AddWithValue("ProductCode", productPurchase.ProductCode);
                cmd.Parameters.AddWithValue("NCMSH", productPurchase.NCMSH);
                cmd.Parameters.AddWithValue("CMCST", productPurchase.CMCST);
                cmd.Parameters.AddWithValue("CFOP", productPurchase.CFOP);
                cmd.Parameters.AddWithValue("UN", productPurchase.UN);
                cmd.Parameters.AddWithValue("UnitValue", productPurchase.UnitValue);
                cmd.Parameters.AddWithValue("TotalValue", productPurchase.TotalValue);
                cmd.Parameters.AddWithValue("ICMSBaseCalculation", productPurchase.ICMSBaseCalculation);
                cmd.Parameters.AddWithValue("ICMSValue", productPurchase.ICMSValue);
                cmd.Parameters.AddWithValue("IPIValue", productPurchase.IPIValue);
                cmd.Parameters.AddWithValue("ICMSPercent", productPurchase.ICMSPercent);
                cmd.Parameters.AddWithValue("IPIPercent", productPurchase.IPIPercent);

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
            return productPurchase;
        }


        public async Task<bool> DeleteProductPurchaseAsyncById(int productPurchaseId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_ProductPurchaseDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ProductPurchaseId", productPurchaseId);

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
