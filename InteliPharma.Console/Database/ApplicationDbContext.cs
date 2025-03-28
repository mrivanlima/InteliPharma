﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Console.Database
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<ZipCodeInfo> ZipCodeInfo { get; set; }
        public DbSet<Cep_GeoLocation> CepGeoLocation { get; set; }
        public DbSet<Medication> Medication { get; set; }

        public DbSet<ProductDetail> ProductDetails { get; set; }
        public DbSet<ProductPresentation> ProductPresentations { get; set; }
        public DbSet<Bula> Bula { get; set; }
        public DbSet<Cep> Ceps { get; set; }
        public DbSet<Comercio> Comercios { get; set; }
        public DbSet<Empresa> Empresas { get; set; }
    }

    [Table("consulta_empresas_nacionais", Schema = "imp")]
    public class Empresa
    {

        [Key]
        public string Numero { get; set; } = String.Empty;
        public string CNPJ { get; set; } = String.Empty;
        public string EmpresaNome { get; set; } = String.Empty;
        public string Produto { get; set; } = String.Empty;
        public string Situacao { get; set; } = String.Empty;
        public string Cidade { get; set; } = String.Empty;
        public string UF { get; set; } = String.Empty;
        public string Autorizacao { get; set; } = String.Empty;
        public string Concessao { get; set; } = String.Empty;

    }

    [Table("Comercio", Schema = "imp")]
    public class Comercio
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ComercioId { get; set; }
        public string Numero { get; set; } = String.Empty;
        public string RazaoSocial { get; set; } = String.Empty;
        public string CNPJ { get; set; } = String.Empty;
        public string Fantasia { get; set; } = String.Empty;
        public string Web { get; set; } = String.Empty;
        public string Endereco { get; set; } = String.Empty;
        public string Cidade { get; set; } = String.Empty;
        public string SAC { get; set; } = String.Empty;
    }

    [Table("CepInfo2", Schema = "imp")]
    public class Cep
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CepId { get; set; }
        public string? CidadeNome { get; set; } = string.Empty;
        public string? ibge { get; set; } = string.Empty;
        public string? ddd { get; set; } = string.Empty;
        public string? estadoSigla { get; set; } = string.Empty;
        public string? Altitude { get; set; } = string.Empty;
        public string? longitude { get; set; } = string.Empty;
        public string? bairro { get; set; } = string.Empty;
        public string? complemento { get; set; } = string.Empty;
        public string? cep { get; set; } = string.Empty;
        public string? logradouro { get; set; } = string.Empty;
        public string? latitude { get; set; } = string.Empty;
    }



    [Table("Bula", Schema = "imp")]
    public class Bula
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BulaId { get; set; }
        public string BulaRegister { get; set; } = string.Empty;
        public string BulaPatientPath { get; set; } = string.Empty;
        public string BulaDoctorPath { get;set; } = string.Empty;   

    }

    [Table("Cep_GeoLocation", Schema = "imp")]
    public class Cep_GeoLocation
    {
        [Key]
        public string postcode { get; set; }
        public string lon { get; set; }
        public string lat { get; set; }
        public string cd_geocodi { get; set; }
    }

    [Table("ZipCodeInfo", Schema = "imp")]
   
    public class ZipCodeInfo
    {
        [Key]
        public string cep { get; set; } = string.Empty;
        public string logradouro { get; set; } = string.Empty;
        public string complemento { get; set; } = string.Empty;
        public string bairro { get; set; } = string.Empty;
        public string localidade { get; set; } = string.Empty;
        public string uf { get; set; } = string.Empty;
        public string ibge { get; set; } = string.Empty;
        public string gia { get; set; } = string.Empty;
        public string ddd { get; set; } = string.Empty;
        public string siafi { get; set; } = string.Empty;
    }

    [Table("Medication", Schema = "stg")]
    public class Medication
    {
        [Key]
        public string NomeDoProduto { get; set; } = string.Empty;
        public string PrincipioAtivo { get; set; } = string.Empty;
        public string PrincipioAtivoNoAccent { get; set; } = string.Empty;  
        public string Registro { get; set; } = string.Empty;
        public string Processo { get; set; } = string.Empty;
        public string ProcessoNoAccent { get; set; } = string.Empty;
        public string CNPJ { get; set; } = string.Empty;
        public string Situacao { get; set; } = string.Empty;
        public string Vencimento { get; set; } = string.Empty;
    }

    [Table("ProductPresentation", Schema = "stg")]
    
    public class ProductPresentation
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Numero { get; set; } = string.Empty;

        
        public string Apresentacao { get; set; } = string.Empty;
        public string Registro { get; set; } = string.Empty;
        public string UpRegistro { get; set; } = string.Empty;
        public string FormaFarmaceutica { get; set; } = string.Empty;
        public string DataDePublicacao { get; set; } = string.Empty;
        public string Validade { get; set; } = string.Empty;
        public string PrincipioAtivo { get; set; } = string.Empty;
        public string ComplementoDiferencialDaApresentacao { get; set; } = string.Empty;
        public string Embalagem { get; set; } = string.Empty;
        public string LocalDeFabricacao { get; set; } = string.Empty;
        public string ViaDeAdministracao { get; set; } = string.Empty;
        public string Conservacao { get; set; } = string.Empty;
        public string RestricaoDePrescricao { get; set; } = string.Empty;
        public string RestricaoDeUso { get; set; } = string.Empty;
        public string Destinacao { get; set; } = string.Empty;
        public string Tarja { get; set; } = string.Empty;
        public string ApresentacaoFracionada { get; set; } = string.Empty;
    }

    [Table("ProductDetail", Schema = "stg")]
    public class ProductDetail
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string NomeDaEmpresaDetentora { get; set; } = string.Empty;
        public string cnpj { get; set; } = string.Empty;
        public string Autorizacao { get; set; } = string.Empty;
        public string Processo { get; set; } = string.Empty;
        public string DataDoRegistro { get; set; } = string.Empty;
        public string CategoriaRegulatoria { get; set; } = string.Empty;
        public string NomeComercial { get; set; } = string.Empty;
        public string Registro { get; set; } = string.Empty;
        public string VencimentoDoRegistro { get; set; } = string.Empty;
        public string PrincipioAtivo { get; set; } = string.Empty;
        public string MedicamentoReferencia { get; set; } = string.Empty;
        public string CalsseTerapeutica { get; set; } = string.Empty;
        public string ATC { get; set; } = string.Empty;
        public string ParecerPublico { get; set; } = string.Empty;
        public string BularioEletronico { get; set; } = string.Empty;
        public string Rotulagem { get; set; } = string.Empty;
    }
}
