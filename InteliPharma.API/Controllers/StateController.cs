using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InteliPharma.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StateController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public StateController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
    }
}
