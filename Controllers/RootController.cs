using System.Diagnostics;
using System.Threading.Tasks;
using Google.Cloud.PubSub.V1;
using Microsoft.AspNetCore.Mvc;

namespace AspNetPubsubWindows.Controllers
{
    [ApiController]
    [Route("/")]
    public class RootController : ControllerBase
    {
        [HttpGet]
        public async Task<IActionResult> Get([FromServices] PublisherClient publisherClient)
        {
            var stopwatch = new Stopwatch();
            stopwatch.Start();
            await publisherClient.PublishAsync("Hello everyone. It's great to be with you around this global campfire.");
            stopwatch.Stop();
            return Ok($"Publish took {stopwatch.ElapsedMilliseconds}ms");
        }
    }
}