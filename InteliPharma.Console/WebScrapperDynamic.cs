using InteliPharma.Console.Database;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace InteliPharma.Console
{
    public class WebScrapperDynamic
    {
        private static IWebDriver driver;
        public void DynamicScrap(string url, ApplicationDbContext dbContext)
        {
            try
            {

                driver = new ChromeDriver();
                driver.Navigate().GoToUrl("https://consultas.anvisa.gov.br/#/medicamentos/" + url + "/?numeroProcesso=" + url);
                System.Threading.Thread.Sleep(5000);
                var button = By.XPath("//a[contains(., 'Expandir Todas')]");
                driver.FindElement(button).Click();
            
                //var collections = driver.FindElements(By.ClassName("ng-pristine"));
                var collections = driver.FindElements(By.ClassName("table-responsive"));
                ProductDetail detail = new ProductDetail(); 
                ProductPresentation presentation = new ProductPresentation();
                    // List<ProductPresentation> presentations = new List<ProductPresentation>();
                    if (collections.Count > 0)
                {
                    var td = collections.FirstOrDefault().FindElements(By.TagName("td"));
                        detail = new ProductDetail();
                    detail.NomeDaEmpresaDetentora = td[0].Text;
                    detail.cnpj = td[1].Text;
                    detail.Autorizacao = td[2].Text;
                    detail.Processo = td[3].Text;
                    detail.CategoriaRegulatoria = td[4].Text;
                    detail.DataDoRegistro = td[5].Text;
                    detail.NomeComercial = td[6].Text;
                    detail.Registro = td[7].Text;
                    detail.VencimentoDoRegistro = td[8].Text;
                    detail.PrincipioAtivo = td[9].Text;
                    detail.MedicamentoReferencia = td[10].Text;
                    detail.CalsseTerapeutica = td[11].Text;
                    detail.ATC = td[12].Text;
                    detail.ParecerPublico = td[13].Text;
                    detail.BularioEletronico = td[14].Text;
                    detail.Rotulagem = td[15].Text;
                    dbContext.ProductDetails.Add(detail);

                    }
            

                if (collections.Count > 1)
                {

                    var td =  collections[1].FindElements(By.TagName("td"));
                    var tables = td.Count / 18;
               
                    for (int i = 0; i < tables; i++)
                    {
                        presentation = new ProductPresentation();
                        presentation.Numero = td[0 + (i*18)].Text;
                        presentation.Apresentacao = td[1 + (i * 18)].Text;
                        presentation.Registro = td[2 + (i * 18)].Text;
                        presentation.UpRegistro = detail.Registro;
                        presentation.FormaFarmaceutica = td[3 + (i * 18)].Text;
                        presentation.DataDePublicacao = td[4 + (i * 18)].Text;
                        presentation.Validade = td[5 + (i * 18)].Text;
                        presentation.PrincipioAtivo = td[6 + (i * 18)].Text;
                        presentation.ComplementoDiferencialDaApresentacao = td[7 + (i * 18)].Text;
                        presentation.Embalagem = td[8 + (i * 18)].Text;
                        presentation.LocalDeFabricacao = td[9 + (i * 18)].Text;
                        presentation.ViaDeAdministracao = td[10 + (i * 18)].Text;
                        presentation.Conservacao = td[11 + (i * 18)].Text;
                        presentation.RestricaoDePrescricao = td[12 + (i * 18)].Text;
                        presentation.RestricaoDeUso = td[13 + (i * 18)].Text;
                        presentation.Destinacao = td[14 + (i * 18)].Text;
                        presentation.Tarja = td[15 + (i * 18)].Text;
                        presentation.ApresentacaoFracionada = td[16 + (i * 18)].Text;

                        dbContext.ProductPresentations.Add(presentation); 
                    }
               
                }
            
                dbContext.SaveChanges();
             } 
            catch (Exception e)
            { 
            
            } 
            finally {
                driver.Close();
                
                driver.Quit();
                driver.Dispose(); 
            }
        }

        public void DynamicScrapBula(string url, ApplicationDbContext dbContext)
        {
            string path = @"C:\Users\IvanLima\Documents\Bulas";
            int error = 0;
            
            try
            {

                var options = new ChromeOptions();
                options.AddUserProfilePreference("download.default_directory", path);
                
                //options.AddUserProfilePreference("intl.accept_languages", "nl");
                //options.AddUserProfilePreference("disable-popup-blocking", "true");

                driver = new ChromeDriver(options);
                driver.Navigate().GoToUrl("https://consultas.anvisa.gov.br/#/bulario/q/?numeroRegistro=" + url);
                System.Threading.Thread.Sleep(3000);

                var collections = driver.FindElements(By.CssSelector("[ng-if='produto.idBulaPacienteProtegido']"));

                if(collections.Count == 0)
                {
                    throw new Exception("not found");
                }

                var before = Directory.GetFiles(path);
                collections[0].Click();
                System.Threading.Thread.Sleep(5000);

                var patientPath = Directory.GetFiles(path).FirstOrDefault(e => !before.Contains(e));

                //collections = driver.FindElements(By.CssSelector("[ng-if='produto.idBulaProfissionalProtegido']"));

                //before = Directory.GetFiles(path);
                //collections[0].Click();
                //System.Threading.Thread.Sleep(5000);

                //var doctorPath = Directory.GetFiles(path).FirstOrDefault(e => !before.Contains(e));


                if(string.IsNullOrEmpty(patientPath))
                {
                    error = 1;
                    throw new Exception("Need more time!");

                }
                Bula bula = new Bula {
                   BulaPatientPath = patientPath,
                   BulaDoctorPath = null,
                   BulaRegister = url
                };

                dbContext.Bula.Add(bula);
                dbContext.SaveChanges();
            }
            catch (Exception e)
            {
                if (error == 0)
                {
                    File.AppendAllText(@"C:\Users\IvanLima\Documents\Exception\except.txt", url + Environment.NewLine);
                }
            }
            finally
            {
                driver.Close();
                driver.Quit();
                driver.Dispose();
            }
        }
    }
}
