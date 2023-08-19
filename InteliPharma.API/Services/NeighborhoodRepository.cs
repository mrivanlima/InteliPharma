using InteliPharma.API.Services.DBServices;
using InteliPharma.Library.Entities;
using System.Data;
using System.Data.SqlClient;


namespace InteliPharma.API.Services
{
    public class NeighborhoodRepository : INeighborhoodRepository
    {
        private readonly IDbConn _connect;
        private readonly SqlConnection _connection;

        public NeighborhoodRepository(IDbConn connect)
        {
            _connect = connect;
            _connection = connect.GetConnection() ?? throw new ArgumentNullException(nameof(_connect));
        }

        public async Task<Neighborhood> CreateNeighborhoodAsync(Neighborhood neighborhood)
        {
            SqlParameter outputNeighborhoodId;
            SqlCommand cmd;

            try
            {
                outputNeighborhoodId = new SqlParameter("@NeighborhoodId", SqlDbType.SmallInt);
                outputNeighborhoodId.Direction = ParameterDirection.Output;
                cmd = new SqlCommand("[App].[usp_api_NeighborhoodCreate]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CityId", neighborhood.CityId);
                cmd.Parameters.AddWithValue("NeighborhoodName", neighborhood.NeighborhoodName);
                cmd.Parameters.AddWithValue("Longitude", neighborhood.Longitude);
                cmd.Parameters.AddWithValue("Latitude", neighborhood.Latitude);
                cmd.Parameters.Add(outputNeighborhoodId);

                _connection.Open();

                var result = await cmd.ExecuteNonQueryAsync();
                neighborhood.NeighborhoodId = (short)outputNeighborhoodId.Value;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                await _connection.CloseAsync();
            }
            return neighborhood;
        }

        public async Task<Neighborhood> GetNeighborhoodAsyncById(short neighborhoodId)
        {
            SqlDataReader? sqlDr = null;
            Neighborhood neighborhood = new Neighborhood();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_NeighborhoodReadById]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@NeighborhoodId", neighborhoodId));
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    neighborhood.NeighborhoodId = neighborhoodId;
                    neighborhood.NeighborhoodName = (string)sqlDr["NeighborhoodName"];
                    neighborhood.CityId = (short)sqlDr["CityId"];
                    neighborhood.Longitude = (decimal)sqlDr["Longitude"];
                    neighborhood.Latitude = (decimal)sqlDr["Latitude"];
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
            return neighborhood;
        }

        public async Task<IEnumerable<Neighborhood>> GetAllNeighborhoodsAsync()
        {
            Neighborhood neighborhood;
            SqlDataReader? sqlDr = null;
            ICollection<Neighborhood> neighborhoods = new List<Neighborhood>();
            SqlCommand cmd = new SqlCommand("[App].[usp_api_NeighborhoodReadAll]", _connection);

            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                _connection.Open();

                sqlDr = await cmd.ExecuteReaderAsync();

                while (sqlDr.Read())
                {
                    neighborhood = new Neighborhood();
                    neighborhood.NeighborhoodId = (short)sqlDr["NeighborhoodId"];
                    neighborhood.NeighborhoodName = (string)sqlDr["NeighborhoodName"];
                    neighborhood.CityId = (short)sqlDr["CityId"];
                    neighborhood.Longitude = (decimal)sqlDr["Longitude"];
                    neighborhood.Latitude = (decimal)sqlDr["Latitude"];
                    neighborhoods.Add(neighborhood);
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
            return neighborhoods;
        }

        public async Task<Neighborhood> UpdateNeighborhoodAsyncById(Neighborhood neighborhood)
        {
            SqlCommand cmd;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_NeighborhoodUpdateById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("NeighborhoodId", neighborhood.NeighborhoodId);
                cmd.Parameters.AddWithValue("NeighborhoodName", neighborhood.NeighborhoodName);
                cmd.Parameters.AddWithValue("CityId", neighborhood.CityId);
                cmd.Parameters.AddWithValue("Longitude", neighborhood.Longitude);
                cmd.Parameters.AddWithValue("Latitude", neighborhood.Latitude);
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
            return neighborhood;
        }


        public async Task<bool> DeleteNeighborhoodAsyncById(short neighborhoodId)
        {
            SqlCommand cmd;
            bool isDeleted = true;

            try
            {
                cmd = new SqlCommand("[App].[usp_api_NeighborhoodDeleteById]", _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("NeighborhoodId", neighborhoodId);

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
