query 50105 "WIZ Item Availability"
{
    QueryType = API;
    APIPublisher = 'wizcommerce';
    APIGroup = 'connector';
    APIVersion = 'v1.0';
    EntityName = 'wizItemAvailability';
    EntitySetName = 'wizItemAvailabilities';

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
