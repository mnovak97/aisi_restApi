using Newtonsoft.Json;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security;


namespace RestApi.Deserialization
{
    public class DeSerialize
    {
        public static void Serialize<T>(T obj, string fileName)
        {
            string json = JsonConvert.SerializeObject(obj);
            File.WriteAllText(fileName, json);
        }

        public static List<T> Deserialize<T>(string fileName)
        {
            List<T> obj;
            using (StreamReader fileStream = new StreamReader(fileName))
            {
                string json = fileStream.ReadToEnd();
                obj = JsonConvert.DeserializeObject<List<T>>(json);
                string className = typeof(T).Name;
                if (!DeserializationWhitelisting.IsClassAllowed(className))
                {
                    throw new SecurityException("Deserialization of this class is forbidden...");
                }
            }
            return obj;
        }
    }
}
