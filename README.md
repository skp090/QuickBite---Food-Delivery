<h1 align="center">🍔 QuickBite</h1>
<p align="center">
  A fast and modern food delivery app built with Flutter and powered by Supabase.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-v3.0+-blue?logo=flutter" />
  <img src="https://img.shields.io/badge/Supabase-Realtime-green?logo=supabase" />
  <img src="https://img.shields.io/github/license/skp090/QuickBite---Food-Delivery" />
</p>

---

## 📱 Screenshots

> _Add screenshots here to showcase the app UI_

| Home Page | Categories | Product Detail |
|----------|------------|----------------|
| *Coming soon* | *Coming soon* | *Coming soon* |

---

## 🚀 Features

- 🔐 **Supabase Authentication** for secure login/signup
- 🗂 **Dynamic Categories & Products** from Supabase
- 📱 **Flutter-based Modern UI**
- 🔄 **Real-time data updates**
- ⚙️ **.env configuration** to keep keys safe
- 🔧 Ready to integrate cart, payment, and tracking modules

---

## 🧰 Tech Stack

| Technology | Purpose |
|------------|---------|
| Flutter | Cross-platform UI |
| Dart | Programming language |
| Supabase | Backend (auth + database) |
| flutter_dotenv | Secure env key handling |
| GitHub | Code hosting |

---

## 🛠️ Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/skp090/QuickBite---Food-Delivery.git
   cd QuickBite---Food-Delivery
Install dependencies

bash
Copy
Edit
flutter pub get
Set up environment variables
Create a .env file in the root:

ini
Copy
Edit
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
Run the app

bash
Copy
Edit
flutter run
📦 Project Structure
pgsql
Copy
Edit
lib/
├── Pages/            → Screens (Login, Home, etc.)
├── Models/           → Data models (e.g., CategoryModel)
├── Services/         → API or Supabase interactions
├── Widgets/          → Reusable UI components
└── main.dart         → Entry point
🔒 Security
This project uses environment variables and .gitignore to:

Keep Supabase keys private

Avoid exposing sensitive files on GitHub

✍️ Author
Sandeep Prajapat
🧑 GitHub: @skp090

📄 License
Licensed under the MIT License

⭐ Support
If you like this project, consider giving it a ⭐ on GitHub.
It helps others find it, and keeps me motivated!
