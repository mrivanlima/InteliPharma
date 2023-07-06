using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Console
{
    public  class ProductDetail
    {
        public string NomeDaEmpresaDetentora { get; set; } = string.Empty;
        public string cnpj { get; set; } = string.Empty;
        public string Autorizacao { get; set; } = string.Empty;
        public string Processo { get; set; } = string.Empty;
        public string DataDoRegistro { get; set;} = string.Empty;   
        public string CategoriaRegulatoria { get; set; } = string.Empty;
        public string NomeComercial { get; set; } = string.Empty;
        public string Registro { get; set; } = string.Empty;
        public string VencimentoDoRegistro { get; set; } = string.Empty;
        public string PrincipioAtivo { get; set; } = string.Empty;
        public string MedicamentoReferencia { get; set; } = string.Empty;
        public string CalsseTerapeutica { get; set; } = string.Empty;
        public string ATC { get; set; } = string.Empty;
        public string ParecerPublico { get; set; } = string.Empty;
        public string BularioEletronico { get; set; } = string.Empty;
        public string Rotulagem { get; set; } = string.Empty;
    }
}
