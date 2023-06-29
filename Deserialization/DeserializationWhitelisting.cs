using RestApi.Models;

namespace RestApi.Deserialization
{
    public class DeserializationWhitelisting
    {
        private DeserializationWhitelisting() { }

        private static readonly List<string> ALLOWED_CLASSES = new List<string> {
            "Player"
        };

        public static bool IsClassAllowed(string className)
        {
            return ALLOWED_CLASSES.Contains(className);
        }
    }
}
