using Microsoft.AspNetCore.Mvc.Filters;

namespace RestApi.Filter
{
    public class XContentTypeOptionsHeaderFilter : IActionFilter
    {
        public void OnActionExecuting(ActionExecutingContext context)
        {
            context.HttpContext.Response.Headers.Add("X-Content-Type-Options", "nosniff");
        }

        public void OnActionExecuted(ActionExecutedContext context)
        {
            // No action needed here
        }
    }
}