# 🛍️ Shopping App

A simple Flutter e-commerce application built as a portfolio project.

The app fetches products from a REST API, allows users to search for products, add products to favorites and cart, manage quantities, switch between light and dark themes, and complete a simple checkout flow.

## ✨ Features

* 📦 Fetch products from REST API
* 🔍 Search products by title or category
* ❤️ Add and remove favorite products
* 🛒 Add products to cart
* ➕ Increase and decrease product quantity
* 🗑️ Remove products from cart
* 🧹 Clear the entire cart
* 💾 Persist favorites and cart data locally
* 🌙 Light and dark theme
* 📱 Product details screen
* 💳 Simple checkout screen
* ⚠️ Confirmation dialogs for destructive actions
* 🖼️ Image loading and error handling

## 🛠️ Technologies

* Flutter
* Dart
* Dio
* flutter_bloc
* Cubit
* SharedPreferences
* REST API
* DummyJSON

## 🏗️ Architecture

The project uses a simple layered structure:

```text

lib/
├── core/
│   └── confirm_dialog.dart
│     
│
├── models/
│   ├── product_model.dart
│   └── cart_item_model.dart
│
├── services/
│   └── product_api_service.dart
│
├── repositories/
│   └── product_repository.dart
│
├── cubit/
│   ├── product_cubit.dart
│   ├── product_state.dart
│   ├── favorite_cubit.dart
│   ├── cart_cubit.dart
│   └── theme_cubit.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── product_details_screen.dart
│   ├── favorites_screen.dart
│   ├── main_screen.dart
│   ├── cart_screen.dart
│   └── checkout_screen.dart
│
└── widgets/
    ├── product_card.dart
    └── cart_item_card.dart

```

### Main responsibilities

Services

Responsible for communicating with the external API.

Repositories

Responsible for converting API data into application models.

Cubits

Responsible for managing application state such as products, favorites, cart, and theme.

Models

Represent application data such as products and cart items.

Widgets

Reusable UI components.

Core

Contains reusable functionality that is not specific to a particular feature.

## 💾 Local Storage

SharedPreferences is used to persist:

* Favorite product IDs
* Shopping cart data
* Theme preference

This allows favorites, cart items, and theme settings to remain available after restarting the application.

## 🌐 API

Products are fetched from the DummyJSON API.

API:

[DummyJSON](https://dummyjson.com/products)

## 🚀 Getting Started

 1. Clone the repository

```bash
git clone https://github.com/hamdimohammed0/shopping_app.git
```
 2. Navigate to the project

```bash
cd shopping_app
```
 3. Install dependencies

```bash
flutter pub get
```
 4. Run the application

```bash
flutter run
```

## 📱 Screenshots

Screenshots of the application will be added here.

## 📚 What I Learned

Through this project, I practiced:

* Flutter UI development
* State management with Cubit
* Working with REST APIs
* Using Dio for HTTP requests
* Repository pattern
* Local data persistence with SharedPreferences
* Reusable widgets
* Separating UI responsibilities
* Handling loading and error states
* Working with BlocBuilder, context.read, context.watch, and context.select
* Navigation between screens
* Light and dark themes

## 🎯 Project Status

This project is a portfolio and learning project.

The checkout flow is currently a simple local simulation and does not process real payments or store orders on a backend.

## 👨‍💻 Author

Built with Flutter as part of my learning and portfolio projects.
