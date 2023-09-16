using AutoMapper;
using InteliPharma.API.Models;
using InteliPharma.API.Services;
using InteliPharma.Library.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InteliPharma.API.Controllers 
{
    [ApiController]
    [Route("api/Produto")]
    public class ProductController : ControllerBase 
    {
    
        private readonly IMapper _mapper;
        private readonly IProductRepository _productRepository;

        public ProductController(IProductRepository productRepository,
                                 IMapper mapper)
        { 
            _productRepository = productRepository ?? throw new ArgumentNullException(nameof(productRepository)); ;
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper)); ;
        }

        [HttpPost(Name = "Adicionar Produto")]
        public async Task<ActionResult<ProductViewModel>> CreateProduct(ProductViewModel product)
        {
            var result = _mapper.Map<Product>(product);
            var ProductViewModel = await _productRepository.CreateProductAsync(result);
            if (ProductViewModel == null) 
            {
                return BadRequest();
            }
            return CreatedAtRoute("produto", new { ProductId = result.ProductId }, _mapper.Map<ProductViewModel>(result));
        
        
        }
        [HttpGet("{productId}", Name = "produto")]
        public async Task<ActionResult<ProductViewModel>> GetProductById(int productId)
        {
            var product = await _productRepository.GetProductAsyncById(productId);
            if (product.ProductId < 1)
            {
                return NotFound();
            }
            return Ok(_mapper.Map<ProductViewModel>(product));
        }



    }






}