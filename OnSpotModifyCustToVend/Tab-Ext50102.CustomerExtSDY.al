tableextension 50102 "Customer Ext SDY" extends Customer
{
    trigger OnModify()
    var
        VendorFieldRef: FieldRef;
        CustomerFieldRef: FieldRef;
        VendRecordRef: RecordRef;
        CustRecordRef: RecordRef;
        Vendor: Record Vendor;
        Confirm: Label 'Do you want to modify the vendor';
    begin
        CustRecordRef.GetTable(Rec);
        if Vendor.Get(Rec."No.") then
            if Confirm(Confirm, true) then begin
                VendRecordRef.GetTable(Vendor);
                VendorFieldRef := VendRecordRef.FieldIndex(CurrFieldNo);
                CustomerFieldRef := CustRecordRef.FieldIndex(CurrFieldNo);
                VendorFieldRef.Value(CustomerFieldRef.Value());
                VendRecordRef.Modify(true);
            end;
    end;
}
