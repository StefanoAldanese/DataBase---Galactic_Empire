# README - Galactic Empire Database

## Installation and Configuration

For proper functionality and database creation, carefully follow the steps below.

---

### Script Execution Order

1. **possessoreDB.sql**
   - Creates the database *administrator* user.
   - *Detailed connection instructions are provided within the file comments.*

2. **Log in as Administrator**
   - Log in via terminal using the command:
     ```bash
     sqlplus amministratore/admin123@//localhost:[free_port]/[your_PDB]
     ```
     - Replace `[your_PDB]` with the actual name of your Pluggable Database (e.g., `XEPDB1`).
     - More detailed instructions are inside the `possessoreDB.sql` file.

3. **Scripts to Execute in Mandatory Order**
   - `creazioneDDL.sql` → database structure
   - `viste.sql` → view definitions
   - `funzioni.sql` → custom function declarations (functions used inside procedures)
   - `procedure.sql` → PL/SQL procedures (some depend on views)

4. **Scripts to Execute in Arbitrary Order**
   - `triggers.sql` → control and security triggers
   - `popolamentoDML.sql` → initial data insertion
   - `users.sql` → system user creation

---

## Database Content

The database simulates a **Galactic Empire** and includes:

- Planetary systems and planets
- Mining, warfare, and transportation corporations
- Military divisions and conquest wars
- Interplanetary resource logistics and transport

---

## Creators

**Developed by:**
- Stefano Aldanese Emanuele
- Donato D'Ambrosio

---

## Testing and Debugging

The `scripts/` folder also includes:

- Test queries to verify correct operation
- Tests that generate errors to:
  - Cause certain procedures to fail
  - Activate security and control triggers

---

## Database Destruction

To drop the entire database, execute the `distruzioneDDL.sql` script while logged in as administrator:
     ```bash
     sqlplus amministratore/admin123@//localhost:[free_port]/[your_PDB]
     ```

---

## Additional Scripts

- **Script to Execute if You Want to Add Synonyms to Tables**
  - `sinonimi.sql`: Contains commands to create public synonyms for all tables, views, functions, and procedures
  - If the "sinonimi.sql" script has NOT been executed, use the "amministratore." prefix when querying from the users' perspective:  
    ```sql
    SELECT * FROM amministratore.Corporation;
    ```

---

## User Credentials

| Role                   | Username               | Password       |
|------------------------|------------------------|----------------|
| Administrator          | amministratore         | admin123       |
| Emperor                | imperatore             | impero4ever    |
| General                | generale               | hateyoda       |
| Corporation Executive  | dirigente_corporation  | fatturato      |