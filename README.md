# Email Client Application

This is a Flutter-based email client application that enables users to send emails via Gmail, manage email attachments, and view previously sent emails. Built with a Spring Boot backend and PostgreSQL database, this app offers a user-friendly interface and a robust system for managing email communication.

## Table of Contents

- [Features](#features)
- [System Architecture](#system-architecture)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Dependencies](#dependencies)
- [License](#license)

## Features

- **User Registration & Login:** Secure user authentication.
- **Compose & Send Email:** Compose emails, attach files, and send them to specified Gmail IDs.
- **View Sent Emails:** Access records of previously sent emails on the home screen.
- **Error Handling & Notifications:** Notifies users of email delivery status and handles errors gracefully.

## System Architecture

The application is organized in a three-layer architecture:
1. **User Interface Layer (Flutter)**: Manages user interactions.
2. **Application Logic Layer (Spring Boot)**: Handles API requests for sending emails and interacting with the database.
3. **Data Storage Layer (PostgreSQL)**: Stores user information, email details, and attachment paths.

## Technologies Used

- **Frontend:** Flutter
- **Backend:** Spring Boot (Java)
- **Database:** PostgreSQL
- **Email Service:** SMTP integration

## Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Java JDK](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) (for Spring Boot)
- [PostgreSQL](https://www.postgresql.org/download/)

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/email-client-app.git
   cd email-client-app
