using Microsoft.EntityFrameworkCore;
using RestApi.Models;

namespace RestApi.Context
{
	public class DatabaseContext : DbContext
	{

        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
        {
            
        }
        public DbSet<Player> Players { get; set; }
		public DbSet<Team> Teams { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Player>(entity =>
            {
                entity.HasOne(t => t.Team)
                .WithMany(p => p.Players)
                .OnDelete(DeleteBehavior.Restrict);
            });
        }
    }
}

