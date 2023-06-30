using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.WebRequestMethods;

namespace InteliPharma.Console
{
    public class ApiCaller
    {
        HttpClient client = new HttpClient();

        public string CallWebApi(string cep)
        {
            //var response = client.GetAsync("https://viacep.com.br/ws/" + cep + "/json/");

            var response = client.GetAsync("https://opencep.com/v1/" + cep); 
            response.Wait();
            if (response.IsCompleted)
            {
                var result = response.Result;
                if (result.IsSuccessStatusCode)
                {
                    var message = result.Content.ReadAsStringAsync();    
                    message.Wait();
                    return message.Result;
                }
            }
            return "";
        }
    }
}
