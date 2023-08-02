page 50100 "Personal Self Page"
{
    ApplicationArea = All;
    Caption = 'Personal Self Page';
    PageType = List;
    SourceTable = "Personal Self Table";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field(Id; Rec.Id)
            {
                Caption = 'ID';
                ApplicationArea = All;
            }
            field(Name; Rec.Name)
            {
                Caption = 'Name';
                ApplicationArea = All;
            }

        }
        // actions
        // {
        //     area(Processing)
        //     {
        //         action(crate)
        //         {
        //             ApplicationArea = All;

        //             trigger OnAction()
        //             var
        //                 FieldReference: FieldRef;
        //                 RecordReference: RecordRef;
        //                 TableID: Integer;
        //                 IDT: Variant;
        //                 IDTName: Variant;
        //                 Object: Record Object;
        //                 fieldRecord: Record Field;
        //                 cm: Record "Company Information";
        //                 Customtable: Record Custom;
        //                 PrimryKeys: Text;
        //                 PrimaryKeysAfterDivision: List of [Text];
        //                 i: Integer;
        //             begin
        //                 Object.SetRange(Type, Object.Type::Table);
        //                 Object.SetRange(Modified, true);
        //                 Object.SetRange(ID, 0, 50000);
        //                 if Object.FindSet() then
        //                     repeat
        //                         Customtable."Table Id" := Object.ID;
        //                         RecordReference.Open(Customtable."Table Id");
        //                         for i := 1 to RecordReference.KeyIndex(1).FieldCount do begin
        //                             // FieldReference := Customtable.FieldNo()
        //                             IDT := RecordReference.KeyIndex(1).FieldIndex(i).Number;
        //                             IDTName := IDT;
        //                         end;
        //                     until Object.Next() = 0;
        //             end;
        //         }
        //     }
        //}
    }
    trigger OnOpenPage()
    var
        Boo: Code[20];
        DateText: Text;
    begin
        //For example of exit with return value
        Boo := ExampleForExit();
        Message(Boo);
        // For formatting the date
        DateText := Format(WorkDate(), 0, '<Day,2>. <Month,2>. <Year4>');
        Message(DateText);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        if Rec.Find(Which) then
            Self := Rec;
    end;

    trigger OnNextRecord(steps: Integer): Integer
    begin
        if steps = 0 then
            exit;
        if Rec.Id = Self.Id then
            Rec.Find();
    end;

    local procedure ExampleForExit(): Code[20]
    var
        Customer: Record Customer;
    begin
        Customer.SetRange("No.", '10000');
        if Customer.FindFirst() then
            exit(Customer."No.");
    end;

    var
        Self: Record "Personal Self Table";
}
