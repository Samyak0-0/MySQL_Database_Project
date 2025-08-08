-- Create a basic patients table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('M', 'F'),
    phone VARCHAR(15),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO Patients (name, age, gender, phone) VALUES
('Alice Williams', 30, 'F', '555-1111'),
('David Miller', 42, 'M', '555-2222'),
('Sophia Davis', 25, 'F', '555-3333');

-- View the data
SELECT * FROM Patients;