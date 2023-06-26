﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class Neighborhood
    {
        public Neighborhood() { }
        public short NeighborhoodId { get; set; }
        public short CityId { get; set; }
        public string NeighborhoodName { get; set; } = string.Empty;
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
    }
}
