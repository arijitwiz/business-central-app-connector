permissionset 50100 "WIZ CONNECTOR"
{
    Assignable = true;
    Caption = 'WizCommerce Connector';
    Permissions =
        tabledata "Ship-to Address" = RIM,
        tabledata "Sales Shipment Header" = R,
        tabledata "Price List Line" = R,
        tabledata Item = R,
        page "WIZ Ship-to Address API" = X,
        page "WIZ Shipment Tracking API" = X,
        page "WIZ Customer Price API" = X,
        query "WIZ Item Availability" = X;
}
