using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IProductRepository
    {
        Task<Product> CreateProductAsync(Product product);
        Task<IEnumerable<Product>> GetAllProductsAsync();
        Task<Product> GetProductAsyncById(int productId);
        Task<Product> UpdateProductAsyncById(Product product);
        Task<bool> DeleteProductAsyncById(int productId);

    }
}
