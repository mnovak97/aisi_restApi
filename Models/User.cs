namespace RestApi.Models
{
    public class User
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string RefreshToken { get; set; } = string.Empty;
        public DateTime TokenCreated { get; set; }
        public DateTime TokenExpires { get; set; }

        public User(string username,string password)
        {
            Username = username;
            Password = password;
        }
    }
}
