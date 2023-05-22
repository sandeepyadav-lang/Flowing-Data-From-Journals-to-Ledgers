tableextension 50101 "Vendor Led Entry Extension" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50100; "Payment Mode SDY"; Enum "Direct or Indirect")
        {
            Caption = 'Direct or Indirect';
            DataClassification = CustomerContent;
        }
    }
}
