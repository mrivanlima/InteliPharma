namespace InteliPharma.API.Models
{
    public class StateViewModel
    {
        public byte StateId { get; set; }
        public string StateName { get; set; } = string.Empty;
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
    }
}
