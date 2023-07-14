using System.ComponentModel.DataAnnotations;

namespace InteliPharma.Blazor.Models
{
    public class StateViewModel
    {
        public byte StateId { get; set; }
        [Required(ErrorMessage = "Nome do estado nao pode ser vazio.")]
        public string StateName { get; set; } = string.Empty;
        [MinLength(2, ErrorMessage = "Sigla nao pode ser menor ou maior que caracteres.")]
        [MaxLength(2, ErrorMessage = "Sigla nao pode ser menor ou maior que caracteres.")]
        public string StateAbbreviation { get; set; } = string.Empty;
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
    }
}
