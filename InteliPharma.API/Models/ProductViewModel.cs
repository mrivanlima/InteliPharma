namespace InteliPharma.API.Models
{
    public class ProductViewModel
    {
        public int ProductId { get; set; }
        public String ProductBarCode { get; set; } = String.Empty;
        public decimal Price { get; set; }
        public bool Active { get; set; }
    }
}
