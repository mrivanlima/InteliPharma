using System.Data.SqlClient;

namespace InteliPharma.API.Services.DBServices
{
    public class DbConnection : IDbConn
    {
        public SqlConnection connection { get; }
        public DbConnection()
        {
            var configuration = GetConfiguration();
            connection = new SqlConnection(configuration.GetSection("ConnectionStrings").GetSection("DevConnection").Value);
        }

        public SqlConnection GetConnection()
        {
            return connection;
        }

        private IConfigurationRoot GetConfiguration()
        {
            var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
            return builder.Build();
        }

       
    }
}
