# Exercise Tracker Application

A full-stack exercise tracking application with a mobile user interface and a web-based health coach management platform.

## 📋 Project Overview

This project consists of three main components:

1. **Backend** - Spring Boot REST API (Java)
2. **UserPortal** - Ionic Angular mobile app (for end users)
3. **Web-Portal** - Angular web app (for health coaches)

## 🛠️ Tech Stack

### Backend
- Java 17+
- Spring Boot 3.5.7
- Spring Data JPA
- MySQL 8.0+
- Maven

### UserPortal (Mobile)
- Angular 20
- Ionic Framework 8
- Capacitor 7
- Chart.js 4.5.1
- TypeScript 5.8

### Web-Portal (Coach Dashboard)
- Angular 20
- Chart.js 4.5.1
- TypeScript 5.9

## 📦 Prerequisites

Before you begin, ensure you have the following installed on your system:

### Required Software

1. **Java Development Kit (JDK) 17 or higher**
   - Check version: `java -version`
   - Download: https://adoptium.net/

2. **Maven 3.6+**
   - Check version: `mvn -version`
   - Download: https://maven.apache.org/download.cgi
   - macOS install: `brew install maven`

3. **Node.js 18+ and npm**
   - Check version: `node -v` and `npm -v`
   - Download: https://nodejs.org/
   - Recommended: Use LTS version

4. **MySQL 8.0+**
   - Check version: `mysql --version`
   - Download: https://dev.mysql.com/downloads/mysql/
   - macOS install: `brew install mysql`

5. **Ionic CLI** (for UserPortal)
   - Global install: `npm install -g @ionic/cli`
   - Check version: `ionic -v`

### Optional Software

- **Git** - Version control
- **Postman** - API testing

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/exercise-tracker.git
cd exercise-tracker
```

### 2. Database Setup

#### Start MySQL Service

```bash
# macOS (Homebrew)
brew services start mysql

# Or start directly
mysql.server start
```

#### Setup Database & Import Test Data

**One-command setup** (creates database + imports test data):

```bash
./import-test-data.sh
```

This will:
- Create the `exercise_tracker` database
- Import 13 users and 127 exercise records
- All users have password: `123`

**Test Login**:
- Username: `allen` (or any user: john_doe, sarah_smith, etc.)
- Password: `123`

**Manual setup** (if you prefer):
```bash
mysql -u root -p
CREATE DATABASE exercise_tracker CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit;
mysql -u root -p exercise_tracker < backend/src/main/resources/db/complete-test-data.sql
```

#### Configure Database Connection

Edit `backend/src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://127.0.0.1:3306/exercise_tracker?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=utf8
spring.datasource.username=root
spring.datasource.password=YOUR_MYSQL_PASSWORD
```

**Note**: Replace `YOUR_MYSQL_PASSWORD` with your actual MySQL password.

### 3. Start All Services

#### Option A: One-Command Start (Recommended) 🚀

Start everything with one command and auto-open browsers:

```bash
./start-all.sh
```

This will:
- Start Backend (Spring Boot) on port 8080
- Start UserPortal (Ionic) on port 8100
- Start Web-Portal (Angular) on port 4201
- Auto-open browser windows
- Show all logs in `logs/` directory

**To stop**: Press `Ctrl+C`

#### Option B: Manual Start (3 separate terminals)

### 3a. Start Backend

```bash
# Navigate to backend directory
cd backend

# Run with Maven wrapper (recommended)
./mvnw spring-boot:run

# Or build and run JAR
./mvnw clean package
java -jar target/backend-0.0.1-SNAPSHOT.jar
```

Backend will start at **http://localhost:8080**

#### Verify Backend is Running

Visit: http://localhost:8080/api/users/1

If you see JSON data or a 404 error (service is running, data doesn't exist yet), the backend is working correctly.

### 4. Start UserPortal (Mobile App)

**Open a new terminal window**

```bash
# Navigate to userPortal directory
cd userPortal

# Install dependencies
npm install

# Start development server
ionic serve --port 8100

# Or use npm
npm start
```

UserPortal will start at **http://localhost:8100**

Browser will open automatically. If not, manually visit http://localhost:8100

### 5. Start Web-Portal (Coach Dashboard)

**Open a new terminal window**

```bash
# Navigate to web-portal directory
cd web-portal

# Install dependencies
npm install

# Start development server (port 4201 to avoid conflicts)
ng serve --port 4201

# Or use npm
npm start -- --port 4201
```

Web-Portal will start at **http://localhost:4201**

## 🖥️ Access the Application

| Service | URL | Description |
|---------|-----|-------------|
| Backend API | http://localhost:8080 | REST API |
| UserPortal | http://localhost:8100 | User mobile app (Ionic) |
| Web-Portal | http://localhost:4201 | Coach dashboard (Angular) |

## 📱 How to Use

### UserPortal (End Users)

1. **Register/Login**
   - Open http://localhost:8100
   - Register a new user or login with existing account

2. **Add Exercise Record (Tab1)**
   - Select timezone (top right corner)
   - Fill in exercise type, duration, date/time, location
   - Click "Add Exercise" to save
   - Record appears immediately in "Today's Records" list

3. **View History (Tab2)**
   - View last 7 days exercise chart
   - Browse all historical exercise records

### Web-Portal (Health Coaches)

1. **Register/Login**
   - Open http://localhost:4201
   - Register as a health coach or login

2. **User Monitoring**
   - Dashboard shows all users
   - ⚠️ indicator shows users inactive for >2 days
   - Click user to view detailed exercise data

3. **User Details**
   - View user's last 7 days exercise trend chart
   - Browse user's complete exercise history

## 🔧 Troubleshooting

### 1. Backend Fails to Start

**Error: `Communications link failure`**

- Check if MySQL is running: `mysql.server status`
- Check if database exists: `SHOW DATABASES;`
- Verify username/password in `application.properties`

**Error: `mvnw: command not found`**

- Ensure you're in the `backend` directory
- Add execute permission: `chmod +x mvnw`
- Or use system Maven: `mvn spring-boot:run` (requires Maven installed)

### 2. UserPortal or Web-Portal Fails to Start

**Error: `Cannot find module`**

```bash
# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

**Port Already in Use**

```bash
# Find process using port
lsof -ti:8100  # UserPortal
lsof -ti:4201  # Web-Portal

# Kill process
kill -9 <PID>
```

### 3. Database Password Issues

If MySQL has no password or password is not `root`:

1. Edit `backend/src/main/resources/application.properties`
2. Change `spring.datasource.password` to your actual password
3. If no password, set to empty: `spring.datasource.password=`

### 4. CORS Errors

If frontend cannot access backend API, check:

1. Backend is running at http://localhost:8080
2. Frontend is running on correct port (8100 or 4201)
3. CORS configuration in `WebConfig.java` includes your frontend URL

## 📁 Project Structure

```
exercise-tracker/
├── backend/                    # Spring Boot backend
│   ├── src/
│   │   └── main/
│   │       ├── java/com/allen/backend/
│   │       │   ├── config/    # Configuration (CORS, password encryption)
│   │       │   ├── controller/# REST API controllers
│   │       │   ├── dto/       # Data Transfer Objects
│   │       │   ├── entity/    # JPA entities
│   │       │   ├── repo/      # JPA repositories
│   │       │   └── service/   # Business logic layer
│   │       └── resources/
│   │           ├── application.properties
│   │           └── db/migration/  # Database migration scripts
│   └── pom.xml                # Maven dependencies
│
├── userPortal/                # Ionic Angular user app
│   ├── src/
│   │   └── app/
│   │       ├── auth/          # Login/register page
│   │       ├── tab1/          # Add exercise page
│   │       ├── tab2/          # Exercise history page
│   │       ├── tabs/          # Tab container
│   │       └── services/      # Services (timezone management)
│   ├── package.json
│   └── ionic.config.json
│
└── web-portal/                # Angular coach dashboard
    ├── src/
    │   └── app/
    │       ├── login/         # Coach login page
    │       ├── dashboard/     # User monitoring dashboard
    │       ├── user-list/     # User details page
    │       └── services/      # Services (auth, data)
    └── package.json
```

## 🗄️ Database Schema

### Tables

- **users** - End users (username, password_hash, uuid)
- **health_coaches** - Health coaches (username, password_hash)
- **exercises** - Exercise records (user_id, type, duration_minutes, location, occurred_at, timezone)

### Supported Exercise Types

- RUN (Running)
- WALK (Walking)
- CYCLE (Cycling)
- SWIM (Swimming)
- GYM (Gym workout)
- OTHER (Other activities)

## 🌍 Timezone Support

The application supports 20+ global timezones including:

- Americas: New York, Chicago, Denver, Los Angeles
- Europe: London, Paris, Berlin, Rome
- Asia: Tokyo, Shanghai, Hong Kong, Singapore, Dubai
- Australia: Sydney, Melbourne

Each exercise record saves the timezone it was created in, ensuring accurate time display.

## 📊 Core Features

### UserPortal

- ✅ User registration/login
- ✅ Add exercise records (with timezone)
- ✅ Offline data storage (LocalStorage)
- ✅ Auto-sync to backend (daily at 23:59 or on next day launch)
- ✅ Edit/delete today's records
- ✅ View exercise history
- ✅ Last 7 days chart visualization

### Web-Portal

- ✅ Coach registration/login
- ✅ User monitoring dashboard
- ✅ User activity alerts (inactive >2 days)
- ✅ User exercise details
- ✅ Last 7 days trend chart
- ✅ Complete exercise record list

## 🔒 Security

- BCrypt password hashing
- CORS cross-origin configuration
- Input validation (frontend + backend)
- SQL injection prevention (JPA/Hibernate)

## 📝 Development Notes

1. **Don't commit sensitive information**
   - Database passwords in `application.properties`
   - Consider using environment variables or config templates

2. **Database auto-update**
   - `spring.jpa.hibernate.ddl-auto=update` automatically creates/updates tables
   - For production, change to `validate` or use Flyway migrations

3. **Port Configuration**
   - Backend: 8080
   - UserPortal: 8100
   - Web-Portal: 4201

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

MIT License

## 📞 Contact

For questions, please contact via GitHub Issues.

---

**Good luck with your interview!** 🎉
