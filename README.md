# Quiz App

A Flutter-based quiz application.

## Project Overview

This project is a quiz application built using Flutter and GetX for state management. It fetches quiz data from a repository and displays questions to the user.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- A code editor like [Visual Studio Code](https://code.visualstudio.com/)

### Setup Instructions

1. **Clone the repository:**

    ```sh
    git clone <repository-url>
    cd quiz
    ```

2. **Install dependencies:**

    ```sh
    flutter pub get
    ```

3. **Run the application:**

    ```sh
    flutter run
    ```

### Project Structure

- [lib](http://_vscodecontentref_/1): Contains the main source code for the application.
  - `Models/`: Contains data models like `QuestionModel`.
  - `ViewModel/`: Contains the repository and controllers.
  - `Views/`: Contains the UI components.
- [test](http://_vscodecontentref_/2): Contains unit and widget tests.

### Key Files

- [QuizController.dart](http://_vscodecontentref_/3): Contains the `QuizController` class which manages the state of the quiz.
- [QuizRepositry.dart](http://_vscodecontentref_/4): Contains the `QuizRepository` class which fetches quiz data.

## Screenshots and Videos

For screenshots and videos showing the code in action, please refer to the following link:

[Demo Video](https://drive.google.com/file/d/1zBZeholblLbSYrr60xhJHLc1uEVLovcT/view?usp=sharing)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
