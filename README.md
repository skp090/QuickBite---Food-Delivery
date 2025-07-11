# offline_image_upload

A Flutter project demonstrating offline image upload with automatic retry when internet is restored.

## Features
- Pick images from gallery
- Images are saved locally if offline
- Automatic upload when internet is back
- Upload status: Pending, Uploading, Success, Failed
- Retry option for failed uploads

## Code Structure
- `lib/screens/home_screen.dart`: Main UI and state logic
- `lib/models/image_model.dart`: Image model (ensure it has fromJson/toJson)
- Upload logic and state are separated for clarity

## How to Run
1. Ensure Flutter is installed ([Flutter install guide](https://docs.flutter.dev/get-started/install))
2. Run `flutter pub get` in the project directory
3. Run the app on an emulator or device:
   ```
   flutter run
   ```

## Approach
- Uses SharedPreferences for local persistence
- Uses connectivity_plus to detect internet changes
- Uses http for upload (replace API with your own for production)
- Clean code practices: comments, constants, and separation of UI/state

---
For more, see the Flutter [documentation](https://docs.flutter.dev/).
