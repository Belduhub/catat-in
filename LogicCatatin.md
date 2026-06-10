Act as an expert Full-Stack Flutter Developer. Your task is to implement the complete functional logic, state management, and SQLite local database backend for the "catat.in" Android application, strictly adhering to the layout design and UI specifications provided in the attached Markdown (.md) file.

Please read the .md file to understand the pages, widget tree, and flat design constraints before generating the code.

Core Technical Specifications:

1. Local Database: Use 'sqflite' and 'path' packages for standard relational SQLite database management.
2. Session Management: Use 'shared_preferences' to persist the user login session state locally (so the user doesn't have to log in again upon app restart, matching standard academic local storage logic).
3. State Management: Use standard StatefulWidget with setState() or simple architectural separation (DatabaseHelper -> Models -> UI Screens) to trigger reactive UI updates.

Database Schema Requirements:
Create a 'DatabaseHelper' singleton class that handles database initialization and the following tables:

- 'users' table: id (INTEGER PRIMARY KEY), username (TEXT UNIQUE), password (TEXT).
- 'notes' table: id (INTEGER PRIMARY KEY), title (TEXT), content (TEXT), category (TEXT), created_at (TEXT), user_id (INTEGER, Foreign Key referencing users.id).

Please implement the following business logic features perfectly tied into the UI from the .md file:

1. LOGIN & AUTENTIKASI LOGIC

- On first install, automatically seed a default dummy user in the database (e.g., username: "admin", password: "password123") if no users exist, to make UKPL testing easy.
- Query the 'users' table to validate credentials.
- If authentication succeeds, save the session to SharedPreferences, set the state, and use Navigator.pushReplacement() to go to the Dashboard.
- If it fails, trigger the validation error state mentioned in the .md (change TextField border colors to solid red and show a SnackBar).

2. CRUD CATATAN, KATEGORI, & SORTING LOGIC

- Ensure all CRUD operations are tied specifically to the currently logged-in user's 'user_id' (Data Isolation).
- CREATE: Save a new note into the SQLite 'notes' table with Title, Content, Category (e.g., Kuliah, Kerja, Pribadi), and current Timestamp.
- READ & FILTER: Fetch notes from SQLite. Implement the horizontal category Chips filter logic; clicking a category should filter the ListView instantly via setState() or SQL query filtering.
- SORTING: Implement the AppBar sorting toggle button action. Allow sorting the list dynamically by:
  - A-Z (Alphabetical Title Ascending)
  - Z-A (Alphabetical Title Descending)
  - Latest Date (created_at Descending)
- UPDATE & DELETE: Implement editing existing note fields and a permanent delete function through database queries, immediately refreshing the UI.

3. CRUD PROFILE LOGIC

- Load the current logged-in user's details into the Profile Tab text fields.
- "Simpan Perubahan" Button: Execute an UPDATE SQL statement on the 'users' table for the active user_id to modify username or password. Show a success SnackBar.

4. LOGOUT LOGIC

- "Logout" Button: Clear the login state from SharedPreferences and use Navigator.pushAndRemoveUntil() to clear the navigation stack and safely redirect back to the Login Page.

5. ABOUT US (TENTANG KAMI) STATIC ROUTE

- Map the data statically for the 2 creators:
  - Name 1: "Danang Adiwibowo"
  - Name 2: "Gorga Doli Liberto Napitupulu"
- Use standard assets or NetworkImage placeholders for their photos as laid out in the .md widget description.

Ensure code is clean, fully commented, handling async/await operations safely, and free of placeholder bugs. Provide the necessary changes for pubspec.yaml and the entire main.dart / folder structure layout.
