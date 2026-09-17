# business-central-app-connector

WizCommerce Business Central Connector `.app` — custom OData APIs that fill gaps Microsoft’s standard `/api/v2.0` does not expose.

Used with existing **Business Central V2** via `workflow.data` only. No V1 changes. No new integration type.

## API contract (locked)

| Property | Value |
|---|---|
| APIPublisher | `wizcommerce` |
| APIGroup | `connector` |
| APIVersion | `v1.0` |

Base path:

```
/api/wizcommerce/connector/v1.0/companies({companyId})/
```

## Endpoints

| Entity set | Source | Ops |
|---|---|---|
| `wizShipToAddresses` | Ship-to Address | GET, POST, PATCH |
| `wizShipmentTrackings` | Sales Shipment Header | GET |
| `wizSalesOrderArchives` | Sales Header Archive (+ lines expand) | GET |
| `wizCustomerPrices` | Price List Line | GET |
| `wizItemAvailabilities` | Item (API query) | GET |

## Project layout

```
├── app.json
├── .vscode/launch.json
├── src/
│   ├── Pages/
│   │   ├── WIZShipToAddressAPI.al
│   │   ├── WIZShipmentTrackingAPI.al
│   │   ├── WIZSalesOrderArchiveAPI.al
│   │   ├── WIZSalesOrderArchiveLineAPI.al
│   │   └── WIZCustomerPriceAPI.al
│   ├── Queries/
│   │   └── WIZItemAvailability.Query.al
│   └── PermissionSets/
│       └── WIZConnector.PermissionSet.al
└── examples/
    ├── workflow.data.connector.json
    ├── workflow.data.ship-to.json
    ├── postman-connector.http
    └── postman-ship-to.http
```

## Publish to a BC sandbox

1. Open this folder in VS Code with the **AL Language** extension.
2. Set `environmentName` in `.vscode/launch.json`.
3. **AL: Download Symbols**
4. `Ctrl+Shift+B` (compile)
5. `Ctrl+F5` (publish / install)

## Configure access

1. In BC → **Microsoft Entra Applications**
2. Open the app registration used by V2
3. Assign permission set **WIZ CONNECTOR**

## Test

Use `examples/postman-connector.http` with the same OAuth as V2:

- Scope: `https://api.businesscentral.dynamics.com/.default`
- Grant: `client_credentials`

## Connect to Business Central V2

Merge `examples/workflow.data.connector.json` into the V2 workflow `data` (keep auth secrets).

Customers / orders / invoices stay on Microsoft standard APIs. Only gap entities use the connector URLs.

## Proof path (start here)

1. Publish extension  
2. Assign **WIZ CONNECTOR**  
3. `GET .../wizShipToAddresses?$top=1`  
4. Point buyer `shipping_addresses` at the connector URL  
5. Run buyer pull → addresses on meta  

Object IDs `50100–50105` are for sandbox only. Renumber into the Microsoft partner range before AppSource.
