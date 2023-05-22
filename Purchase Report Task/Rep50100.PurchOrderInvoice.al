report 50100 "PurchOrder Invoice"
{
    ApplicationArea = All;
    Caption = 'PurchOrder Invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Purchase Report Task\PurchaseOrder.rdl';
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("No.", "Document Type") where("Document Type" = filter(Order));
            column(Header_No; "No.") { }
            column(CompanyAddress1; CompanyAddr[1]) { }
            column(CompanyAddress2; CompanyAddr[2]) { }
            column(CompanyAddress3; CompanyAddr[3]) { }
            column(CompanyAddress4; CompanyAddr[4]) { }
            column(CompanyAddress5; CompanyAddr[5]) { }
            column(CompanyAddress6; CompanyAddr[6]) { }
            column(CompanyAddress7; CompanyAddr[6]) { }
            column(CompanyAddress8; CompanyAddr[6]) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyEMail; CompanyInfo."E-Mail") { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(CompanyFaxNo; CompanyInfo."Fax No.") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_City; "Buy-from City") { }
            column(Buy_from_Contact; "Buy-from Contact") { }
            column(Vendor_Order_No_; "Vendor Order No.") { }
            column(Order_Date; "Order Date") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(S_No; SNo) { }
            column(ColorSize1; ColorSize[1]) { }
            column(ColorSize2; ColorSize[2]) { }
            column(ColorSize3; ColorSize[3]) { }
            column(ColorSize4; ColorSize[4]) { }
            column(ColorSize5; ColorSize[5]) { }
            column(ColorSize6; ColorSize[6]) { }
            column(ColorSize7; ColorSize[7]) { }
            column(ColorSize8; ColorSize[8]) { }
            column(ColorSize9; ColorSize[9]) { }
            column(QuantityReceive1; QuantityReceive[1]) { }
            column(QuantityReceive2; QuantityReceive[2]) { }
            column(QuantityReceive3; QuantityReceive[3]) { }
            column(QuantityReceive4; QuantityReceive[4]) { }
            column(QuantityReceive5; QuantityReceive[5]) { }
            column(QuantityReceive6; QuantityReceive[6]) { }
            column(QuantityReceive7; QuantityReceive[7]) { }
            column(QuantityReceive8; QuantityReceive[8]) { }
            column(QuantityReceive9; QuantityReceive[9]) { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(Document_No_; "Document No.") { }
                column(SNo; SNo) { }
                column(No_; "No.") { }
                column(Description; Description) { }
                // column(Color; Color) { }
                // column(Size; Size) { }
                column(Amount; Amount) { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Total_Quantity; Total_Quantity) { }
                column(VatAmount; VatAmount) { }
                column(ShowLineCol; ShowLineCol) { }
                column(TotalAmount; TotalAmount) { }

                // trigger OnAfterGetRecord()
                // var
                //     J: Integer;
                //     counnt: Integer;
                // begin
                //     Clear(QuantityReceive);
                //     counnt := ColorRec.Count * SizeRec.Count;

                //     if ("No." = '70061') or ("No." = '70062') then begin
                //         CS := Color + '\' + Size;
                //         SNo += 1;
                //         for J := 1 to counnt do
                //             if CS = ColorSize[J] then begin
                //                 QuantityReceive[J] := Quantity;
                //                 Total_Quantity += Quantity;
                //                 ShowLineCol := true;
                //             end;
                //     end
                //     else
                //         Clear(ShowLineCol);
                // end;
            }
            // trigger OnAfterGetRecord()
            // begin
            //     Clear(SizeRec);
            //     Clear(ColorRec);
            //     //Clear(SNo);
            //     i := 1;
            //     if ColorRec.FindSet() then
            //         repeat
            //             if SizeRec.FindSet() then
            //                 repeat
            //                     ColorSize[i] := ColorRec.Code + '\' + SizeRec.Code;
            //                     i += 1;
            //                 until SizeRec.Next() = 0;
            //         until ColorRec.Next() = 0;
            // end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                FormatAdress.FormatAddr(CompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2",
                 CompanyInfo."Contact Person", CompanyInfo.Address, CompanyInfo."Address 2",
                 CompanyInfo.City, CompanyInfo."Post Code", CompanyInfo.County, CompanyInfo."Country/Region Code");

            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(No_; "Purchase Header"."No.")
                    {
                        ApplicationArea = All;
                        TableRelation = "Purchase Header"."No.";
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        FormatAdress: Codeunit "Format Address";
        // ColorRec: Record Color;
        // SizeRec: Record Size;
        ColorSize: array[9] of Text[100];
        QuantityReceive: array[9] of Integer;

        CompanyAddr: array[8] of Text[100];
        i: Integer;
        SNo: Integer;
        Total_Quantity: Decimal;
        VatAmount: Decimal;
        TotalAmount: Decimal;
        ShowLineCol: Boolean;
        CS: Text[100];


    // local procedure CompanyAddress0()
    // begin
    //     CompanyAddr[1] := CompanyInfo.Address;
    //     CompanyAddr[2] := CompanyInfo."Address 2";
    //     CompanyAddr[3] := CompanyInfo.City;
    //     CompanyAddr[4] := CompanyInfo."Country/Region Code";
    //     CompanyAddr[5] := CompanyInfo."State Inscription";
    //     CompanyAddr[6] := CompanyInfo."Post Code";
    // end;
}
