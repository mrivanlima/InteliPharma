using AutoMapper;
using InteliPharma.API.Models;
using InteliPharma.Library.Entities;

namespace InteliPharma.API.Profiles 
{
    public class ProductProfile : Profile 
    {
        public ProductProfile()
        {
            CreateMap<Product, ProductViewModel>().ReverseMap();
        }
    
    
    }

}
