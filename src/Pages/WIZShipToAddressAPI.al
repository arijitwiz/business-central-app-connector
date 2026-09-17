page 50100 "WIZ Ship-to Address API"
{
    PageType = API;
    APIPublisher = 'wizcommerce';
    APIGroup = 'connector';
    APIVersion = 'v1.0';
    EntityName = 'wizShipToAddress';
    EntitySetName = 'wizShipToAddresses';
    SourceTable = "Ship-to Address";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = true;
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
                field(customerNumber; Rec."Customer No.")
                {
                    Caption = 'Customer Number';
                }
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field(postalCode; Rec."Post Code")
                {
                    Caption = 'Postal Code';
                }
                field(country; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date Time';
                    Editable = false;
                }
            }
        }
    }
}
