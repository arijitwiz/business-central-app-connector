page 50101 "WIZ Shipment Tracking API"
{
    PageType = API;
    APIPublisher = 'wizcommerce';
    APIGroup = 'connector';
    APIVersion = 'v1.0';
    EntityName = 'wizShipmentTracking';
    EntitySetName = 'wizShipmentTrackings';
    SourceTable = "Sales Shipment Header";
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
                field(shipmentNumber; Rec."No.")
                {
                    Caption = 'Shipment Number';
                }
                field(shippingAgent; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent';
                }
                field(packageTrackingNo; Rec."Package Tracking No.")
                {
                    Caption = 'Package Tracking No.';
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
