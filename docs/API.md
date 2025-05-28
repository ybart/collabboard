# API Endpoints 📡

## Whiteboards
- `GET /whiteboards` - List all
- `POST /whiteboards` - Create new

## Post-its
- `POST /whiteboards/:id/post_its` - Create
- `PATCH /whiteboards/:id/post_its/:id` - Update position/content
- `DELETE /whiteboards/:id/post_its/:id` - Remove

## Authentication
- `POST /users/sign_in` - Passkey/password login
- `POST /users/passkeys` - Register new passkey 