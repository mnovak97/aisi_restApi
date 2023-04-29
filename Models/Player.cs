using System;
namespace RestApi.Models
{
	public class Player
	{
		public int Id { get; set; } 
		public string FirstName { get; set; } = default!;
        public string LastName { get; set; } = default!;
		public int TeamId { get; set; }
		public Team Team { get; set; } = default!;

	}
}

