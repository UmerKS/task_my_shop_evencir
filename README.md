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

# APP UI 

  <img src="https://github.com/user-attachments/assets/715f11c1-d5dc-48e2-b18c-0ffc9561802c" width="30%">
  <img src="https://github.com/user-attachments/assets/c3df0880-95f6-4daa-b17b-338be6cfe062" width="30%">
  <img src="https://github.com/user-attachments/assets/1501b701-1a3b-45e0-9cbe-b51d5ba11097" width="30%">
  <img src="https://github.com/user-attachments/assets/1fd51a94-3538-4424-b93b-88d295ff76a0" width="30%">
  <img src="https://github.com/user-attachments/assets/d972b0a0-d682-4571-ab23-7d8c85cd17b7" width="30%">
  <img src="https://github.com/user-attachments/assets/50587260-bcde-4e20-b829-20c8a38226e6" width="30%">
  <img src="https://github.com/user-attachments/assets/f2bdd9ed-1119-4150-a5dd-182249226f42" width="30%">
  <img src="https://github.com/user-attachments/assets/4969599a-714d-47fd-8945-f2374aaa07be" width="30%">


















