using System;
using RestApi.Models;

namespace RestApi.Dtos
{
	public class TeamDto
	{
        public int Id { get; set; }
        public string Name { get; set; } = default!;
        public IEnumerable<PlayerDto>? Players { get; set; }

        public static TeamDto FromTeam(Team team)
        {
            return new TeamDto
            {
                Id = team.Id,
                Name = team.Name,
                Players = team.Players.Select(PlayerDto.FromPlayer)
            };
        }
    }
}

