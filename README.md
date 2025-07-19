# Notes App - Flutter Firebase Integration

## Overview
A Flutter notes application with Firebase authentication and Firestore database integration, implementing clean architecture with proper state management.

## 🏗️ Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                      │
├─────────────────────────────────────────────────────────────┤
│  📱 UI Screens          │  🎯 State Management              │
│  • LoginScreen          │  • AuthCubit/Provider             │
│  • NotesListScreen      │  • NotesCubit/Provider            │
│  • AddNoteDialog        │  • UI State Updates               │
│  • EditNoteDialog       │                                   │
└─────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────┐
│                     BUSINESS LOGIC LAYER                    │
├─────────────────────────────────────────────────────────────┤
│  🔧 Services            │  📋 Models                        │
│  • AuthService          │  • User Model                     │
│  • NotesService         │  • Note Model                     │
│  • ValidationService   │  • AppState Models                │
└─────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────┐
│                        DATA LAYER                           │
├─────────────────────────────────────────────────────────────┤
│  🔥 Firebase Services   │  📊 Repositories                  │
│  • Firebase Auth        │  • AuthRepository                 │
│  • Cloud Firestore     │  • NotesRepository                │
│  • Error Handling      │  • Data Transformation            │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Project Structure

```
lib/
├── main.dart
├── firebase_options.dart
├── models/
│   ├── note.dart
│   └── user.dart
├── services/
│   ├── auth_service.dart
│   ├── notes_service.dart
│   └── validation_service.dart
├── repositories/
│   ├── auth_repository.dart
│   └── notes_repository.dart
├── cubits/ (or providers/)
│   ├── auth_cubit.dart
│   └── notes_cubit.dart
├── screens/
│   ├── login_screen.dart
│   ├── notes_list_screen.dart
│   └── dialogs/
│       ├── add_note_dialog.dart
│       └── edit_note_dialog.dart
├── widgets/
│   ├── note_item.dart
│   ├── custom_button.dart
│   └── loading_indicator.dart
└── utils/
    ├── constants.dart
    └── helpers.dart
```

## 🚀 Build Steps

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.18.0 or higher)
- Android Studio / VS Code
- Firebase CLI
- Git

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Usanas7/notes_app.git
   cd notes_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   ```bash
   # Install Firebase CLI (if not already installed)
   npm install -g firebase-tools
   
   # Login to Firebase
   firebase login
   
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure Firebase for your project
   flutterfire configure
   ```

4. **Environment Setup**
   - Ensure `firebase_options.dart` is generated in your `lib/` folder
   - Verify your Firebase project settings in the Firebase Console
   - Check that Authentication and Firestore are enabled

5. **Run the Application**
   ```bash
   # For Android
   flutter run
   
   # For specific device
   flutter run -d <device_id>
   
   # To see available devices
   flutter devices
   ```

6. **Build for Release**
   ```bash
   # Android APK
   flutter build apk --release
   
   # Android App Bundle
   flutter build appbundle --release
   ```

## 🔍 Dart Analyzer Report

![Dart Analyzer Report](screenshots/dart_analyzer_report.png)

**Status: ✅ Zero Warnings**

To run the analyzer yourself:
```bash
dart analyze
```

## 📊 Git Commit History

This project maintains **10+ incremental commits** with clear, descriptive messages:

```
✅ feat: Initial project setup with Firebase configuration
✅ feat: Add authentication service and login screen
✅ feat: Implement user registration functionality
✅ feat: Add Firestore notes service with CRUD operations
✅ feat: Create notes list screen with empty state
✅ feat: Implement add note dialog and functionality
✅ feat: Add edit note feature with dialog
✅ feat: Implement delete note functionality
✅ feat: Add loading states and error handling
✅ fix: Resolve authentication timeout issues
✅ feat: Add snackbar notifications for user feedback
✅ docs: Update README with comprehensive documentation
```

## 🔐 Security & Configuration

### .gitignore Configuration
The following sensitive files are properly excluded:

```gitignore
# Firebase
/android/app/google-services.json
/ios/Runner/GoogleService-Info.plist
/lib/firebase_options.dart

# Environment variables
.env
.env.local
.env.production

# API Keys
/android/key.properties
/ios/Runner/Info.plist

# Build files
/build/
/android/app/build/
/ios/build/

# IDE files
.vscode/
.idea/
*.iml
```

**Note**: `firebase_options.dart` is included in this repository for educational purposes, but in production, sensitive configuration should be handled through environment variables.

## 🎯 State Management

**Implementation**: [BloC/Cubit | Provider | Riverpod]

### Key Features:
- Clean separation of UI and business logic
- Reactive state updates
- Error handling with user feedback
- Loading states for better UX

## 📱 Features Implemented

### ✅ CRUD Operations
- **Create**: Add new notes with validation
- **Read**: Fetch and display notes from Firestore
- **Update**: Edit existing notes in real-time
- **Delete**: Remove notes with confirmation

### ✅ Authentication
- User registration with email/password
- User login with Firebase Auth
- Session management
- Secure logout functionality

### ✅ UI/UX Features
- Empty state with helpful message
- Loading indicators during operations
- Success/error snackbar notifications
- Responsive design for different screen sizes

## 🔥 Firebase Integration

### Services Used:
- **Firebase Authentication**: Email/password authentication
- **Cloud Firestore**: NoSQL database for notes storage
- **Firebase Security Rules**: Proper data access control

### Data Structure:
```json
{
  "users": {
    "userId": {
      "email": "user@example.com",
      "createdAt": "timestamp"
    }
  },
  "notes": {
    "noteId": {
      "userId": "userId",
      "title": "Note Title",
      "content": "Note content...",
      "createdAt": "timestamp",
      "updatedAt": "timestamp"
    }
  }
}
```

## 📸 Screenshots

### Application Flow
![Login Screen](screenshots/login_screen.png)
![Empty State](screenshots/empty_state.png)
![Notes List](screenshots/notes_list.png)
![Add Note Dialog](screenshots/add_note_dialog.png)
![Edit Note Dialog](screenshots/edit_note_dialog.png)

### Firebase Console
![Firebase Authentication](screenshots/firebase_auth.png)
![Firestore Database](screenshots/firestore_database.png)

## 🎥 Demo Video

[📹 Watch Full Demo Video](link-to-your-demo-video)

**Demo includes:**
- User registration and login
- Empty state display
- Adding notes (with Firestore sync)
- Reading and displaying notes
- Editing notes (with real-time updates)
- Deleting notes (with confirmation)
- Firebase console verification

## 🧪 Testing

### Manual Testing Checklist:
- [ ] User can register with valid email/password
- [ ] User can login with existing credentials
- [ ] Empty state displays correctly for new users
- [ ] Notes can be added and appear in Firestore
- [ ] Notes list displays correctly
- [ ] Notes can be edited and changes persist
- [ ] Notes can be deleted and removed from Firestore
- [ ] Error handling works for network issues
- [ ] Loading states display appropriately

## 🐛 Known Issues & Solutions

### Issue 1: Authentication Timeout
**Problem**: FlutterFire CLI authentication timeout
**Solution**: Manual Firebase CLI login and VPN/proxy check

### Issue 2: Placeholder API Keys
**Problem**: Default firebase_options.dart with placeholder values
**Solution**: Regenerate configuration file with correct project settings

### Issue 3: Package Version Conflicts
**Problem**: Minor dependency version mismatches
**Solution**: Updated pubspec.yaml and ran `flutter pub get`

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  flutter_bloc: ^8.1.3  # or provider: ^6.1.1
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Christelle USANASE**
- GitHub: [@Usanas7](https://github.com/Usanas7)
- Email: [your-email@example.com]
