using AutoMapper;
using InteliPharma.API.Models;
using InteliPharma.Library.Entities;

namespace InteliPharma.API.Profiles
{
    public class StateProfile : Profile
    {
        public StateProfile() 
        { 
            CreateMap<State, StateViewModel>().ReverseMap();
        }
    }
}
