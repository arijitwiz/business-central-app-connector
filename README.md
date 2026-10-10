# WizCommerce Business Central Connector

Thin Business Central extension that exposes **only the data Microsoft APIV2 does not give us**, for use by existing **Business Central V2**.

Repo: https://github.com/arijitwiz/business-central-app-connector

## What this is

```
Customer Business Central
  ├── Microsoft APIV2          → customers, orders, items, invoices, payments, archives
  └── WizCommerce Connector    → ship-tos, prices, tracking, usable inventory
            │
            ▼ OAuth (same Entra app as today)
     Business Central V2
            │
            ▼
      WizCommerce
```

- **Exposes data** via OData API pages/queries
- **Does not** own sync logic (that stays in V2 / Kaiba)
- **Does not** copy Shopify-style in-BC sync engines
- **Does not** put Atlas/BMC/customer-specific mapping in AL

Pattern reference: Microsoft [APIV2](https://github.com/microsoft/BCApps/tree/main/src/Apps/W1/APIV2)  
Go-to-market reference: partner installs add-on → Entra app → permission set → external SaaS calls OData

## Locked API contract

| Property | Value |
|---|---|
| APIPublisher | `wizcommerce` |
| APIGroup | `connector` |
| APIVersion | `v1.0` |

Base path:

```
/api/wizcommerce/connector/v1.0/companies({companyId})/
```

## Endpoints (v1)

| Entity set | Source | Ops | Why not Microsoft APIV2 |
|---|---|---|---|
| `wizShipToAddresses` | Ship-to Address | GET POST PATCH | No dedicated customer ship-to address book API |
| `wizShipmentTrackings` | Sales Shipment Header | GET | Carrier / package tracking for V2 enricher |
| `wizCustomerPrices` | Price List Line | GET | No clean customer price projection |
| `wizItemAvailabilities` | Item (API query) | GET | Prefer one call over V2 multi-call inventory fallback |

**Not in this app:** sales order archives — use Microsoft `/api/v2.0/.../salesOrderArchives`.

## Project layout

```
├── app.json
├── .vscode/launch.json
├── src/
│   ├── Pages/
│   │   ├── WIZShipToAddressAPI.al      (50100)
│   │   ├── WIZShipmentTrackingAPI.al   (50101)
│   │   └── WIZCustomerPriceAPI.al      (50102)
│   ├── Queries/
│   │   └── WIZItemAvailability.Query.al (50103)
│   └── PermissionSets/
│       └── WIZConnector.PermissionSet.al (50100)
└── examples/
    ├── workflow.data.connector.json
    └── postman-connector.http
```

## Publish to Sandbox (Mac)

Full step-by-step guide:

→ **[docs/PUBLISH_SANDBOX_MAC.md](docs/PUBLISH_SANDBOX_MAC.md)**

Short path:

1. Install VS Code + **AL Language**, then **Developer: Reload Window**
2. Open this repo (do not run **AL: Go!**)
3. Set Sandbox `tenant` / `environmentName` in `.vscode/launch.json`
4. **AL: Download Symbols** → build → **AL: Publish** (Sandbox only)
5. In BC: **Extension Management** → confirm **WizCommerce Connector**
6. Entra app + assign permission set **WIZ CONNECTOR**
7. Test `GET .../wizShipToAddresses?$top=1`
8. Merge `examples/workflow.data.connector.json` into BC V2 workflow `data`
9. Run buyer pull — ship-tos on meta, no Python changes

Sandbox only in this phase. No Partner Center / AppSource submission yet.

## Object IDs

Sandbox range `50100–50103`. Renumber into Microsoft partner range (`70,000,000+`) before AppSource. Never change `app.json` `id` GUID.
