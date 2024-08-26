# News Flash

## Overview

News Flash is a Flutter application that provides users with the latest news from various sources. It includes features for searching news articles, saving bookmarks, and viewing article details in a web view. The app utilizes modern technologies and APIs to deliver a seamless news experience.

## Features

- **News Search**: Users can search for news articles based on keywords. Results are displayed in a list format with the option to view details.
- **Bookmarks**: Users can save their favorite news articles to a bookmarks list. Bookmarked articles can be managed and removed.
- **News Details**: Users can view detailed content of a selected news article in a web view.
- **Dynamic Language Support**: The app supports multiple languages, allowing users to view news in their preferred language.
- **Persistent Preferences**: User preferences, such as language and bookmarks, are saved and synchronized using Appwrite.

## Technologies Used

- **Flutter**: The primary framework for building the cross-platform mobile application.
- **Dart**: The programming language used for developing the Flutter application.
- **NewsAPI**: Provides the latest news articles and search capabilities.
- **Appwrite**: Backend-as-a-Service platform used for user authentication, data storage, and managing user preferences.
- **Provider**: State management solution for managing app state and dependencies.

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Appwrite Account: [Sign Up](https://appwrite.io)

### Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/DevBekoDev/News-Flash-ALX.git
   cd news_flash

2. **Install Dependencies**
   
   Make sure you have Flutter installed and configured. Run the following command to install the required packages:
   ```bash
   flutter pub get

4. **Configure NewsAPI**
   
   Replace the NEWS_API_KEY in your constants.dart file with your NewsAPI key.
   ```bash
   const String NEWS_API_KEY = 'your_news_api_key';

6. **Set Up Appwrite**
   - Create an Appwrite project and configure your database and collections.
   - Replace APPWRITE_DATABASE_ID and COLLECTION_BOOKMARKS_ID in your code with your Appwrite database and collection IDs.
  
7. **Run the App**
   
   You can run the app on an emulator or physical device:
   ```bash
   flutter run

## Usage
  - Home Screen: Displays the latest news headlines.
  - Search Screen: Allows users to search for specific news articles.
  - Bookmarks Screen: View and manage bookmarked articles.
  - News Details Screen: View detailed content of an article in a web view. Toggle the bookmark status from this screen.

## License
  - This project is licensed under the MIT License. See the [License](https://github.com/DevBekoDev/News-Flash-ALX/blob/production/LICENSE) file for details.

## Contact
  - For any inquiries or feedback, please reach out to:
    * Email: abubakr.ezalden.nasir@gmail.com
    * Github: [Abubakr Nasir](https://github.com/DevBekoDev)
   
## Portfolio Project
   - This project is a portfolio project for ALX Software Engineering program and serves as my graduation project.
