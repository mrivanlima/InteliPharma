using InteliPharma.Console.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace InteliPharma.Console
{
    public class FileReader
    {



        public void ReadFilesFromFolder (string path)
        {
            string connection = "Data Source=SQL8005.site4now.net;Initial Catalog=db_a9b211_intelipharma;User Id=db_a9b211_intelipharma_admin;Password=senha1234;";
            var dbOptions = new DbContextOptionsBuilder<ApplicationDbContext>().UseSqlServer(connection).Options;
            var dbContext = new ApplicationDbContext(dbOptions);

            //if (dbContext != null)
            //{
            //    List<string> ceps = dbContext.cepGeoLocation.Select(e => e.postcode).ToList();
            //    List<string> zips = dbContext.zipCodeInfo.Select(e => e.cep).ToList();
            //    remaining = ceps.Except(zips).ToList();

            //}
            foreach (string file in Directory.EnumerateFiles(path, "*.json"))
            {
                string contents = File.ReadAllText(file);
                CepInfo cepInfo = JsonSerializer.Deserialize<CepInfo>(contents);

                ZipCodeInfo zipCodeInfo = new ZipCodeInfo();
                zipCodeInfo.cep = cepInfo.cep;
                zipCodeInfo.logradouro = cepInfo.logradouro;
                zipCodeInfo.complemento = cepInfo.complemento;
                zipCodeInfo.bairro = cepInfo.bairro;
                zipCodeInfo.localidade = cepInfo.localidade;
                zipCodeInfo.uf = cepInfo.uf;
                zipCodeInfo.ibge = cepInfo.ibge;
                zipCodeInfo.gia = cepInfo.gia;
                zipCodeInfo.ddd = cepInfo.ddd;
                zipCodeInfo.siafi = cepInfo.siafi;


                if (dbContext != null)
                {
                    dbContext.zipCodeInfo.Add(zipCodeInfo);
                    dbContext.SaveChanges();
                }
            }

        }
    }
}
