using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Transporter
    {
        public Transporter() { }
        public short TransporterId { get; set; }
        public int AddressId { get; set; }
        public string TransporterName { get; set; } = string.Empty;
        public string ANTTCode { get; set; } = string.Empty;
        public string CNPJ { get; set; } = string.Empty;
        public string StateSubscription { get; set; } = string.Empty;
    }
}
