# CC Essentials Package

This package contains a set of utility components, including reusable classes and widgets for Flutter applications. The utilities provided include API client handling, advanced navbar creation, login and registration workflows, OTP verification, and generic controller implementations.

## Table of Contents

- [Getting Started](#getting-started)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Navbar Implementation](#navbar-implementation)
  - [Login Flow](#login-flow)
  - [OTP Verification](#otp-verification)
  - [Register Workflow](#register-workflow)
  - [Generic Controllers](#generic-controllers)
- [Examples](#examples)
- [Contributions](#contributions)

---

## Getting Started

This package is designed to simplify common Flutter app development tasks. Whether you're managing API requests, building custom navigation bars, or implementing robust workflows, this package has you covered.

---

## Features

1. **Navbar Implementation**: Customizable navigation bar with support for icons and assets.
2. **Login Flow**: Prebuilt controllers for login processes.
3. **OTP Verification**: Seamless OTP verification controllers.
4. **Register Workflow**: Tools to handle user registration and region fetching.
5. **Generic Controllers**: Utility controllers for common state management tasks.

---

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  cc_essentials:
    git:
      url: https://github.com/DevMaan707/cc_essentials.git
```

Run the following command to fetch the package:

```bash
flutter pub get
```

---

## Usage
### Custom Theme Implementation
How to Implement in the Parent Project
 
Step 1: Initialize the Theme
Call `CustomTheme.initialize()` in the `main()` function before running the app to set the necessary colors.
```dart
 void main() {
   CustomTheme.initialize(primary: Colors.teal, accent: Colors.orange);
   runApp(MyApp());
 }
 ```

Step 2: Set the Theme
Wrap the `MaterialApp` widget with the theme provided by `CustomTheme`.
```dart
class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
      theme: CustomTheme.lightTheme(),
       darkTheme: CustomTheme.darkTheme(),
       themeMode: ThemeMode.system, // Use system theme mode
      home: MyHomePage(),
    );
  }
}
 ```
 
Step 3: Use Custom Components
Utilize the Pinput field and other customizable widgets provided by `CustomTheme`.
 ```dart
 class MyHomePage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Theme Example')),
      body: Center(
         child: CustomTheme.buildPinput(
          length: 6,
         onChanged: (value) => print('Entered: $value'),
        ),
      ),
     );
  }
 }
 ```

### Navbar Implementation

To implement the navbar in your project:

1. Import the necessary modules:

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_utility_package/navbar.dart';
import 'package:flutter_utility_package/navbar_controller.dart';
```

2. Initialize the navbar controller and configure icons and colors:

```dart
final navbarController = Get.put(NavbarController());

navbarController.initializeNavbar(
  iconsList: [Icons.home, Icons.search, Icons.settings],
  colorsList: [Colors.blue, Colors.green, Colors.orange],
);
```

3. Add the navbar to your application:

```dart
MaterialApp(
  home: Scaffold(
    bottomNavigationBar: Navbar(),
  ),
);
```

### Login Flow

Use the `LoginController` to manage user login:

```dart
import 'package:get/get.dart';
import 'package:flutter_utility_package/login_controller.dart';
import 'package:flutter_utility_package/auth_service.dart';

final authService = AuthService(ApiClient('https://api.example.com'));
final loginController = LoginController(
  authService: authService,
  authModelMapper: (data) => YourAuthModel.fromJson(data),
);

bool isLoggedIn = await loginController.login('1234567890');
if (isLoggedIn) {
  print('Login successful');
} else {
  print('Login failed');
}
```

### OTP Verification

To implement OTP verification:

1. Set up the `OTPController`:

```dart
import 'package:flutter_utility_package/otp_controller.dart';

final otpController = OTPController(
  authService: authService,
);
```

2. Send OTP and verify:

```dart
await otpController.sendOTP('1234567890');
bool isVerified = await otpController.verifyOTP('123456', '1234567890');
if (isVerified) {
  print('OTP verified');
}
```

### Register Workflow

Handle registration and fetch regions:

```dart
import 'package:flutter_utility_package/register_controller.dart';

final registerController = RegisterController(
  authService: authService,
  regionMapper: (data) => RegionModel.fromJson(data),
);

registerController.fetchRegions();
print(registerController.regions);
```

### Generic Controllers
```dart
// Example Usage
final userController = GenericController<UserModel>(
  fetchData: () => dio.get('https://api.example.com/user'),
  modelMapper: (data) => UserModel.fromJson(data),
);
await userController.fetchItems();
print(userController.data.value);
```

# Generic Service and Controller Implementation

This guide explains how to implement and use a `GenericService` and `GenericController` in your Flutter project. These components streamline data fetching and state management, promoting reusability and maintainability.

---

## Step 1: Set Up the Service in the Parent Project

Initialize the `GenericService` with your `ApiClient` in the parent project's dependency injection or initialization logic.

```dart
final apiClient = ApiClient('https://api.example.com');
final genericService = GenericService(apiClient);
```

---

## Step 2: Define the Model and Mapper Function

### Define the Model

Create a model class that represents the data structure of your API response:

```dart
class ExampleModel {
  final int id;
  final String name;

  ExampleModel({required this.id, required this.name});

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
```

### Create the Mapper Function

Define a function to map the raw JSON data to the model:

```dart
ExampleModel exampleModelMapper(Map<String, dynamic> data) {
  return ExampleModel.fromJson(data);
}
```

---

## Step 3: Initialize the GenericController

Set up the `GenericController` by passing the `fetchData` method of `GenericService` and the model mapper function:

```dart
final exampleController = GenericController<ExampleModel>(
  fetchData: () => genericService.getData('/example-endpoint', headers: {
    'Authorization': 'Bearer token',
  }),
  modelMapper: exampleModelMapper,
);
```

---

## Step 4: Use the Controller in the UI

Utilize the `GenericController` to manage state and display data in your widgets.

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamplePage extends StatelessWidget {
  final GenericController<ExampleModel> controller;

  ExamplePage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Page')),
      body: Column(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            } else if (controller.errorMessage.value.isNotEmpty) {
              return Text(
                controller.errorMessage.value,
                style: TextStyle(color: Colors.red),
              );
            } else if (controller.data.value != null) {
              final data = controller.data.value!;
              return Text('ID: ${data.id}, Name: ${data.name}');
            } else {
              return const Text('No data available.');
            }
          }),
          ElevatedButton(
            onPressed: controller.fetchItems,
            child: const Text('Fetch Data'),
          ),
        ],
      ),
    );
  }
}
```

---

## Step 5: Add Dependency Injection

Integrate `GenericService` and `GenericController` using a dependency injection library like `GetX`:

### Bind the Service and Controller

```dart
Get.put(GenericService(ApiClient('https://api.example.com')));
Get.put(GenericController<ExampleModel>(
  fetchData: () => Get.find<GenericService>().getData('/example-endpoint'),
  modelMapper: exampleModelMapper,
));
```

### Retrieve the Controller in Widgets

```dart
final controller = Get.find<GenericController<ExampleModel>>();
```

---

## Complete Workflow

1. **Service Layer:** The `GenericService` handles API interactions.
2. **Controller Layer:** The `GenericController` manages response data, maps it to models, and controls UI state.
3. **UI Layer:** Observes the `GenericController` to reactively display data, handle errors, and provide user interactivity.

---


### Notification Example

```dart
AdvancedBubbleNotification.show(
  context,
  "Operation successful!",
  type: MessageType.success,
);
```

---

**Author**

- [DevMaan707](https://github.com/DevMaan707)

---
