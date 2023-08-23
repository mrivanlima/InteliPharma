using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IProductPurchaseRepository
    {
        Task<ProductPurchase> CreateProductPurchaseAsync(ProductPurchase productPurchase);
        Task<IEnumerable<ProductPurchase>> GetAllProductsPurchaseAsync();
        Task<ProductPurchase> GetProductPurchaseAsyncById(int productPurchaseId);
        Task<ProductPurchase> UpdateProductPurchaseAsyncById(ProductPurchase productPurchase);
        Task<bool> DeleteProductPurchaseAsyncById(int productPurchase);

    }
}
