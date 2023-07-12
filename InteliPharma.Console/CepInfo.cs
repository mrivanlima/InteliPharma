using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Console
{
    public class CepInfo
    {
        public string cep { get; set; }
        public string cidade { get; set; }
        public string estado { get; set; }
        public string bairro { get; set; }
        public string rua { get; set; }
    }

    public class Cepinfo2
    {
        public Cidade cidade { get; set; }
        public Estado estado { get; set; }
        public string bairro { get; set; }
        public string cep { get; set; }
        public string logradouro { get; set; }
        public decimal? altitude { get; set; }
        public decimal? latitude { get; set; }
        public decimal? longitude { get; set; }
        public string? complemento { get; set; }

        public class Cidade
        {
            public short? ddd { get; set; }
            public int? ibge { get; set; }
            public String nome { get; set; }
        }

        public class Estado
        {
            public String sigla { get; set; }
        }

    }
}
