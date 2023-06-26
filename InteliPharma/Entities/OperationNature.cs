using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class OperationNature
    {
        public OperationNature() { }
        public short OperationNatureId { get; set; }
        public string OperationNatureName { get; set; } = string.Empty;
    }
}
