-- Insert Departments
INSERT INTO department (dept_name, location) VALUES
('Cardiology', 'Building A, Floor 2'),
('Neurology', 'Building B, Floor 3'),
('Emergency', 'Building A, Floor 1'),
('Pediatrics', 'Building C, Floor 1');

-- Insert Rooms
INSERT INTO room (room_number, room_type, floor_number) VALUES
('101', 'General', 1),
('201', 'ICU', 2),
('301', 'Surgery', 3),
('102', 'Emergency', 1);

-- Insert Doctors
INSERT INTO doctor (name, specialization, phone, email, dept_id) VALUES
('Dr. Smith', 'Cardiologist', '555-1001', 'smith@hospital.com', 1),
('Dr. Johnson', 'Neurologist', '555-1002', 'johnson@hospital.com', 2),
('Dr. Brown', 'Emergency Medicine', '555-1003', 'brown@hospital.com', 3),
('Dr. Wilson', 'Pediatrician', '555-1004', 'wilson@hospital.com', 4);

-- Insert Patients
INSERT INTO patient (name, age, gender, phone, address, room_id) VALUES
('Alice Cooper', 45, 'F', '555-2001', '123 Main St', 1),
('Bob Miller', 35, 'M', '555-2002', '456 Oak Ave', NULL),
('Carol Davis', 28, 'F', '555-2003', '789 Pine Rd', 2),
('David Wilson', 52, 'M', '555-2004', '321 Elm St', NULL);

-- Insert Appointments
INSERT INTO appointment (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1, 1, '2024-08-05', '10:00:00', 'Scheduled'),
(2, 2, '2024-08-05', '11:30:00', 'Completed'),
(3, 3, '2024-08-04', '14:00:00', 'Completed'),
(4, 4, '2024-08-06', '09:00:00', 'Scheduled');

-- Insert Medicines
INSERT INTO medicine (medicine_name, manufacturer, dosage, unit_price, stock_quantity) VALUES
('Aspirin', 'PharmaCorp', '100mg', 5.50, 100),
('Paracetamol', 'MediPlus', '500mg', 3.25, 150),
('Ibuprofen', 'HealthCare Inc', '200mg', 7.80, 80),
('Amoxicillin', 'BioPharm', '250mg', 12.40, 60);

-- View sample data
SELECT 'Departments:' as Info;
SELECT * FROM department;

SELECT 'Doctors:' as Info;
SELECT * FROM doctor;

SELECT 'Patients:' as Info;
SELECT * FROM patient;