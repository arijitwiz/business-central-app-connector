page 50102 "WIZ Sales Order Archive API"
{
    PageType = API;
    APIPublisher = 'wizcommerce';
    APIGroup = 'connector';
    APIVersion = 'v1.0';
    EntityName = 'wizSalesOrderArchive';
    EntitySetName = 'wizSalesOrderArchives';
    SourceTable = "Sales Header Archive";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'Number';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(versionNumber; Rec."Version No.")
                {
                    Caption = 'Version Number';
                }
                field(customerNumber; Rec."Sell-to Customer No.")
                {
                    Caption = 'Customer Number';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                    Editable = false;
                }
                part(wizSalesOrderArchiveLines; "WIZ Sales Order Archive Line API")
                {
                    Caption = 'Wiz Sales Order Archive Lines';
                    EntityName = 'wizSalesOrderArchiveLine';
                    EntitySetName = 'wizSalesOrderArchiveLines';
                    SubPageLink = "Document Type" = field("Document Type"),
                                  "Document No." = field("No."),
                                  "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                  "Version No." = field("Version No.");
                }
            }
        }
    }
}
