using System;
namespace RestApi.RabbitMQ
{
    public interface IMessageProducer
    {
        void SendMessage<T>(T message,string httpMethod);
    }

}