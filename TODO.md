# Project Tracking

## Pending Features

- [ ] The whole board should always fit whatever the viewport configuration.
      If the view is too small, we should have a autoscroll (the view scrolls when the mouse moves).
      On mobile, we should design an appropriate UI (when dragging, it zooms out to show full board, user moves, user stops, it zooms in so the user can drag precisely and drop, if user stops while dragging it zooms out again, and so on).
- [ ] Implement writing with a marker (there should be subtools : text / free path)
- [ ] Add real-time collaboration using ActionCable
     [ ] Put user avatar next to the object they create/update
     [ ] Add animations
- [ ] Implement magnify view
- [ ] Implement draft board view
- [ ] Implement retrospective workflow (put 5 post-it in tools)
- [ ] Improve participant avatars with dynamic data
- [ ] Password fallback when WebAuthn fails or is unavailable (currently the fallback activates based on JS availability)
- [ ] A password user should be able to add a passkey to their account (currently the flow does not work well)
- [ ] Migrate passkey-related JS to a stimulus controller

## In Progress

- [ ] Implemente moving post-it notes (currently they duplicate)

## Completed

- [x] Fix vertical scrollbar issue in whiteboard view
- [x] Create whiteboard controller and views
- [x] Style whiteboard with Tailwind CSS
- [x] Basic Devise user authentication setup
- [x] Add user authentication (Devise)
- [x] Implement adding post-it notes
- [x] Implement drag-and-drop for whiteboard tools
- [x] Add passkey authentification on new accounts creation (requestinng name for passkey)
- [x] Account can be created with passwords when JS is not available
