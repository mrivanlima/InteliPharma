/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
EXECUTE [Admin].usp_manage_ForeignKeyDropAll;
GO

DROP TABLE IF EXISTS [Security].UserAccount;
DROP TABLE IF EXISTS [Security].UserLoginExternal;
DROP TABLE IF EXISTS [Security].UserRole;
DROP TABLE IF EXISTS [Security].ExternalProvider;
DROP TABLE IF EXISTS [Security].UserLogin;
DROP TABLE IF EXISTS [Security].[Role];
DROP TABLE IF EXISTS App.ActivePrinciple;
DROP TABLE IF EXISTS App.Drug;
DROP TABLE IF EXISTS App.ActivePrincipleDrug;
DROP TABLE IF EXISTS App.Indication;
DROP TABLE IF EXISTS App.ActivePrincipleIndication;
DROP TABLE IF EXISTS App.Dosage;
DROP TABLE IF EXISTS App.PharmaceuticalForm;
DROP TABLE IF EXISTS App.PharmaceuticalAdministration;
DROP TABLE IF EXISTS App.AgeUsage;
DROP TABLE IF EXISTS App.[Classification];
DROP TABLE IF EXISTS App.Medication;
DROP TABLE IF EXISTS App.Manufacturer;
DROP TABLE IF EXISTS App.Medication;
DROP TABLE IF EXISTS App.MedicationType;
DROP TABLE IF EXISTS App.[State];
DROP TABLE IF EXISTS App.[Neighborhood];
DROP TABLE IF EXISTS App.[City];
DROP TABLE IF EXISTS App.Street;
DROP TABLE IF EXISTS App.ZipCode;
DROP TABLE IF EXISTS App.[Address];
DROP TABLE IF EXISTS App.[AddressType];
DROP TABLE IF EXISTS App.UserAddress;
DROP TABLE IF EXISTS App.Cart;
DROP TABLE IF EXISTS App.Product;
DROP TABLE IF EXISTS App.ProductCartUser;
DROP TABLE IF EXISTS App.[Order];
DROP TABLE IF EXISTS App.PaymentMethod;
DROP TABLE IF EXISTS App.Payment;
DROP TABLE IF EXISTS App.OrderPayment;
DROP TABLE IF EXISTS App.Purchase;
DROP TABLE IF EXISTS App.Distributor;
DROP TABLE IF EXISTS App.ContactType;
DROP TABLE IF EXISTS App.DistributorContact;
DROP TABLE IF EXISTS App.ProductPurchase;
DROP TABLE IF EXISTS App.OperationNature;
DROP TABLE IF EXISTS App.DanfeType;
DROP TABLE IF EXISTS App.Danfe;
DROP TABLE IF EXISTS App.TaxCalculation;
DROP TABLE IF EXISTS App.Transporter;
DROP TABLE IF EXISTS App.ShippingAgreement;
DROP TABLE IF EXISTS App.Stock;
DROP TABLE IF EXISTS App.Store;
DROP TABLE IF EXISTS App.Delivery;
DROP TABLE IF EXISTS App.OrderDelivery;
DROP TABLE IF EXISTS App.UserStore;
DROP TABLE IF EXISTS App.ProfessionalType;
DROP TABLE IF EXISTS App.Professional;
DROP TABLE IF EXISTS App.ProfessionalSpecialty;
DROP TABLE IF EXISTS App.Specialty;
DROP TABLE IF EXISTS App.Facility;
DROP TABLE IF EXISTS App.Contact;
DROP TABLE IF EXISTS App.FaciltiyContact;
DROP TABLE IF EXISTS App.PrescriptionType;
DROP TABLE IF EXISTS App.Prescription;
DROP TABLE IF EXISTS App.MedicationPrescriptionType;
DROP TABLE IF EXISTS App.UserDisease;
DROP TABLE IF EXISTS App.Disease;
DROP TABLE IF EXISTS App.DosageUnit;
DROP TABLE IF EXISTS App.Measurement;
DROP TABLE IF EXISTS App.UserMeasurement;
DROP TABLE IF EXISTS [log].[ErrorLog];
GO


