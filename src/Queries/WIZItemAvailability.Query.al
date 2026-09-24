query 50103 "WIZ Item Availability"
{
    QueryType = API;
    APIPublisher = 'wizcommerce';
    APIGroup = 'connector';
    APIVersion = 'v1.0';
    EntityCaption = 'Wiz Item Availability';
    EntitySetCaption = 'Wiz Item Availabilities';
    EntityName = 'wizItemAvailability';
    EntitySetName = 'wizItemAvailabilities';
    AboutText = 'Read-only item availability fields for WizCommerce inventory sync. Prefer this over multi-call inventory fallback in Business Central V2.';

    elements
    {
        dataitem(Item; Item)
        {
            column(id; SystemId)
            {
                Caption = 'Id';
            }
            column(itemNo; "No.")
            {
                Caption = 'Item No.';
            }
            column(description; Description)
            {
                Caption = 'Description';
            }
            column(inventory; Inventory)
            {
                Caption = 'Inventory';
            }
            column(qtyOnPurchOrder; "Qty. on Purch. Order")
            {
                Caption = 'Qty. on Purch. Order';
            }
            column(reservedQtyBase; "Reserved Qty. (Base)")
            {
                Caption = 'Reserved Qty. (Base)';
            }
            column(lastModifiedDateTime; SystemModifiedAt)
            {
                Caption = 'Last Modified Date Time';
            }
        }
    }
}
