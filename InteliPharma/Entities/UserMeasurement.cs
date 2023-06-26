using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class UserMeasurement
    {
        public UserMeasurement() { }
        public int UserMeasurementId { get; set; }
        public int UserId { get; set; }
        public int MeasurementId { get; set; }
        public DateTime UserMeasurementDate { get; set; }
    }
}
