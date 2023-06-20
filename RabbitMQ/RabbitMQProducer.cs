using System;
using System.Text;
using System.Text.Json;
using RabbitMQ.Client;

namespace RestApi.RabbitMQ
{
	public class RabbitMQProducer : IMessageProducer
	{
        public void SendMessage<T>(T message,string httpMethod)
        {

            var factory = new ConnectionFactory { HostName = "localhost" };
            using (var connection = factory.CreateConnection())
            {
                using (var channel = connection.CreateModel())
                {
                    channel.QueueDeclare("players", exclusive: false, autoDelete: false);
                    var json = JsonSerializer.Serialize(message);
                    byte[]? body = null;
                    if (httpMethod == "GET")
                    {
                        body = Encoding.UTF8.GetBytes(json);
                    } else if (httpMethod == "POST")
                    {
                        body = Encoding.UTF8.GetBytes(json);
                    } else if(httpMethod == "DELETE")
                    {
                        body = Encoding.UTF8.GetBytes("Deleted player: "+ json);
                    } else if(httpMethod == "PUT")
                    {
                        body = Encoding.UTF8.GetBytes("Updated player:" + json);
                    }
                    channel.BasicPublish(exchange: "", routingKey: "players", basicProperties: null, body: body);
                }
            }
        }
    }
}

