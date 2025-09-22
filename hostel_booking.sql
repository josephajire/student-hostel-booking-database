/* Creation of a database named “StudentHostelDB” 
for a Student Hostel Booking System by Joseph Ajireloja. */

-- Create the database (if it doesn't already exist)
CREATE DATABASE IF NOT EXISTS StudentHostelDB;

-- Switch to the created database
USE StudentHostelDB;

/* -----------------------------------
Creation of the table named “Students”. 
The table stores student information for hostel bookings.
----------------------------------- */

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique student ID
    first_name VARCHAR(50) NOT NULL,                  -- Student first name
    last_name VARCHAR(50) NOT NULL,                   -- Student last name
    gender ENUM('Male', 'Female') NOT NULL,           -- Gender (restricted values)
    date_of_birth DATE NOT NULL,                      -- Date of birth
    email VARCHAR(100) UNIQUE NOT NULL,               -- Unique email address
    phone_number VARCHAR(15) UNIQUE NOT NULL          -- Unique phone number
);

/* -----------------------------------
Creation of the table named “Hostels”.
It stores general information about hostel buildings.
----------------------------------- */

CREATE TABLE Hostels (
    hostel_id INT AUTO_INCREMENT PRIMARY KEY,         -- Unique hostel ID
    hostel_name VARCHAR(100) NOT NULL,                -- Name of the hostel
    location VARCHAR(100) NOT NULL,                   -- Location on campus
    capacity INT NOT NULL CHECK (capacity > 0)        -- Maximum student capacity
);


/* -----------------------------------
Creation of the table named “Rooms”.
It stores details about rooms within hostels.
----------------------------------- */

CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,           -- Unique room ID
    hostel_id INT NOT NULL,                           -- References Hostels table
    room_number VARCHAR(20) NOT NULL,                 -- Room number
    room_type ENUM('Single', 'Double', 'Triple') NOT NULL, -- Type of room
    capacity INT NOT NULL CHECK (capacity > 0),       -- Number of beds in the room
    is_available BOOLEAN DEFAULT TRUE,                -- Room availability status
    CONSTRAINT fk_rooms_hostel 
        FOREIGN KEY (hostel_id) REFERENCES Hostels(hostel_id) ON DELETE CASCADE,
    CONSTRAINT uc_room UNIQUE (hostel_id, room_number) -- Prevent duplicate room numbers in the same hostel
);

/* -----------------------------------
Creation of the table named “Bookings”.
It stores booking information for each student.
----------------------------------- */
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique booking ID
    student_id INT NOT NULL,                          -- References Students table
    room_id INT NOT NULL,                             -- References Rooms table
    booking_date DATE NOT NULL,                       -- Date booking was made
    check_in DATE NOT NULL,                           -- Expected check-in date
    check_out DATE,                                   -- Expected check-out date (nullable if active)
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending', -- Current booking status
    CONSTRAINT fk_booking_student 
        FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_room 
        FOREIGN KEY (room_id) REFERENCES Rooms(room_id) ON DELETE CASCADE
);

/* -----------------------------------
Creation of the table named “Payments”.
It stores payment details linked to bookings.
----------------------------------- */

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique payment ID
    booking_id INT NOT NULL,                          -- References Bookings table
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0), -- Amount paid
    payment_date DATE NOT NULL,                       -- Date of payment
    payment_method ENUM('Cash', 'Card', 'Transfer') NOT NULL, -- Mode of payment
    CONSTRAINT fk_payment_booking 
        FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

/* -----------------------------------
Creation of the table named “Staff”.
It stores information about staff members who manage or support hostels.
----------------------------------- */

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,          -- Unique staff ID
    first_name VARCHAR(50) NOT NULL,                  -- Staff first name
    last_name VARCHAR(50) NOT NULL,                   -- Staff last name
    role ENUM('Manager', 'Warden', 'Cleaner', 'Security') NOT NULL, -- Role in hostel
    phone_number VARCHAR(15) UNIQUE NOT NULL          -- Unique phone number
);

/* -----------------------------------
Creation of the table named “Allocations”.
It maps staff members to hostels they manage.
(The table shows Many-to-Many relationship).
 ----------------------------------- */

CREATE TABLE Allocations (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,     -- Unique allocation ID
    staff_id INT NOT NULL,                            -- References Staff table
    hostel_id INT NOT NULL,                           -- References Hostels table
    allocation_date DATE NOT NULL,                    -- Date staff was assigned
    CONSTRAINT fk_allocation_staff 
        FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE,
    CONSTRAINT fk_allocation_hostel 
        FOREIGN KEY (hostel_id) REFERENCES Hostels(hostel_id) ON DELETE CASCADE,
    CONSTRAINT uc_allocation UNIQUE (staff_id, hostel_id) -- Prevent duplicate assignments
);
