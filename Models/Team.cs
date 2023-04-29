using System;
namespace RestApi.Models
{
	public class Team
	{
		public int Id { get; set; }
		public string Name { get; set; } = default!;
		public IEnumerable<Player> Players { get; set; } = default!;

	}
}

