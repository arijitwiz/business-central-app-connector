permissionset 50100 "WIZ CONNECTOR"
{
    Assignable = true;
    Caption = 'WizCommerce Connector';
    Permissions =
        tabledata "Ship-to Address" = RIM,
        tabledata "Sales Shipment Header" = R,
        tabledata "Sales Header Archive" = R,
        tabledata "Sales Line Archive" = R,
        tabledata "Price List Line" = R,
        tabledata Item = R,
        page "WIZ Ship-to Address API" = X,
        page "WIZ Shipment Tracking API" = X,
        page "WIZ Sales Order Archive API" = X,
        page "WIZ Sales Order Archive Line API" = X,
        page "WIZ Customer Price API" = X,
        query "WIZ Item Availability" = X;
}
