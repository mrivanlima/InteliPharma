using System.Data.SqlClient;

namespace InteliPharma.API.Services.DBServices
{
    public interface IDbConnection
    {
        SqlConnection GetConnection();
    }
}
