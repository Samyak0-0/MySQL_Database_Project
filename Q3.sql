-- 3. Demonstrate commit and rollback using SQL with updated values.

-- Start a transaction
START TRANSACTION;

-- Insert new data
INSERT INTO patients (name, age, gender, phone) VALUES
('Emma Clark', 28, 'F', '555-9876');

SELECT * FROM patients;

-- Rollback the transaction (Emma will not be saved)
ROLLBACK;

-- Check again (Emma should be gone)
SELECT * FROM patients;

-- Now let's commit a transaction
START TRANSACTION;
INSERT INTO patients (name, age, gender, phone) VALUES
('John Smith', 47, 'M', '555-6543');
COMMIT;

-- Check final result
SELECT * FROM patients;