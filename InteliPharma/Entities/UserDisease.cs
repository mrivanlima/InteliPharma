using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class UserDisease
    {
        public UserDisease() { }
        public int UserDiseaseId { get; set; }
        public int UserId { get; set; }
        public int DiseaseId { get; set; }
    }
}
