# Authentication Flow 🔐

## Passkey Authentication
1. User initiates registration/login
2. Browser prompts for passkey creation/use
3. Server verifies WebAuthn challenge
4. Session established

## Password Fallback
```mermaid
graph TD
    A[JS Disabled?] -->|Yes| B[Show Password Form]
    A -->|No| C[Attempt Passkey]
    C -->|Success| D[Authenticate]
    C -->|Failure| B
```

## Key Models
- `User`: `webauthn_id` (nullable)
- `Passkey`: Stores public keys 