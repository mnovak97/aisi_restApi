using Microsoft.AspNetCore.Authorization;
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
    public class TeamsController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public TeamsController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/values
        [HttpGet]
        [Authorize]
        public ActionResult<IEnumerable<TeamDto>> GetTeams()
        {
            var teams = _context.Teams.Include(t => t.Players);
            return teams.Select(TeamDto.FromTeam).ToList();
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TeamDto>> GetTeamAsync(int id)
        {
            var team = await _context.Teams.Include(t => t.Players).FirstOrDefaultAsync(t => t.Id == id);
            if(team == null)
            {
                return NotFound();
            }
            return TeamDto.FromTeam(team);
        }
        [HttpGet("{id}/Players")]
        public async Task<ActionResult<IEnumerable<Player>>> GetTeamPlayersAsync(int id)
        {
            var teams = await _context.Players.Where(p => p.TeamId == id).ToListAsync();
            return teams;
        }

        // POST api/values
        [HttpPost]
        public async Task<ActionResult<Team>> InsertTeamAsync([FromBody]Team team)
        {
            _context.Teams.Add(team);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetTeamAsync), new { id = team.Id }, team);
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTeamAsync(int id, [FromBody]Team team)
        {
            if(id != team.Id)
            {
                return BadRequest();
            }

            var teamToUpdate = await _context.Teams.FindAsync(id);
            if(teamToUpdate == null)
            {
                return NotFound();
            }

            teamToUpdate.Name = team.Name;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch(DbUpdateConcurrencyException) when (!TeamExists(id))
            {
                return NotFound();
            }

            return NoContent();
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTeamAsync(int id)
        {
            var team = await _context.Teams.FindAsync(id);
            if(team == null)
            {
                return NotFound();
            }

            _context.Teams.Remove(team);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpGet("serialize")]
        public void Serialize()
        {
            var teams = _context.Teams;
            try
            {
                DeSerialize.Serialize(teams, "teams.json");
            }
            catch (Exception ex)
            {
                Console.WriteLine("There was an error!");
            }
        }

        [HttpGet("deserialize")]
        public void Deserializer()
        {
            try
            {
                var objects = DeSerialize.Deserialize<Team>("teams.json");
                foreach (var obj in objects)
                {
                    Console.WriteLine(obj);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("There was an error with deserialization :" + e.Message);
            }
        }

        private bool TeamExists(int id)
        {
            return _context.Teams.Any(t => t.Id == id);
        }
    }
}

