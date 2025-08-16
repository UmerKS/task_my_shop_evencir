# Evencir Shop - Flutter E-commerce App

A complete Flutter e-commerce application built for a Flutter Developer test task. This app demonstrates modern Flutter development practices with clean architecture, state management, and API integration.


## APIs Used

- **Products API**: `https://dummyjson.com/products?limit=100`
- **Single Product API**: `https://dummyjson.com/products/{productId}`
- **Category API**: `https://dummyjson.com/products/categories`
- **Products by Category**: `https://dummyjson.com/products/category/{category}`

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── product.dart         # Product data model
├── providers/
│   └── favorites_provider.dart  # Favorites state management
├── screens/
│   ├── splash_screen.dart   # Splash screen
│   ├── home_screen.dart     # Main tab navigation
│   ├── products_screen.dart # Products listing
│   ├── categories_screen.dart # Categories listing
│   ├── products_by_category_screen.dart # Category products
│   ├── product_detail_screen.dart # Product details
│   ├── favorites_screen.dart # Favorites management
│   └── user_screen.dart     # User profile
└── services/
    └── api_service.dart     # API service layer
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.2.1          # API calls
  provider: ^6.1.2      # State management
```
# App Demo APK 
https://drive.google.com/file/d/1nGqyoUAD6jj-c407U77x4Bk-XtD1F1FV/view?usp=sharing
