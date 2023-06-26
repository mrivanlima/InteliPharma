using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class ExternalProvider
    {
        public ExternalProvider() { }
        public short ExternalProviderId { get; set; }
        public string Providername { get; set; } = string.Empty;
        public string WSEndPoint { get; set; } = string.Empty;
    }
}
