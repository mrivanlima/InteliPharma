using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Distributor
    {
        public Distributor() { }
        public int DistributorId { get; set; }
        public string DistributorName { get; set; } = string.Empty;
        public int AddressId { get; set; }
        public string CNPJ { get; set; } = string.Empty;
        public string StateSubscription { get; set; } = string.Empty;
    }
}
