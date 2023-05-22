pageextension 50100 "Customer Card Ext SDY" extends "Customer Card"
{
    actions
    {
        addafter("&Customer")
        {
            action(Vendor)
            {
                Caption = 'Create a new Vendor';
                ApplicationArea = All;
                Image = Create;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    VendorNo: Code[20];
                begin
                    Vendor.Init();
                    Vendor.Insert(true);
                    VendorNo := Vendor."No.";
                    Vendor.TransferFields(Rec, true, true);
                    Vendor.Validate("No.", VendorNo);
                    Vendor.Modify(true);
                end;
            }
        }
    }
}
