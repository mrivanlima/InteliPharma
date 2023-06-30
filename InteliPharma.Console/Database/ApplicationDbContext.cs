using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Console.Database
{
    public class ApplicationDbContext :DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<ZipCodeInfo> zipCodeInfo { get; set; }
        public DbSet<Cep_GeoLocation> cepGeoLocation { get; set; }
    }

    [Table("Cep_GeoLocation", Schema = "imp")]
    public class Cep_GeoLocation
    {
        [Key]
        public string postcode { get; set; }
        public string lon { get; set; }
        public string lat { get; set; }
        public string cd_geocodi { get; set; }
    }

    [Table("ZipCodeInfo", Schema = "imp")]
   
    public class ZipCodeInfo
    {
        [Key]
        public string cep { get; set; } = string.Empty;
        public string logradouro { get; set; } = string.Empty;
        public string complemento { get; set; } = string.Empty;
        public string bairro { get; set; } = string.Empty;
        public string localidade { get; set; } = string.Empty;
        public string uf { get; set; } = string.Empty;
        public string ibge { get; set; } = string.Empty;
        public string gia { get; set; } = string.Empty;
        public string ddd { get; set; } = string.Empty;
        public string siafi { get; set; } = string.Empty;
    }
}
