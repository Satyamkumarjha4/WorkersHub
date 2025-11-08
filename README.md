# 🧱 WorkersHub
> **Connecting local workers to digital opportunities**

![Hackathon Badge](https://img.shields.io/badge/HackCBS-2025-blueviolet?style=for-the-badge)
![Made with Flutter](https://img.shields.io/badge/Made%20with-Flutter-02569B?style=for-the-badge&logo=flutter)
![Backend Express](https://img.shields.io/badge/Backend-Express.js-green?style=for-the-badge&logo=express)
![Database Supabase](https://img.shields.io/badge/Database-Supabase-3FCF8E?style=for-the-badge&logo=supabase)
![License](https://img.shields.io/badge/License-None-lightgrey?style=for-the-badge)

---

## 🚀 Overview
**WorkersHub** is a cross-platform mobile application designed to bridge the gap between **clients** and **local service providers** (workers).  
It helps connect small-scale laborers like electricians, plumbers, carpenters, and home service providers with potential clients — **digitally and transparently**.

The platform ensures:
- Verified profiles & trusted connections 🤝  
- Transparent bidding and payments 💰  
- Real-time chat & progress tracking 💬  
- Improved opportunities for unorganized labor 👷‍♂️  

---

## 🧩 Problem Statement
In India’s unorganized labor sector, most work is spread through **word of mouth** —  
✅ No review system  
✅ No digital visibility  
✅ No structured client–worker matching  

**WorkersHub** solves this by providing a unified digital platform for job posting, bidding, and secure payment handling.

---

## 🎯 Vision
> *To empower small-scale workers by connecting them to a broader digital audience and creating a transparent, competitive, and review-based work ecosystem.*

---

## 👥 Target Users
- 🧰 Electricians, plumbers, carpenters  
- 🧹 House helpers & daily-wage workers  
- 🍳 Chefs, interior designers, and freelancers  
- 🏠 Clients seeking affordable, reliable home or local services  

---

## ⚙️ Features

### 👤 **For Clients**
- Post jobs & accept bids from nearby workers  
- Review worker profiles with ratings  
- Chat directly (with images & updates)  
- Pay securely via Razorpay (escrow model)  
- Track work progress through to-do updates  

### 🧑‍🔧 **For Workers**
- Browse & bid for jobs based on skills & location  
- Maintain verified profiles with ratings  
- Chat with clients post-selection  
- Apply via subscription model (limited monthly bids)  

---

## 🧠 System Architecture

```
        +------------------+          +------------------+
        |    Flutter App   | <------> |  Express Backend |
        | (Client & Worker)|          | (REST + Sockets) |
        +------------------+          +------------------+
                   |                           |
                   |     Prisma ORM            |
                   v                           v
            +---------------------------------------+
            |           Supabase PostgreSQL         |
            +---------------------------------------+
```

- **Frontend:** Flutter (Custom UI, Dio Client, Supabase Auth)  
- **Backend:** Express.js + Prisma ORM  
- **Database:** Supabase PostgreSQL  
- **Real-time Communication:** Socket.io  
- **Payment Gateway:** Razorpay (Escrow flow)  

---

## 📱 App Status
| Module | Status |
|:---------------------|:-------------:|
| Authentication (Email + Google) | ✅ Done |
| Role Selection | ✅ Done |
| Dashboard (Client/Worker) | ✅ Done |
| Job Posting & Proposal | ✅ Done |
| Chat Interface | ✅ Working (basic) |
| Payment Integration | ⚙️ Under Development |

---

## 🧰 Tech Stack

| Layer | Tools / Frameworks |
|:------|:--------------------|
| **Frontend** | Flutter, Dio, Supabase SDK |
| **Backend** | Node.js, Express.js |
| **Database** | Supabase PostgreSQL |
| **ORM** | Prisma |
| **Auth** | Supabase Auth |
| **Realtime** | Socket.io |
| **Payment** | Razorpay (to be integrated) |

---

## 🔐 Environment Variables

The following variables must be configured in a `.env` file inside `/backend`.

```bash
DATABASE_URL=your_supabase_postgres_url
SUPABASE_URL=your_supabase_project_url
RAZORPAY_KEY=your_razorpay_secret_key
JWT_SECRET=your_jwt_secret_key
```

✅ Include a `.env.example` file in the root directory to guide new collaborators.

---

## 📦 Installation & Setup

### 🖥️ **Backend Setup**

```bash
# 1️⃣ Navigate to backend folder
cd backend

# 2️⃣ Install dependencies
npm install

# 3️⃣ Run Prisma migrations
npx prisma migrate dev

# 4️⃣ Start development server
npm run dev
```

> Backend runs on default port `http://localhost:5000`  
> Make sure `.env` file is configured properly.

---

### 📱 **Frontend Setup**

```bash
# 1️⃣ Navigate to client folder
cd client

# 2️⃣ Install Flutter dependencies
flutter pub get

# 3️⃣ Run the app on an emulator or device
flutter run
```

> Make sure the backend server is running before starting the app.  
> Supabase credentials are handled inside the app.

---

## 🧑‍💻 Collaboration Guide

### 💾 Clone the repository
```bash
git clone https://github.com/<your-username>/WorkersHub.git
```

### 🌿 Create a feature branch
```bash
git checkout -b feature/<your-feature-name>
```

### 🧱 Commit changes
```bash
git add .
git commit -m "Added <feature>"
```

### 🚀 Push changes
```bash
git push origin feature/<your-feature-name>
```

### 🔄 Submit Pull Request
1. Open a PR against the `main` branch.  
2. Provide short description and screenshots of your changes.

---

## 📄 API Overview

| Endpoint | Method | Description |
|:----------|:--------|:-------------|
| `/register` | `POST` | Registers a new client or worker |
| `/login` | `POST` | Authenticates user and returns JWT |
| `/user/:id` | `GET` | Fetches profile details |
| `/post/new` | `POST` | Client posts a new job |
| `/chat/send` | `POST` | Sends a chat message between client and worker |

> All routes are JWT-protected except `register` and `login`.  
> Chat module uses Socket.io events for real-time communication.

---

## 💬 Socket.io Chat (Under Development)
Each chat creates a **room** between client and worker.

**Event Flow:**
- `join_room`: When a client selects a worker  
- `send_message`: Emit text/image message  
- `receive_message`: Listen for messages in real-time  
- `disconnect`: Triggered when user exits chat  

> Socket logic is implemented in `/backend/src/socket/socket.js`.

---

## 🎥 Demo
> 🎬 *Coming Soon*  
> Add your deployed link, video demo, or screenshots here.

---

## 👨‍💻 Team – HackCBS 2025

| Name | Role |
|:------|:-------------------------------|
| **Satyam Kumar Jha** | Team Lead, Database Manager & System Architect |
| **Harshit** | Frontend Flutter Developer |
| **Jatin** | Backend Developer |
| **Divyanshu** | Backend Developer |

---

## 📊 Folder Structure

```
WorkersHub/
├── backend/
│   ├── app.js
│   ├── prisma/
│   │   ├── schema.prisma
│   │   └── migrations/
│   └── src/
│       ├── controllers/
│       ├── routes/
│       ├── middleware/
│       └── socket/
│
├── client/
│   ├── lib/
│   │   ├── features/
│   │   ├── core/
│   │   └── models/
│   ├── pubspec.yaml
│   └── android/
│
└── README.md
```

---

## 🧩 Key Highlights
✅ Dual-role system (Client & Worker)  
✅ Real-time job posting & bidding  
✅ Escrow-style payment model (in progress)  
✅ Supabase integration for auth & database  
✅ Modular folder structure for scalability  
✅ Built for HackCBS Hackathon 2025  

---

## 💡 Future Work
*(Not included in MVP but planned for next phase)*  
- Real-time chat enhancements  
- Payment automation via Razorpay  
- Push notifications for job updates  
- Worker rating & verification dashboard  

---

## 🙌 Acknowledgements
- **HackCBS Organizers** for the opportunity  
- **Supabase**, **Flutter**, and **Prisma** communities for amazing documentation  
- **Open-source contributors** for tools and packages used  

---

## 🏁 Conclusion
> *WorkersHub is our step toward digitalizing the unorganized sector and empowering small-scale workers through technology.*  
> Building trust, transparency, and opportunities — one job at a time 💪  

---

**Developed with ❤️ by Team WorkersHub @ HackCBS 2025**