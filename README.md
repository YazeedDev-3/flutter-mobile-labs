# Flutter Mobile Labs

A collection of Flutter mobile development lab exercises built as part of a university mobile development course.

---

## Labs Overview

### Lab 3 — Registration Form

A simple registration form with username/password fields, a "agree to terms" checkbox, and a gradient card-based UI. The form only submits when the checkbox is checked.

### Lab 4 — My Store (Shopping App)

A multi-page shopping app with a bottom navigation bar (Home, Products, Cart). Features a product list with card UI, product detail pages, and a welcome banner. Built with an indigo color theme.

### Lab 5 — Landmarks of Al-Madinah Al-Munawwarah

A Flutter app for browsing and adding tourist landmarks in Al-Madinah. Connects directly to a MySQL database and supports Arabic RTL interface. Displays landmarks with images, categories, and descriptions.

### Labs 6 & 7 — My Pizza Shop

A pizza ordering app where users browse a menu, adjust item quantities, and place orders saved to a MySQL database. Tracks orders and purchases across two database tables.

### Labs 8 & 9 — Bookstore App

A Flutter app connected to an **ASP.NET Core Web API** for managing a book list (add & view). Uses SQL Server LocalDB as the backend database.

---

## Tech Stack

| Technology           | Usage                      |
| -------------------- | -------------------------- |
| Flutter 3.x          | UI framework               |
| Dart 3.x             | Primary language           |
| MySQL                | Database for Labs 5, 6 & 7 |
| ASP.NET Core Web API | Backend for Labs 8 & 9     |
| SQL Server LocalDB   | Database for Labs 8 & 9    |

**Languages breakdown:** Dart 52.6% · C++ 26.9% · Swift 9.3% · HTML 6.2% · C# 4.4% · Kotlin 0.6%

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with Flutter extension
- MySQL Server _(for Labs 5, 6 & 7)_
- [.NET 8 SDK](https://dotnet.microsoft.com/download) + Visual Studio _(for Labs 8 & 9)_

### Run any lab

```bash
cd lab_X
flutter pub get
flutter run
```

> For Labs 5, 6 & 7: Make sure your MySQL server is running before launching the app.  
> For Labs 8 & 9: Start the ASP.NET Core API first, then run the Flutter app.

---
