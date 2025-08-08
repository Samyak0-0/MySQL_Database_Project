-- MySQL Failure and Recovery Simulation Script

-- Step 1: Create a clean environment for the simulation
DROP DATABASE IF EXISTS recovery_simulation;
CREATE DATABASE recovery_simulation;
USE recovery_simulation;

-- Step 2: Create a sample table to work with
CREATE TABLE financial_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_date DATETIME NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description VARCHAR(100),
    status VARCHAR(20) DEFAULT 'pending'
) ENGINE=InnoDB;

-- Step 3: Create a backup table to simulate backup operations
CREATE TABLE backup_financial_transactions LIKE financial_transactions;

-- Step 4: Simulate normal operations - initial data load
INSERT INTO financial_transactions (account_id, transaction_date, amount, description)
VALUES 
    (1001, NOW(), 500.00, 'Initial deposit'),
    (1002, NOW(), 1000.00, 'Account opening'),
    (1003, NOW(), 250.00, 'Initial deposit');

-- Take a simulated backup (in real scenario this would be a mysqldump or similar)
INSERT INTO backup_financial_transactions SELECT * FROM financial_transactions;

-- Step 5: Simulate more operations after backup
INSERT INTO financial_transactions (account_id, transaction_date, amount, description)
VALUES 
    (1001, NOW(), -50.00, 'ATM withdrawal'),
    (1002, NOW(), 200.00, 'Transfer in');

UPDATE financial_transactions SET status = 'completed' WHERE status = 'pending';

-- Step 6: Simulate a catastrophic failure (e.g., server crash, disk failure)
-- In a real scenario, this would be an actual crash
-- For simulation, we'll just drop the table to represent data loss
DROP TABLE financial_transactions;

-- Step 7: Disaster recovery begins here
-- First, recreate the table structure
CREATE TABLE financial_transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_date DATETIME NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description VARCHAR(100),
    status VARCHAR(20) DEFAULT 'pending'
) ENGINE=InnoDB;

-- Step 8: Restore from backup
INSERT INTO financial_transactions SELECT * FROM backup_financial_transactions;

-- Step 9: Simulate recovery of transactions after backup using binary logs
-- In a real scenario, you would use mysqlbinlog to replay transactions
-- For simulation, we'll manually re-run the post-backup transactions
INSERT INTO financial_transactions (account_id, transaction_date, amount, description, status)
VALUES 
    (1001, NOW(), -50.00, 'ATM withdrawal', 'completed'),
    (1002, NOW(), 200.00, 'Transfer in', 'completed');

-- Step 10: Verify recovery
SELECT 'Current database state after recovery:' AS message;
SELECT * FROM financial_transactions ORDER BY id;

SELECT 'Backup table state (for comparison):' AS message;
SELECT * FROM backup_financial_transactions ORDER BY id;

-- Step 11: Clean up (comment out if you want to inspect the results)
-- DROP DATABASE recovery_simulation;