// See https://aka.ms/new-console-template for more inforctmation

using InteliPharma.Console;
using InteliPharma.Console.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Security.Principal;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;

var builder = new ConfigurationBuilder();
builder.SetBasePath(Directory.GetCurrentDirectory())
       .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);

IConfiguration config = builder.Build();

string connectionString = config.GetSection("ConnectionString").GetSection("DevConnection").Value;


string path = @"C:\Users\IvanLima\Documents\OpenCEP-main\v1";
const Int32 BufferSize = 128;
//FileReader files = new FileReader();
//files.ReadFilesFromFolder(path);

string connection = connectionString;
var dbOptions = new DbContextOptionsBuilder<ApplicationDbContext>().UseSqlServer(connection).Options;
var dbContext = new ApplicationDbContext(dbOptions);


List<string> ceps = new List<string>();

using (var fileStream = File.OpenRead(@"C:\Users\IvanLima\Documents\ceps\MG\MG.txt"))
using (var streamReader = new StreamReader(fileStream, Encoding.UTF8, true, BufferSize))
{
    String line;
    while ((line = streamReader.ReadLine()) != null)
    {
        ceps.Add(line);
    }
}

var cs = dbContext.Ceps.Select(s => s.cep).ToList();
ceps = ceps.Except(cs).ToList();

BuscarCep cep = new BuscarCep();

var co = 0;
foreach (var c in ceps)
{
    cep.CallWebApi(c, dbContext);
    co = co + 1;

    Console.WriteLine("Number is: " + co);

    if (co == 10000)
    {
        break;
    }
}


WebScrapperDynamic d = new WebScrapperDynamic();


List<string> productDetail = dbContext.ProductDetails.Select(e => e.Registro).ToList();

var medications = dbContext.Medication.Select(m => new Tuple<string, string>(m.Registro, m.ProcessoNoAccent)).ToList();
var bulas = dbContext.Bula.Select(b => b.BulaRegister).ToList();

var bu = medications.Where(e => !bulas.Contains(e.Item1)).ToList().Distinct();

//List<ProductDetail> productDetail = dbContext.ProductDetails.ToList();

//List<Medication> processos = dbContext.Medication
//.Where(m => dbContext.ProductDetails.Any(d => d.Registro == m.Registro))
//.ToList();

var processos = medications.Where(e => !productDetail.Contains(e.Item1)).ToList();

List<string> list = new List<string>();


using (var fileStream = File.OpenRead(@"C:\Users\IvanLima\Documents\Exception\except.txt"))
using (var streamReader = new StreamReader(fileStream, Encoding.UTF8, true, BufferSize))
{
    String line;
    while ((line = streamReader.ReadLine()) != null)
    {
        list.Add(line);
    }
}

bu = bu.Where(e => !list.Contains(e.Item1)).ToList().Distinct();
Console.WriteLine(bu.Count());
var i = 0;
foreach (var b in bu)
{
    d.DynamicScrapBula(b.Item1, dbContext);
    Console.WriteLine(++i);
}

////WebScrapperDynamic d = new WebScrapperDynamic();
//foreach (var p in processos)
//{
//    d.DynamicScrap(p.Item2, dbContext);

//}



//WebScrapper scrapper = new WebScrapper();
//scrapper.scrap();

//if (dbContext != null)
//{
//    List<string> ceps = dbContext.cepGeoLocation.Select(e => e.postcode).ToList();
//    List<string> zips = dbContext.zipCodeInfo.Select(e => e.cep).ToList();
//    remaining = ceps.Except(zips).ToList();

//}



//List<string> zips = dbContext.ZipCodeInfo.Select(e => e.cep.Remove(5, 1)).ToList();

//string contentss = File.ReadAllText(@"C:\Users\IvanLima\Documents\cep.json");
//List<CepInfo> ceps = JsonSerializer.Deserialize<List<CepInfo>>(contentss);


//int counter = 0;
//foreach(var c in ceps)
//{
//    Console.WriteLine(c.cep + " Counter " + ++counter);
//    if (zips.Contains(c.cep))
//    {
//        continue;
//    }
//    else
//    {
//        ZipCodeInfo zipCodeInfo = new ZipCodeInfo();
//        zipCodeInfo.cep = c.cep;
//        zipCodeInfo.logradouro = c.rua;
//        zipCodeInfo.bairro = c.bairro;
//        zipCodeInfo.localidade = c.cidade;
//        zipCodeInfo.uf = c.estado;
        

//        if (dbContext != null)
//        {
//            dbContext.ZipCodeInfo.Add(zipCodeInfo);
//        }

//        if (dbContext != null && counter % 5000 == 0)
//        {
//            dbContext.ZipCodeInfo.Add(zipCodeInfo);
//            dbContext.SaveChanges();
//        }
//    }
//}


//int count = 0;
//foreach (string file in Directory.EnumerateFiles(path, "*.json"))
//{
//    string contents = File.ReadAllText(file);
//    CepInfo cepInfo = JsonSerializer.Deserialize<CepInfo>(contents);

//    Console.WriteLine(cepInfo.cep +  " Counter " + ++count);
//    if (zips.Contains(cepInfo.cep))
//    {
//        continue;
//    }

//    else
//    {
//        ZipCodeInfo zipCodeInfo = new ZipCodeInfo();
//        zipCodeInfo.cep = cepInfo.cep;
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
//}




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






