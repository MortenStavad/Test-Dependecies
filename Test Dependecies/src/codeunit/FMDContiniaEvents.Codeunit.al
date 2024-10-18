codeunit 50000 "FMD Continia Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CTS-CDN PEPPOL BIS3 Inv.", 'OnBeforeCreatePaymentMeans', '', true, true)]
    local procedure OnBeforeCreatePaymentMeansPEPPOL(SalesInvoiceHeader: Record "Sales Invoice Header"; var RootNode: Codeunit "CSC XML Node"; var PaymentType: Option Bank,KID,FIK; var PaymentID: Text[1024]; var AccountID: Code[50]; var FinancialInstitutionBranchID: Text[1024]; var Handled: Boolean)
    var
        CompanyInformation: Record "Company Information";
        PaymentReference: Text;
    begin
        if not CompanyInformation.Get() then
            CompanyInformation.Init();

        PaymentType := PaymentType::FIK;
        // Betalings ID      
        PaymentReference := CopyStr(SalesInvoiceHeader.GetPaymentReference(), 5);
        PaymentID := '71#' + CopyStr(PaymentReference, 1, StrPos(PaymentReference, '+') - 1);
        // Kreditornummer 
        // AccountID := CompanyInformation.BankCreditorNo;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CTS-CDN OIOUBL Export Inv.", 'OnSetPaymentMeans', '', true, true)]
    local procedure OnSetPaymentMeans(SalesInvoiceHeader: Record "Sales Invoice Header"; var RootNode: Codeunit "CSC XML Node"; var PaymentType: Option Bank,KID,FIK; VAR PaymentID: Text[1024]; VAR AccountID: Code[50]; VAR FinancialInstitutionBranchID: Text[1024]; VAR InstructionID: Text[1024]; VAR PaymentDueDate: Date; VAR Handled: Boolean)
    var
        CompanyInformation: Record "Company Information";
    begin
        if not CompanyInformation.Get() then
            CompanyInformation.Init();
        PaymentType := PaymentType::FIK;
        // Betalings ID      
        PaymentID := '71';
        // Fakturanummer     
        InstructionID := CopyStr(SalesInvoiceHeader.GetPaymentReference(), 1, MaxStrLen(InstructionID));
        // Kreditornummer    
        // AccountID := CompanyInformation.BankCreditorNo;
    end;
}