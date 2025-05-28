# CollabBoard 🎨✏️

[![Ruby](https://img.shields.io/badge/Ruby-3.x+-red.svg)](https://ruby-lang.org)
[![Rails](https://img.shields.io/badge/Rails-8.0+-red.svg)](https://rubyonrails.org)
[![License](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](LICENSE)

A real-time collaborative whiteboard with Post-it notes and modern authentication. Perfect for remote teams to brainstorm visually.

## ✨ Features

- **Passkey Authentication** 🔑  
  Secure login with WebAuthn (passkeys) and password fallback

- **Real-time Collaboration** ⚡  
  Live updates via ActionCable with user presence indicators

- **Interactive Post-its** 📝  
  - Color-coded notes  
  - Drag-and-drop positioning  
  - Author attribution  
  - Markdown support

- **Whiteboard Tools** 🖌️  
  - Freehand drawing  
  - Text boxes  
  - Shape tools

## 🚀 Getting Started

### Prerequisites
- Ruby 3.2.2+
- PostgreSQL 14+
- Node.js 18+

### Installation
1. Clone the repo:
   ```bash
   git clone https://github.com/ybart/collabboard.git
   ```
2. Install dependencies and start server:
   ```bash
   bin/setup
   ```

## 📚 Documentation

- [Authentication Flow](docs/AUTHENTICATION.md)
- [API Endpoints](docs/API.md)
- [Architecture](docs/ARCHITECTURE.md)

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the GNU Affero General Public License v3.0 (AGPL-3.0).  

**Key requirements**:
- Source code must be shared with network users
- Modifications must be licensed under AGPLv3
- Patent grant included

## 📬 Contact

Yvan Barthélemy  
[![Bluesky](https://img.shields.io/badge/Bluesky-@ybart.fr-1180FE.svg)](https://bsky.app/profile/ybart.fr)  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-yvan.barthelemy-0077B5.svg)](https://www.linkedin.com/in/yvan.barthelemy/)  
[Contact Form](https://www.ilyba.fr/contact)  

Project Link: [https://github.com/ybart/collabboard](https://github.com/ybart/collabboard)
