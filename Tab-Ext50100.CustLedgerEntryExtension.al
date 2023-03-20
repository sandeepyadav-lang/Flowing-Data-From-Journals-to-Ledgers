tableextension 50100 "Cust. Ledger Entry Extension" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50100; "Payment Mode SDY"; Enum "Direct or Indirect")
        {
            Caption = 'Direct or Indirect';
            DataClassification = ToBeClassified;
        }
    }
}
