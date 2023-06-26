using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Library.Entities
{
    public class TaxCalculation
    {
        public TaxCalculation() { }
        public int TaxCalculationId { get; set; }
        public decimal ICMSBaseCalculation { get; set; }
        public decimal ICMSValue { get; set; }
        public decimal ICMSBaseStateCalculation { get; set; }
        public decimal ICMSValueState { get; set; }
        public decimal ValueImportation { get; set; }
        public decimal ICMSValueStateRemit { get; set; }
        public decimal ICPValue { get; set; }
        public decimal PISValue { get; set; }
        public decimal TotalProductValue { get; set; }
        public decimal ShipmentValue { get; set; }
        public decimal InsuranceValue { get; set; }
        public decimal Discount { get; set; }
        public decimal OtherExpenses { get; set; }
        public decimal IPITotalValue { get; set; }
        public decimal ICMSValueStateDestination { get; set; }
        public decimal TotalTributationValue { get; set; }
        public decimal ConfinsValue { get; set; }
        public decimal TotalNoteValue { get; set; }
    }
}
