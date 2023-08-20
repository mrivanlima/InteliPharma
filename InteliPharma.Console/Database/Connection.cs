using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Console.Database
{
    public class Connect : IConnect
    {
        private readonly string _connectionString;
        private DbContextOptions<ApplicationDbContext> dbOptions;
        private ApplicationDbContext dbContext;

        public Connect() {

            var builder = new ConfigurationBuilder();
            builder.SetBasePath(Directory.GetCurrentDirectory())
                   .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

            IConfiguration config = builder.Build();

            _connectionString = config.GetSection("ConnectionString").GetSection("DevConnection").Value;

            dbOptions = new DbContextOptionsBuilder<ApplicationDbContext>().UseSqlServer(_connectionString).Options;
            dbContext = new ApplicationDbContext(dbOptions);

        }

        public ApplicationDbContext GetContext()
        {
            return dbContext;
        }
    }
}
