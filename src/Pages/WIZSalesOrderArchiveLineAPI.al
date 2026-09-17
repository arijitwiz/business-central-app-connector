page 50103 "WIZ Sales Order Archive Line API"
{
    PageType = API;
    APIPublisher = 'wizcommerce';
    APIGroup = 'connector';
    APIVersion = 'v1.0';
    EntityName = 'wizSalesOrderArchiveLine';
    EntitySetName = 'wizSalesOrderArchiveLines';
    SourceTable = "Sales Line Archive";
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
                field(documentNumber; Rec."Document No.")
                {
                    Caption = 'Document Number';
                }
                field(lineNumber; Rec."Line No.")
                {
                    Caption = 'Line Number';
                }
                field(itemNumber; Rec."No.")
                {
                    Caption = 'Item Number';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
            }
        }
    }
}
