page 50100 "Personal Self Page"
{
    ApplicationArea = All;
    Caption = 'Personal Self Page';
    PageType = List;
    SourceTable = "Personal Self Table";
    UsageCategory = Lists;

    layout
    {
        area(Content)
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
        JulianDatePrinting();
    end;

    procedure JulianDatePrinting()
    var
        YearStartDate: Date;
        CurrentYear: Integer;
        DateRec: Record Date;
        NoOfDays: Integer;
    begin
        CurrentYear := Date2DMY(Today, 3);
        YearStartDate := CalcDate('<-CY>', Today);
        Message(Format(YearStartDate));

        DateRec.SETRANGE("Period Type", DateRec."Period Type"::Date);
        DateRec.SETRANGE("Period Start", YearStartDate, Today);
        NoOfDays := DateRec.Count;
        Message(Format(CurrentYear) + Format(NoOfDays));
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
