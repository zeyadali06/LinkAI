# LinkAI

This project is a job-matching platform similar to LinkedIn or Wuzzuf, enhanced with an AI-powered voice interview feature. It helps employers assess communication skills through simulated interviews using speech analysis. The app is built with Flutter, and integrates custom AI models for voice-to-text, AI evaluation, and text-to-speech. It aims to improve hiring accuracy and candidate preparation.

# Table of contents 📑

- ### [Main Packages Used =>](#main-packages-used)
- ### [Folder Structure =>](#folder-structure)
- ### [App Link =>](#app-link)
- ### [Video Link =>](#video-link)
- ### [Screen Shots =>](#screen-shots)

## Main Packages Used

- [audioplayers](https://pub.dev/packages/audioplayers) -> For playing audio files in various formats.
- [avatar_glow](https://pub.dev/packages/avatar_glow) -> For glowing avatar animation effects (e.g., recording indicators).
- [cupertino_icons](https://pub.dev/packages/cupertino_icons) -> Provides iOS-style icons.
- [device_info_plus](https://pub.dev/packages/device_info_plus) -> To get device and platform information.
- [file_picker](https://pub.dev/packages/file_picker) -> To pick files from the device's file system.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) -> For Bloc state management.
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) -> For secure key-value storage on the device.
- [flutter_sound](https://pub.dev/packages/flutter_sound) -> To record and play audio with advanced controls.
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) -> To use FontAwesome icons in the app.
- [get_it](https://pub.dev/packages/get_it) -> For dependency injection and service location.
- [go_router](https://pub.dev/packages/go_router) -> For declarative and flexible routing in Flutter apps.
- [google_fonts](https://pub.dev/packages/google_fonts) -> For using custom Google Fonts.
- [http](https://pub.dev/packages/http) -> To make HTTP requests and connect with APIs.
- [image_picker](https://pub.dev/packages/image_picker) -> To pick images from the gallery or camera.
- [injectable](https://pub.dev/packages/injectable) -> For code generation and configuration of dependency injection.
- [lottie](https://pub.dev/packages/lottie) -> To render rich animations using Lottie JSON files.
- [modal_progress_hud_nsn](https://pub.dev/packages/modal_progress_hud_nsn) -> To show a loading spinner modal during async operations.
- [path_provider](https://pub.dev/packages/path_provider) -> To access commonly used directories on the filesystem.
- [permission_handler](https://pub.dev/packages/permission_handler) -> To manage app permissions like microphone or storage.
- [pin_code_fields](https://pub.dev/packages/pin_code_fields) -> For creating customizable PIN code input fields.
- [shared_preferences](https://pub.dev/packages/shared_preferences) -> For storing simple key-value pairs locally.
- [url_launcher](https://pub.dev/packages/url_launcher) -> To launch URLs in the browser or external apps.

# Folder Structure

Here is the folder structure we have been using in this project:

```
lib
├── core
├── features
└── main.dart
```

### Core

This folder contains all services and tools related to the application

```
core
├── enums
├── failures
├── models
├── services
├── utils
└── widgets
```

### Features

This folder containes everything related to the screens of the application and the business logic of the application specificly state management.

```
features
├── authentication: Handles user sign-up, login, and password verification.
├── companies: Displays a list of companies and their job postings, enabling users to browse employers.
├── createJob: Allows companies or admins to create and post new job opportunities with full details.
├── editJob: Provides functionality to edit or update existing job postings.
├── home: Serves as the main dashboard, showing featured jobs, companies, and quick access to other sections.
├── interview: Enables AI-powered voice interview simulations with speech-to-text and feedback generation.
├── jobDetails: Displays detailed information about a selected job, including description, requirements, and apply options.
├── profile: Manages user profile data such as name, email and profile picture and make user able to signout.
├── settings: Allows users to change app theme.
└── splash: Displays an animated splash screen during app startup and handles initial navigation logic.
```

## [App Link](https://drive.google.com/file/d/1ia_EinxEHT-v6dP23is0tNap-sVbiq5u/view?usp=sharing)

## [Video Link](https://drive.google.com/file/d/1vPMDUNs95K4eRZU3EOjuQLZTv7zA1RvO/view?usp=sharing)

## Screen Shots

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/1.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/2.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/3.jpg" width="300">

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/4.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/5.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/6.jpg" width="300">

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/7.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/8.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/9.jpg" width="300">

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/10.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/11.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/12.jpg" width="300">

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/13.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/14.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/15.jpg" width="300">

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/16.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/17.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/18.jpg" width="300">

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/19.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/20.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/21.jpg" width="300">

<img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/21.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/22.jpg" width="300"><img src="https://github.com/zeyadali06/LinkAI/blob/readme/screen_shots/23.jpg" width="300">
