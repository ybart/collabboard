# Project Tracking

## Pending Features

### Authentication Flow

- [x] Add passkey authentification on new accounts creation (requestinng name for passkey)
- [ ] Password fallack when WebAuthn fails or is unavailable
  - [ ] Hide Passkey label field by default and show it only when we got webauthn credential
  - [ ] Show password field by default and hide it after successful webauthn credential generation
- [ ] For connected user, trigger webauthn registration flow is no passkey is associated.
- [ ] Migrate passkey-related JS to a stimulus controller

### Other

- [ ] The whole board should always fit whatever the viewport configuration.
      If the view is too small, we should have a autoscroll (the view scrolls when the mouse moves).
      On mobile, we should design an appropriate UI (when dragging, it zooms out to show full board, user moves, user stops, it zooms in so the user can drag precisely and drop, if user stops while dragging it zooms out again, and so on).
- [ ] Implement writing with a marker (there should be subtools : text / free path)
- [ ] Add real-time collaboration using ActionCable
- [ ] Implement magnify view
- [ ] Implement draft board view
- [ ] Implement retrospective workflow (put 5 post-it in tools)
- [ ] Implement drag-and-drop for whiteboard tools
- [ ] Add user authentication (Devise)
- [ ] Improve participant avatars with dynamic data

## In Progress

- [ ] Implement adding post-it notes

## Completed

- [x] Fix vertical scrollbar issue in whiteboard view
- [x] Create whiteboard controller and views
- [x] Style whiteboard with Tailwind CSS
- [x] Basic Devise user authentication setup