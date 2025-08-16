# My Shop - Flutter E-commerce App

A complete Flutter e-commerce application built for a Flutter Developer test task. This app demonstrates modern Flutter development practices with clean architecture, state management, and API integration.

## Features

### 🚀 Core Functionality
- **Splash Screen**: Beautiful animated splash screen with app branding
- **4-Tab Navigation**: Products, Categories, Favorites, and User profile
- **Search Functionality**: Real-time search across all screens
- **Dynamic Data Loading**: All data fetched from external APIs

### 📱 Screens

#### 1. Products Screen
- Displays all products from the Products API
- Grid layout with product cards
- Product information: title, category, price, rating
- Add/remove from favorites functionality
- Search and filter products
- Pull-to-refresh functionality

#### 2. Categories Screen
- Shows all product categories from Category API
- Beautiful category cards with relevant icons
- Search categories functionality
- Navigation to products by category

#### 3. Products by Category Screen
- Displays products filtered by selected category
- Same product card layout as main products screen
- Search within category
- Add/remove from favorites

#### 4. Product Detail Screen
- Comprehensive product information
- Image gallery with multiple product images
- Product details: price, rating, stock, description
- Add/remove from favorites
- Beautiful UI with collapsible app bar

#### 5. Favorites Screen
- Lists all favorite products
- Search within favorites
- Remove products from favorites
- Empty state handling

#### 6. User Screen
- User profile information (hardcoded as per requirements)
- Menu items for various user actions
- Clean and organized layout

### 🔧 Technical Features
- **State Management**: Provider pattern for favorites management
- **API Integration**: RESTful API calls to dummyjson.com
- **Responsive Design**: Works on various screen sizes
- **Modern UI**: Material Design 3 with custom theming
- **Error Handling**: Comprehensive error handling and retry mechanisms
- **Loading States**: Proper loading indicators throughout the app

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
  transparent_image: ^2.0.1
```

## Getting Started

### Prerequisites
- Flutter SDK (3.7.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd task_my_shop_evencir
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## State Management

The app uses the **Provider** pattern for state management, specifically for:
- **FavoritesProvider**: Manages favorite products state
- **Features**:
  - Add/remove products from favorites
  - Check if product is in favorites
  - Get list of favorite products
  - Persistent state during app session

## Search Functionality

- **Real-time search** across all screens
- **Multi-field search**: Title, category, brand
- **Instant filtering** without API calls
- **Search persistence** within each screen

## UI/UX Features

- **Material Design 3** implementation
- **Custom color scheme** with blue as primary color
- **Responsive layouts** for different screen sizes
- **Smooth animations** and transitions
- **Loading states** and error handling
- **Pull-to-refresh** functionality
- **Empty state handling** for better user experience

## Error Handling

- **Network error handling** with retry buttons
- **Loading states** for better user feedback
- **Graceful fallbacks** when data is unavailable
- **User-friendly error messages**

## Performance Optimizations

- **Efficient list rendering** with ListView.builder and GridView.builder
- **Image caching** for better performance
- **Lazy loading** of data
- **Optimized state updates** with Provider

## Testing

The app includes basic widget tests and is ready for:
- Unit testing
- Widget testing
- Integration testing

## Future Enhancements

- Local storage for favorites persistence
- User authentication
- Shopping cart functionality
- Payment integration
- Push notifications
- Offline mode support
- Multi-language support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is created for a Flutter Developer test task.

## Contact

For any questions or support, please contact the development team.

---

**Note**: This app is built according to the specific requirements provided in the test task. All functionality is implemented as specified, including the hardcoded user screen and no persistent storage for favorites as per requirements.
