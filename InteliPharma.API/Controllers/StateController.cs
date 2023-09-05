using AutoMapper;
using InteliPharma.API.Models;
using InteliPharma.API.Services;
using InteliPharma.Library.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InteliPharma.API.Controllers
{
    [ApiController]
    [Route("api/estado")]
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

        [HttpPost(Name = "CriarEstado")]
        public async Task<ActionResult<StateViewModel>> CreateState(StateViewModel state)
        {
            var result = _mapper.Map<State>(state);
            var StateViewModel = await _stateRepository.CreateStateAsync(result);
            if (StateViewModel == null)
            {
                return BadRequest();
            }
            return CreatedAtRoute("estado", new { StateId = result.StateId }, _mapper.Map<StateViewModel>(result));
        }

        [HttpGet("{stateId}", Name = "estado")]
        public async Task<ActionResult<StateViewModel>> GetStateById(byte stateId)
        {
            var state = await _stateRepository.GetStateAsyncById(stateId);
            if (state.StateId < 1)
            {
                return NotFound();
            }

            return Ok(_mapper.Map<StateViewModel>(state));
        }

        [HttpGet(Name = "estados")]
        public async Task<ActionResult<IEnumerable<StateViewModel>>> GetStatesAll()
        {
            var states = await _stateRepository.GetAllStatesAsync();
            if (states.Count() < 1)
            {
                return NotFound();
            }
            return Ok(_mapper.Map<IEnumerable<StateViewModel>>(states));
        }



        [HttpPut(Name = "AtualizarEstado")]
        public async Task<ActionResult<StateViewModel>> UpdateState(StateViewModel state)
        {
            var result = _mapper.Map<State>(state);
            var StateViewModel = await _stateRepository.UpdateStateAsyncById(result);
            if (StateViewModel == null)
            {
                return NotFound();
            }
            return NoContent();
        }

        [HttpDelete(Name = "DeletarEstado")]
        public async Task<ActionResult<StateViewModel>> DeleteState(byte stateId)
        {
            //var result = _mapper.Map<State>(state);
            var StateViewModel = await _stateRepository.DeleteStateAsyncById(stateId);
            if (!StateViewModel)
            {
                return NotFound();
            }
            return Ok();
        }
    }
}
