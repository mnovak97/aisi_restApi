
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RestApi.Context;
using RestApi.Deserialization;
using RestApi.Dtos;
using RestApi.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace RestApi.Controllers
{
    [Route("api/[controller]")]
    public class PlayersController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public PlayersController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/values
        [HttpGet]
        public ActionResult<IEnumerable<PlayerDto>> GetPlayers()      
        {
            var players = _context.Players;
            return players.Select(PlayerDto.FromPlayer).ToList();
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PlayerDto>> GetPlayerAsync(int id)
        {
            var player = await _context.Players.FindAsync(id);
            if (player == null)
            {
                return NotFound();
            }

            var playerDto = PlayerDto.FromPlayer(player);
            return playerDto;
        }

        // POST api/values
        [HttpPost]
        public async Task<ActionResult<Player>> InserPlayerAsync([FromBody]Player player)
        {
            _context.Players.Add(player);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetPlayerAsync),new {id = player.Id},player);
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdatePlayerAsync(int id, [FromBody]Player player)
        {
            if (id != player.Id)
            {
                return BadRequest();
            }

            var playerToUpdate = await _context.Players.FindAsync(id);
            
            if (playerToUpdate == null)
            {
                return NotFound();
            }
            playerToUpdate.FirstName = player.FirstName;
            playerToUpdate.LastName = player.LastName;
            playerToUpdate.TeamId = player.TeamId;
     
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!PlayerExists(id))
            {
                return NotFound();
            }

            return NoContent();
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePlayerAsync(int id)
        {
            var player = await _context.Players.FindAsync(id);

            if(player == null)
            {
                return NotFound();
            }

            _context.Players.Remove(player);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpGet("serialize")]
        public void Serialize()
        {
            var players = _context.Players;
            try
            {
                DeSerialize.Serialize(players, "players.json");
            } catch(Exception ex)
            {
                Console.WriteLine("There was an error!");
            }
        }

        [HttpGet("deserialize")]
        public void Deserializer()
        {
            try
            {
                var objects = DeSerialize.Deserialize<Player>("players.json");
                foreach (var obj in objects)
                {
                    Console.WriteLine(obj);
                }
            } catch (Exception e)
            {
                Console.WriteLine("There was an error with deserialization :" + e.Message);
            }
        }

        private bool PlayerExists(int id)
        {
            return _context.Players.Any(p => p.Id == id);
        }
    }
}

