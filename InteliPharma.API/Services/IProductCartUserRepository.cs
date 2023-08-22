using InteliPharma.Library.Entities;

namespace InteliPharma.API.Services
{
    public interface IProductCartUserRepository
    {
        Task<ProductCartUser> CreateProductCartUserAsync(ProductCartUser productCartUser);
        Task<IEnumerable<ProductCartUser>> GetAllProductCartUsersAsync();
        Task<ProductCartUser> GetProductCartUserAsyncById(long productCartUserId);
        Task<ProductCartUser> UpdateProductCartUserAsyncById(ProductCartUser productCartUser);
        Task<bool> DeleteProductCartUserAsyncById(long productCartUserId);

    }
}
