Email Client Application
This is a Flutter-based email client application that enables users to send emails via Gmail, manage email attachments, and view previously sent emails. Built with a Spring Boot backend and PostgreSQL database, this app offers a user-friendly interface and a robust system for managing email communication.

Table of Contents
Features
System Architecture
Technologies Used
Installation
Usage
API Endpoints
Dependencies
License
Features
User Registration & Login: Secure user authentication.
Compose & Send Email: Compose emails, attach files, and send them to specified Gmail IDs.
View Sent Emails: Access records of previously sent emails on the home screen.
Error Handling & Notifications: Notifies users of email delivery status and handles errors gracefully.
System Architecture
The application is organized in a three-layer architecture:

User Interface Layer (Flutter): Manages user interactions.
Application Logic Layer (Spring Boot): Handles API requests for sending emails and interacting with the database.
Data Storage Layer (PostgreSQL): Stores user information, email details, and attachment paths.
Technologies Used
Frontend: Flutter
Backend: Spring Boot (Java)
Database: PostgreSQL
Email Service: SMTP integration
Installation
Prerequisites
Flutter SDK
Java JDK (for Spring Boot)
PostgreSQL
Steps
Clone the repository:

bash
Copy code
git clone 
cd email-client-app
Set up the PostgreSQL database:

Create a new database named email_client_db.
Update the database credentials in application.properties file in the Spring Boot backend.
Start the backend server:

bash
Copy code
cd backend
./mvnw spring-boot:run
Run the Flutter app:

bash
Copy code
cd flutter_app
flutter pub get
flutter run
Usage
Register/Login: Create an account or log in with your existing credentials.
Compose Email: Fill in the recipient’s Gmail ID, subject, and message. Attach files if needed and send.
View Sent Emails: Access your home screen to view the list of all previously sent emails.
API Endpoints
The backend provides the following REST API endpoints:

POST /api/auth/register: User registration
POST /api/auth/login: User login
POST /api/email/send: Send an email
GET /api/email/sent: Retrieve previously sent emails
Dependencies
Flutter
yaml
Copy code
dependencies:
  flutter:
    sdk: flutter
  http: latest
  provider: latest
  shared_preferences: latest
  file_picker: latest
  flutter_email_sender: latest
  path_provider: latest
  mailer: latest
  intl: latest

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
Spring Boot
Spring Boot Starter Web
Spring Boot Starter Data JPA
PostgreSQL Driver
License

