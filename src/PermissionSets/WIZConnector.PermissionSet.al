permissionset 50100 "WIZ CONNECTOR"
{
    Assignable = true;
    Caption = 'WizCommerce Connector';
    Permissions =
        tabledata "Ship-to Address" = RIM,
        page "WIZ Ship-to Address API" = X;
}
