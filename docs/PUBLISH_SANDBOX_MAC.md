# Publish WizCommerce Connector to Business Central Sandbox (Mac)

Sandbox only. Do **not** submit to Partner Center / AppSource in this flow.

Repo: https://github.com/arijitwiz/business-central-app-connector

## Before you start

You need:

- Business Central **Sandbox** admin access
- Microsoft account that can sign in to that Sandbox
- Mac with internet access
- This repository cloned (do not create a new AL project or a new `app.json` GUID)

---

## Step 1 — Open Extension Management in Sandbox

1. Open [businesscentral.dynamics.com](https://businesscentral.dynamics.com) and select your **Sandbox**.
2. Press **⌥ Option + Q** (or click Search).
3. Search for **Extension Management**.
4. Open the page.
5. Check whether **WizCommerce Connector** is already installed.
   - If it exists, note publisher / version / app ID.
   - Do **not** uninstall or replace it until you confirm the same `app.json` `id` GUID.

---

## Step 2 — Install tools on Mac

### 2.1 Visual Studio Code

Download and install: [code.visualstudio.com](https://code.visualstudio.com/)

### 2.2 AL Language extension

1. In VS Code press **⇧ Shift + ⌘ Command + X**
2. Search for **AL Language**
3. Install the **Microsoft** extension
4. Confirm it shows **Disable** (meaning it is enabled)

### 2.3 Reload VS Code

1. Press **⇧ Shift + ⌘ Command + P**
2. Run **Developer: Reload Window**
3. Wait for VS Code to reopen

---

## Step 3 — Open this repository

1. In VS Code: **File → Open Folder…**
2. Open `business-central-app-connector`
3. Confirm you see:
   - `app.json`
   - `src/Pages/*.al`
   - `src/Queries/*.al`
   - `src/PermissionSets/*.al`
   - `.vscode/launch.json`

If you do not have the folder yet:

```bash
git clone git@github.com:arijitwiz/business-central-app-connector.git
cd business-central-app-connector
```

Do **not** run **AL: Go!** to create a new project. That would create a new extension identity.

---

## Step 4 — Configure Sandbox launch settings

Open `.vscode/launch.json`.

Minimal cloud Sandbox target:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "WizCommerce Sandbox",
      "type": "al",
      "request": "launch",
      "environmentType": "Sandbox",
      "environmentName": "Sandbox",
      "tenant": "YOUR_TENANT_ID",
      "startupObjectId": 50100,
      "startupObjectType": "Page",
      "breakOnError": true,
      "launchBrowser": true
    }
  ]
}
```

Replace:

| Field | Where to get it |
|---|---|
| `tenant` | Microsoft Entra tenant ID (GUID) from [Entra admin](https://entra.microsoft.com) or BC Admin Center — not guessed from the URL alone |
| `environmentName` | Exact Sandbox environment name from BC Admin Center (often `Sandbox`) |

Keep any extra AL properties your extension version needs. Confirm values in the Business Central Admin Center before publishing.

Docs: [AL launch.json](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-json-launch-file)

---

## Step 5 — Download symbols and build

1. Press **⇧ Shift + ⌘ Command + P**
2. Run **AL: Download Symbols**
3. Sign in with the Microsoft account that can access the Sandbox
4. Wait until symbols finish downloading
5. Fix any dependency / compile errors shown in **Problems**
6. Build the package:
   - Command Palette → **AL: Package**, or
   - **⇧ Shift + ⌘ Command + B**

Expected result:

- Dependencies under `.alpackages/`
- Compiled `.app` in the project output (exact path depends on AL setup)

Do **not** publish yet if symbols download or compile failed.

---

## Step 6 — Publish to Sandbox only

Confirm `.vscode/launch.json` still targets **Sandbox**.

1. Press **⇧ Shift + ⌘ Command + P**
2. Prefer one of:
   - **AL: Publish**
   - **AL: Publish without debugging**
   - Or **Run → Start Debugging** if that is how your AL version publishes
3. Review the target environment in any prompt
4. Sign in if asked
5. Wait for success in the **Output** panel (AL Language)

Mac keyboard note: **F5** may need **fn + F5**. Command Palette is clearer.

Do **not**:

- Open Partner Center
- Create an AppSource offer
- Publish to Production

---

## Step 7 — Verify installation

Back in Business Central Sandbox:

1. Open **Extension Management**
2. Find **WizCommerce Connector**
3. Check:
   - Publisher = `WizCommerce`
   - Version matches `app.json` (e.g. `1.0.0.0`)
   - Status = installed / published

If missing, open VS Code **View → Output → AL**, copy the publish error, and fix before retrying.

Do not overwrite an installed extension until `app.json` `id` and version are confirmed correct.

---

## Step 8 — Configure permissions and authentication

### 8.1 Entra app registration

1. Open [entra.microsoft.com](https://entra.microsoft.com)
2. Create or reuse a test app registration (same pattern as BC V2)
3. Record:
   - Tenant ID
   - Client ID
   - Client secret (store securely)
4. Scope used by V2:

```
https://api.businesscentral.dynamics.com/.default
```

### 8.2 Assign permission set in Business Central

1. In BC Sandbox search for **Microsoft Entra Applications**
2. Add / open the app using the client ID
3. Enable it
4. Assign permission set **WIZ CONNECTOR**
5. Keep standard API access the app already needs for `/api/v2.0`

Use least privilege. Do not grant SUPER just to make APIs work.

Docs: [Microsoft Entra applications in Business Central](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/administration/automation-apis-using-s2s-authentication)

---

## Step 9 — Test connector APIs

Base path:

```
https://api.businesscentral.dynamics.com/v2.0/{tenant}/{environment}/api/wizcommerce/connector/v1.0/companies({companyId})/
```

Use `examples/postman-connector.http` or Postman with client-credentials token.

This phase implements **ship-to only**:

| Entity | Ops |
|---|---|
| `wizShipToAddresses` | GET, POST, PATCH |

Primary smoke test:

```
GET .../wizShipToAddresses?$top=1
```

Also verify:

1. `GET /api/v2.0/companies` works with the same credentials
2. Correct `companyId` is used
3. Permission set **WIZ CONNECTOR** is assigned (no 401/403)
4. Returned JSON field names match V2 expectations (`customerNumber`, etc.)

---

## Step 10 — Connect to WizCommerce Business Central V2

Only after Sandbox API tests pass:

1. Create / open a `BUSINESS_CENTRAL_V2` workflow for the **test tenant only**
2. Add independent auth settings:
   - `tenant_id`
   - `client_id`
   - `client_secret`
   - `environment`
   - `company_id`
3. Merge `examples/workflow.data.connector.json` (buyer `shipping_addresses` only)
4. Run buyer pull end-to-end
5. Confirm ship-to addresses appear on buyer meta

Each customer’s credentials and `workflow.data` stay independent. Do not reuse Sandbox secrets in production.

---

## Quick checklist

| # | Step | Done when |
|---|---|---|
| 1 | Extension Management open | Sandbox visible |
| 2 | VS Code + AL Language | AL commands available after reload |
| 3 | Repo open | `app.json` visible |
| 4 | `launch.json` | Sandbox + correct tenant/env |
| 5 | Download Symbols + Package | Build succeeds |
| 6 | Publish | No AppSource / Partner Center |
| 7 | Extension Management | WizCommerce Connector installed |
| 8 | Entra + WIZ CONNECTOR | API auth ready |
| 9 | GET ship-to | JSON returns |
| 10 | V2 workflow | Buyer pull enriches addresses |

## Common failures

| Symptom | Fix |
|---|---|
| No **AL: Download Symbols** | Install AL Language, reload window, open folder that contains `app.json` |
| Symbols auth fails | Wrong Microsoft account / no Sandbox access |
| Publish goes to wrong env | Fix `environmentType` / `environmentName` / `tenant` |
| 401/403 on connector URL | Assign **WIZ CONNECTOR** to Entra app in BC |
| 404 on connector URL | Extension not published, or wrong publisher/group/version |
| Duplicate extension identity | You ran AL: Go! — reopen this repo instead |
