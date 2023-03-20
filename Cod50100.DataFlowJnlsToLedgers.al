codeunit 50100 "DataFlow Frm Jnls To Ldgrs SDY"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    local procedure OnBeforeCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    var
        GLLineTemp1: Record "Gen. Journal Line";
    begin
        GLLineTemp1.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GLLineTemp1.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GLLineTemp1.SetRange("Document No.", GenJournalLine."Document No.");
        if GLLineTemp1.Count() >= 2 then
            if GenJournalLine."Bal. Account Type" in [GenJournalLine."Bal. Account Type"::"G/L Account", GenJournalLine."Bal. Account Type"::"Bank Account"] then
                CustLedgerEntry."Payment Mode SDY" := CustLedgerEntry."Payment Mode SDY"::Direct
            else
                if GenJournalLine."Bal. Account Type" in [GenJournalLine."Bal. Account Type"::"G/L Account", GenJournalLine."Bal. Account Type"::"Bank Account"] then
                    CustLedgerEntry."Payment Mode SDY" := CustLedgerEntry."Payment Mode SDY"::InDirect;
        if GLLineTemp1.Count() < 2 then
            if GenJournalLine."Bal. Account Type" in [GenJournalLine."Bal. Account Type"::"G/L Account", GenJournalLine."Bal. Account Type"::"Bank Account"] then
                CustLedgerEntry."Payment Mode SDY" := CustLedgerEntry."Payment Mode SDY"::InDirect;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeVendLedgEntryInsert', '', false, false)]
    local procedure OnBeforeVendLedgEntryInsert(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    var
        GLLineTemp1: Record "Gen. Journal Line";
        GLLineTemp2: Record "Gen. Journal Line";
    begin
        if GenJournalLine."Bal. Account Type" in [GenJournalLine."Bal. Account Type"::"G/L Account", GenJournalLine."Bal. Account Type"::"Bank Account"] then
            VendorLedgerEntry."Payment Mode SDY" := VendorLedgerEntry."Payment Mode SDY"::Direct;
    end;
}

