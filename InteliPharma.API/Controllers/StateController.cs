using AutoMapper;
using InteliPharma.API.Models;
using InteliPharma.API.Services;
using InteliPharma.Library.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InteliPharma.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class StateController : ControllerBase
    {

        private readonly IMapper _mapper;
        private readonly IStateRepository _stateRepository;

        public StateController(IStateRepository stateRepository,
                               IMapper mapper)
        {
            _stateRepository = stateRepository ?? throw new ArgumentNullException(nameof(stateRepository)); ;
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper)); ;   
        }

        [HttpPost]
        public async Task<ActionResult<StateViewModel>> CreateState(StateViewModel state)
        {
            var result = _mapper.Map<State>(state);
            var StateViewModel = await _stateRepository.CreateStateAsync(result);
            return CreatedAtRoute("state",  _mapper.Map<StateViewModel>(result));
        }
    }
}
