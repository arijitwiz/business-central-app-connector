# Sandbox setup result (wizcommerce.onmicrosoft.com)

Verified against Business Central Sandbox on 2026-10-10.

## Environment

| Field | Value |
|---|---|
| Tenant ID | `aaf26c70-a831-4c8b-a0ad-35e35f29f7af` |
| Environment | `Sandbox` |
| Company | `CRONUS IN` |
| Company ID | `c6a9170d-f7bb-f111-85be-7ced8d9daf2f` |
| BC version | `29.0.54011.55935` |

## Extension

| Field | Value |
|---|---|
| Name | WizCommerce Connector |
| Publisher | WizCommerce |
| App ID | `f47ac10b-58cc-4372-a567-0e02b2c3d479` |
| Version | `1.0.0.0` |
| Published as | PTE |
| Installed | Yes |

## API base

```
https://api.businesscentral.dynamics.com/v2.0/aaf26c70-a831-4c8b-a0ad-35e35f29f7af/Sandbox/api/wizcommerce/connector/v1.0/companies(c6a9170d-f7bb-f111-85be-7ced8d9daf2f)/
```

## Sample call results

| Endpoint | Result |
|---|---|
| `GET /api/v2.0/companies` | 200 |
| `GET .../customers?$top=1` | 200 (`10000` Adatum Corporation) |
| `GET .../wizShipToAddresses?$top=3` | 200 (Cheltenham, London, Fleet) |
| `POST .../wizShipToAddresses` | 201 (`code=WIZTEST`) |
| `GET .../wizShipmentTrackings?$top=3` | 200 |
| `GET .../wizCustomerPrices?$top=3` | 200 (empty — no price list lines in CRONUS demo) |
| `GET .../wizItemAvailabilities?$top=3` | 200 (ATHENS Desk, etc.) |

## Next for Business Central V2

1. Create an Entra app registration (client credentials) — do not use the user password for V2.
2. In BC → **Microsoft Entra Applications** → assign **WIZ CONNECTOR**.
3. Merge `examples/workflow.data.connector.json` into the V2 workflow `data`.
4. Run buyer pull and confirm `shipping_addresses`.

## Security

Rotate any password that was shared in chat. Prefer Entra client secret for automation.
