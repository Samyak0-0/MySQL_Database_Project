-- Create Department table first (referenced by Doctor)
CREATE TABLE department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100)
);

-- Create Room table (referenced by Patient)
CREATE TABLE room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type ENUM('General', 'ICU', 'Emergency', 'Surgery') NOT NULL,
    status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available',
    floor_number INT
);

-- Create Doctor table
CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

-- Create Patient table
CREATE TABLE patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('M', 'F'),
    phone VARCHAR(15),
    address TEXT,
    room_id INT,
    FOREIGN KEY (room_id) REFERENCES room(room_id)
);

-- Create Appointment table
CREATE TABLE appointment (
    appt_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

-- Create Treatment table
CREATE TABLE treatment (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    appt_id INT,
    treatment_description TEXT,
    cost DECIMAL(10,2),
    treatment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appt_id) REFERENCES appointment(appt_id)
);

-- Create Medicine table
CREATE TABLE medicine (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_name VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100),
    dosage VARCHAR(50),
    unit_price DECIMAL(8,2),
    stock_quantity INT DEFAULT 0
);

-- Create Prescription table (M:M relationship)
CREATE TABLE prescription (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    treatment_id INT,
    medicine_id INT,
    quantity INT NOT NULL,
    dosage_instructions TEXT,
    duration_days INT,
    FOREIGN KEY (treatment_id) REFERENCES treatment(treatment_id),
    FOREIGN KEY (medicine_id) REFERENCES medicine(medicine_id)
);

-- Show all tables
SHOW TABLES;