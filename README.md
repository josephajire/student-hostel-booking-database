
# 🏠 Student Hostel Booking System (MySQL Database)
Greetings.
My name is Joseph Ajireloja.

Welcome to my database final project for the PLP Academy Week 8 Database Course Assignment.

## 📌 Overview
This project implements a relational database system for managing student hostel bookings using MySQL.  
The database provides structured storage and management of:
- Students
- Hostels & Rooms
- Bookings & Payments
- Staff & Allocations  

It ensures data integrity using proper constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`) and supports real-world relationships like One-to-Many and Many-to-Many.

---

## 📂 Database Schema
The database includes the following tables:

1. Students – Stores student details (name, gender, contact info).  
2. Hostels – Stores hostel details (name, location, capacity).  
3. Rooms – Stores room details (room number, type, availability, linked to hostels).  
4. Bookings – Stores booking information (student, room, dates, status).  
5. Payments – Stores payment transactions linked to bookings.  
6. Staff – Stores staff information (roles, contacts).  
7. Allocations – Maps staff to hostels (many-to-many relationship).  

---

## 🔑 Features
- Students can book available rooms in hostels.  
- Payments are linked to each booking.  
- Staff are assigned to manage hostels.  
- Room availability and booking status are tracked.  
- Referential integrity is enforced with constraints.  

---

## 🛠️ Installation & Setup

1. Clone this repository. 
   
2. Open MySQL Workbench and import hostel_booking.sql (from the cloned repository).

   > `hostel_booking.sql` contains the full database creation script (tables + constraints). The name of the database that will be created and added to the schema section on the MySQL Workbench is **studenthosteldb**.

3. Insert sample data. 

You can use and run the following SQL codes in MySQL Workbench to insert some sample data.

```sql
USE studenthosteldb; -- Switch to the imported database.

-- Insert sample students
INSERT INTO Students (first_name, last_name, gender, date_of_birth, email, phone_number)
VALUES 
('John', 'Doe', 'Male', '2001-05-10', 'john.doe@example.com', '08012345678'),
('Mary', 'Smith', 'Female', '2000-08-22', 'mary.smith@example.com', '08023456789'),
('David', 'Johnson', 'Male', '2002-03-15', 'david.j@example.com', '08034567890');

-- Insert sample hostels
INSERT INTO Hostels (hostel_name, location, capacity)
VALUES
('Freedom Hostel', 'North Campus', 200),
('Unity Hostel', 'South Campus', 150);

-- Insert sample rooms
INSERT INTO Rooms (hostel_id, room_number, room_type, capacity, is_available)
VALUES
(1, 'A101', 'Single', 1, TRUE),   -- Single room in Freedom Hostel
(1, 'A102', 'Double', 2, TRUE),   -- Double room in Freedom Hostel
(2, 'B201', 'Triple', 3, TRUE),   -- Triple room in Unity Hostel
(2, 'B202', 'Single', 1, TRUE);   -- Single room in Unity Hostel

-- Insert sample bookings
INSERT INTO Bookings (student_id, room_id, booking_date, check_in, check_out, status)
VALUES
(1, 1, '2025-09-01', '2025-09-05', '2025-12-20', 'Confirmed'), -- John booked A101
(2, 2, '2025-09-03', '2025-09-07', NULL, 'Pending');           -- Mary booked A102 (pending)

-- Insert sample payments
INSERT INTO Payments (booking_id, amount, payment_date, payment_method)
VALUES
(1, 50000.00, '2025-09-02', 'Transfer'), -- Payment for John's booking
(2, 30000.00, '2025-09-04', 'Cash');     -- Partial payment for Mary's booking

-- Insert sample staff
INSERT INTO Staff (first_name, last_name, role, phone_number)
VALUES
('Alice', 'Williams', 'Manager', '08045678901'), -- Hostel Manager
('Michael', 'Brown', 'Warden', '08056789012'),  -- Hostel Warden
('Grace', 'Taylor', 'Security', '08067890123'); -- Security Officer

-- Insert staff allocations to hostels
INSERT INTO Allocations (staff_id, hostel_id, allocation_date)
VALUES
(1, 1, '2025-09-01'), -- Alice assigned to Freedom Hostel
(2, 2, '2025-09-01'), -- Michael assigned to Unity Hostel
(3, 1, '2025-09-02'); -- Grace assigned to Freedom Hostel

```
---

## 📊 Example Queries

### 1. List all confirmed bookings with student names and hostel names

```sql
SELECT b.booking_id, s.first_name, s.last_name, h.hostel_name, r.room_number, b.status
FROM Bookings b
JOIN Students s ON b.student_id = s.student_id
JOIN Rooms r ON b.room_id = r.room_id
JOIN Hostels h ON r.hostel_id = h.hostel_id
WHERE b.status = 'Confirmed';
```

### 2. Show available rooms in a given hostel

```sql
SELECT h.hostel_name, r.room_number, r.room_type, r.capacity
FROM Rooms r
JOIN Hostels h ON r.hostel_id = h.hostel_id
WHERE r.is_available = TRUE;
```

### 3. Get payment history for a student

```sql
SELECT s.first_name, s.last_name, p.amount, p.payment_date, p.payment_method
FROM Payments p
JOIN Bookings b ON p.booking_id = b.booking_id
JOIN Students s ON b.student_id = s.student_id
WHERE s.student_id = 1;
```

---

## 📂 Project Structure

```
📁 student-hostel-booking-database
 ├── 📄 hostel_booking.sql              # Main database schema (tables + constraints)
 ├── 📄 README.md                       # Documentation
```

---

## 📜 License

This project is open-source under the MIT License.

---

## 👨‍💻 Author

* Joseph Ajireloja
* [GitHub Profile](https://github.com/josephajire)
