-- Create a database for demonstration
CREATE DATABASE IF NOT EXISTS checkpoint_demo;
USE checkpoint_demo;

-- Create a sample table
CREATE TABLE IF NOT EXISTS accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert some sample data
INSERT INTO accounts (account_name, balance) VALUES 
('Carrot', 1000.00),
('Cuccumber', 500.00),
('Raddish', 750.00);

-- Start a transaction
START TRANSACTION;

-- Display initial state
SELECT 'Initial state:' AS message;
SELECT * FROM accounts;

-- Perform first operation (Carrot transfers 100 to Cuccumber)
UPDATE accounts SET balance = balance - 100 WHERE account_name = 'Carrot';
UPDATE accounts SET balance = balance + 100 WHERE account_name = 'Cuccumber';

-- Create a savepoint (checkpoint)
SAVEPOINT after_first_transfer;

-- Display state after first transfer
SELECT 'After Carrot transfers 100 to Cuccumber:' AS message;
SELECT * FROM accounts;

-- Perform second operation (Cuccumber transfers 200 to Raddish)
UPDATE accounts SET balance = balance - 200 WHERE account_name = 'Cuccumber';
UPDATE accounts SET balance = balance + 200 WHERE account_name = 'Raddish';

-- Create another savepoint
SAVEPOINT after_second_transfer;

-- Display state after second transfer
SELECT 'After Cuccumber transfers 200 to Raddish:' AS message;
SELECT * FROM accounts;

-- Let's say we encounter an issue and need to rollback to the first transfer
ROLLBACK TO SAVEPOINT after_first_transfer;

-- Display state after rollback to first transfer
SELECT 'After rolling back to after_first_transfer savepoint:' AS message;
SELECT * FROM accounts;

-- Now let's commit the transaction up to the first savepoint
COMMIT;

-- Final state
SELECT 'Final state after commit:' AS message;
SELECT * FROM accounts;

-- Clean up (optional)
-- DROP DATABASE checkpoint_demo;