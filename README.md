# WizCommerce Business Central Connector

Thin Business Central extension for **ship-to addresses only** (Phase 1). Used by existing **Business Central V2**.

Repo: https://github.com/arijitwiz/business-central-app-connector

## What this is

```
Customer Business Central
  ├── Microsoft APIV2          → customers, orders, items, invoices, payments, ...
  └── WizCommerce Connector    → wizShipToAddresses
            │
            ▼ OAuth (same Entra app as today)
     Business Central V2
            │
            ▼
      WizCommerce
```

- **Exposes** customer ship-to address book (table Ship-to Address)
- **Does not** own sync logic (stays in V2 / Kaiba)
- Other gap APIs (prices, tracking, inventory) are out of scope for now

## Locked API contract

| Property | Value |
|---|---|
| APIPublisher | `wizcommerce` |
| APIGroup | `connector` |
| APIVersion | `v1.0` |
| Entity set | `wizShipToAddresses` |

```
/api/wizcommerce/connector/v1.0/companies({companyId})/wizShipToAddresses
```

| Ops | Supported |
|---|---|
| GET | Yes |
| POST | Yes |
| PATCH | Yes |
| DELETE | No |

## Project layout

```
├── app.json
├── .vscode/launch.json
├── src/
│   ├── Pages/
│   │   └── WIZShipToAddressAPI.al      (50100)
│   └── PermissionSets/
│       └── WIZConnector.PermissionSet.al (50100)
└── examples/
    ├── workflow.data.connector.json
    └── postman-connector.http
```

Permission set **WIZ CONNECTOR** grants only:

- `tabledata "Ship-to Address" = RIM`
- `page "WIZ Ship-to Address API" = X`

## Publish / configure

→ **[docs/PUBLISH_SANDBOX_MAC.md](docs/PUBLISH_SANDBOX_MAC.md)**  
→ **[docs/SANDBOX_SETUP_RESULT.md](docs/SANDBOX_SETUP_RESULT.md)** (live Sandbox proof)

Short path:

1. Publish to Sandbox
2. Assign **WIZ CONNECTOR** to the Entra app
3. `GET .../wizShipToAddresses?$top=1`
4. Point V2 buyer `shipping_addresses` at the connector URL
5. Run buyer pull

## Object IDs

Sandbox range `50100`. Never change `app.json` `id` GUID. Bump `version` before republishing over an installed build.
