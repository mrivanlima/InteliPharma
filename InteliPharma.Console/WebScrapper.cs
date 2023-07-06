using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HtmlAgilityPack;

namespace InteliPharma.Console
{
    public class WebScrapper
    {
        public void scrap()
        {
            string url = "https://consultas.anvisa.gov.br/#/medicamentos/25351668917201032/?numeroProcesso=25351668917201032";
            var httpClient = new HttpClient();
            var html = httpClient.GetStringAsync(url).Result;
            var htmlDocument = new HtmlDocument();
            htmlDocument.LoadHtml(html);

            var a = htmlDocument.DocumentNode.SelectSingleNode("//form[@class='ng-pristine']");

            
        }
    }
}
