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
    }

    trigger OnFindRecord(Which: Text): Boolean
    var
        myInt: Integer;
    begin
        if Rec.Find(Which) then
            Self := Rec;
    end;

    trigger OnNextRecord(steps: Integer): Integer
    var
        myInt: Integer;
    begin
        if steps = 0 then
            exit;
        if Rec.Id = Self.Id then
            Rec.Find();
    end;

    var
        Name: Text;
        Id: Code[20];
        Self: Record "Personal Self Table";
}
