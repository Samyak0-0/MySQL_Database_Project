-- Create a banking scenario
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(10,2)
);

-- Insert initial data with different names and balances
INSERT INTO accounts VALUES
(1, 'Cristianoah', 1200.00),
(2, 'Messy', 750.00);

-- Show initial state
SELECT * FROM accounts;

-- Simulate two concurrent transactions to demonstrate potential inconsistency
-- Transaction 1: Transfer $150 from Cristianoah to Messy
-- Transaction 2: Transfer $80 from Messy to Cristianoah

-- Without proper concurrency control, this could lead to issues
-- Demonstrate with two separate sessions:

-- SESSION 1 (run in first MySQL connection):
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1; -- Cristianoah has $1200
SELECT balance FROM accounts WHERE account_id = 2; -- Messy has $750
-- (simulate delay here)
UPDATE accounts SET balance = balance - 150 WHERE account_id = 1; -- Cristianoah loses $150
-- DON'T COMMIT YET

-- SESSION 2 (run in second MySQL connection):
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1; -- Still sees Cristianoah with $1200
SELECT balance FROM accounts WHERE account_id = 2; -- Still sees Messy with $750
UPDATE accounts SET balance = balance - 80 WHERE account_id = 2;  -- Messy loses $80
UPDATE accounts SET balance = balance + 80 WHERE account_id = 1;  -- Cristianoah gains $80
COMMIT;

-- Back to SESSION 1:
UPDATE accounts SET balance = balance + 150 WHERE account_id = 2; -- Messy gains $150
COMMIT;

-- Check final state - potential inconsistency!
SELECT * FROM accounts;