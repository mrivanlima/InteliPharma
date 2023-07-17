using InteliPharma.Console.Database;
using Nancy.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Console
{
    public class BuscarCep
    {




        public void CallWebApi(string cep, ApplicationDbContext dbContext)
        {
            //var response = client.GetAsync("https://viacep.com.br/ws/" + cep + "/json/");

            try
            {

                WebClient client = new WebClient { Encoding = Encoding.UTF8 };
                //Token token=5f46391c12531a17f587751d249c4e68"
                //'Token token=67c80e8f7b2829c7d7c9c44d3dff2970'
                var token = "Token token=5f46391c12531a17f587751d249c4e68";
                var url = "https://www.cepaberto.com/api/v3/cep?cep={0}";
                client.Headers.Add(HttpRequestHeader.Authorization, token);

                var requestResult = client.DownloadString(string.Format(url, cep));

                var jss = new JavaScriptSerializer();
                var response = jss.Deserialize<Cepinfo2>(requestResult);

                var c = new Cep();
                c.latitude = response.latitude.ToString();
                c.longitude = response.longitude.ToString();
                c.CidadeNome = (response.cidade.nome ?? "").ToString();
                c.estadoSigla = (response.estado.sigla ?? "").ToString();
                c.bairro = (response.bairro ?? "").ToString();
                c.cep = (response.cep ?? "").ToString();
                c.logradouro = (response.logradouro ?? "").ToString();
                c.ibge = response.cidade.ibge.ToString();
                c.ddd = response.cidade.ddd.ToString();
                c.Altitude = response.altitude.ToString();
                c.complemento = (response.complemento ?? "").ToString();
                dbContext.Ceps.Add(c);
                dbContext.SaveChanges();
                System.Threading.Thread.Sleep(1000);
            }
            catch (Exception e)
            {

            }
            
        }


        //public void buscar(string cep)
        //{
        //    var token = "5f46391c12531a17f587751d249c4e68";
        //    var url = "https://www.cepaberto.com/api/v3/cep?cep={0}";

        //    var client = new WebClient { Encoding = Encoding.UTF8 };
        //    client.Headers.Add(HttpRequestHeader.Authorization, token);
        //    var requestResult = client.DownloadString(string.Format(url, cep));

        //    var message = result.Content.ReadAsStringAsync();

        //    var response = jss.Deserialize<CEPAbertoResponse>(requestResult);
        //}
    }
}
