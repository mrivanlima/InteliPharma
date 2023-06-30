// See https://aka.ms/new-console-template for more information

using InteliPharma.Console;
using InteliPharma.Console.Database;
using Microsoft.EntityFrameworkCore;
using System.Security.Principal;
using System.Text.Json;


string path = @"C:\Users\IvanLima\Documents\OpenCEP-main\v1";
//FileReader files = new FileReader();
//files.ReadFilesFromFolder(path);

string connection = "Data Source=SQL8005.site4now.net;Initial Catalog=db_a9b211_intelipharma;User Id=db_a9b211_intelipharma_admin;Password=senha1234;";
var dbOptions = new DbContextOptionsBuilder<ApplicationDbContext>().UseSqlServer(connection).Options;
var dbContext = new ApplicationDbContext(dbOptions);

//if (dbContext != null)
//{
//    List<string> ceps = dbContext.cepGeoLocation.Select(e => e.postcode).ToList();
//    List<string> zips = dbContext.zipCodeInfo.Select(e => e.cep).ToList();
//    remaining = ceps.Except(zips).ToList();

//}

List<string> zips = dbContext.zipCodeInfo.Select(e => e.cep).ToList();

int count = 0;
foreach (string file in Directory.EnumerateFiles(path, "*.json"))
{
    string contents = File.ReadAllText(file);
    CepInfo cepInfo = JsonSerializer.Deserialize<CepInfo>(contents);

    Console.WriteLine(cepInfo.cep +  " Counter " + ++count);
    if (zips.Contains(cepInfo.cep))
    {
        continue;
    }

    else
    {
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




//List<string> remaining = new  List<string>();

//string connection = "Data Source=SQL8005.site4now.net;Initial Catalog=db_a9b211_intelipharma;User Id=db_a9b211_intelipharma_admin;Password=senha1234;";
//var dbOptions = new DbContextOptionsBuilder<ApplicationDbContext>().UseSqlServer(connection).Options;
//var dbContext = new ApplicationDbContext(dbOptions);

//if (dbContext != null)
//{
//    List<string> ceps = dbContext.cepGeoLocation.Select(e => e.postcode).ToList();
//    List<string> zips = dbContext.zipCodeInfo.Select(e => e.cep).ToList();
//   remaining = ceps.Except(zips).ToList();

//}

//foreach(var r in remaining)
//{
//    ApiCaller caller = new ApiCaller();
//    string cep = r.Remove(5, 1);
//    string result = caller.CallWebApi(cep);
//    Console.WriteLine(r);
//    if (!String.IsNullOrEmpty(result))
//    {
//        CepInfo cepInfo = JsonSerializer.Deserialize<CepInfo>(result);

//        ZipCodeInfo zipCodeInfo = new ZipCodeInfo();
//        zipCodeInfo.cep = r;
//        zipCodeInfo.logradouro = cepInfo.logradouro;
//        zipCodeInfo.complemento = cepInfo.complemento;
//        zipCodeInfo.bairro = cepInfo.bairro;
//        zipCodeInfo.localidade = cepInfo.localidade;
//        zipCodeInfo.uf = cepInfo.uf;
//        zipCodeInfo.ibge = cepInfo.ibge;
//        zipCodeInfo.gia = cepInfo.gia;
//        zipCodeInfo.ddd = cepInfo.ddd;
//        zipCodeInfo.siafi = cepInfo.siafi;


//        if (dbContext != null)
//        {
//            dbContext.zipCodeInfo.Add(zipCodeInfo);
//            dbContext.SaveChanges();
//        }
//    }
//    else
//    {
//        ZipCodeInfo zipCodeInfo = new ZipCodeInfo();
//        zipCodeInfo.cep = r;



//        if (dbContext != null)
//        {
//            dbContext.zipCodeInfo.Add(zipCodeInfo);
//            dbContext.SaveChanges();
//        }

//    }
//}






