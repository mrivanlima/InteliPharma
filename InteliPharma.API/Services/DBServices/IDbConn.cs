using System.Data.SqlClient;

namespace InteliPharma.API.Services.DBServices
{
    public interface IDbConn
    {
        SqlConnection GetConnection();
    }
}
