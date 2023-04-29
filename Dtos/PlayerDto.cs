using System;
using RestApi.Models;

namespace RestApi.Dtos
{
	public class PlayerDto
	{
        public int Id { get; set; }
        public string FirstName { get; set; } = default!;
        public string LastName { get; set; } = default!;
        public int TeamId { get; set; }

        public static PlayerDto FromPlayer(Player player)
        {
            return new PlayerDto
            {
                Id = player.Id,
                FirstName = player.FirstName,
                LastName = player.LastName,
                TeamId = player.TeamId
            };
        }
	}
}

