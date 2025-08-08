-- Database Setup
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(50),
    balance DECIMAL(10, 2)
);

-- Insert initial data
INSERT INTO accounts (account_id, account_holder, balance) VALUES
(1, 'Senor', 1000.00),
(2, 'Larry', 1000.00);

-- Scenario 1: Without Concurrency Control
-- Session 1 (Transaction 1): Senor transfers $200 to Larry
-- Run in one session
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1; -- Senor: 1000
SELECT balance FROM accounts WHERE account_id = 2; -- Larry: 1000
UPDATE accounts SET balance = balance - 200 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 200 WHERE account_id = 2;
DO SLEEP(5); -- Simulate delay
COMMIT;

-- Session 2 (Transaction 2): Larry transfers $300 to Senor
-- Run in another session immediately after starting Session 1
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1; -- Senor: 1000
SELECT balance FROM accounts WHERE account_id = 2; -- Larry: 1000
UPDATE accounts SET balance = balance - 300 WHERE account_id = 2;
UPDATE accounts SET balance = balance + 300 WHERE account_id = 1;
COMMIT;

-- Verifying results (Incorrect: Senor: 1300, Larry: 700 due to lost update)
SELECT * FROM accounts;

-- Reset data for Scenario 2
UPDATE accounts SET balance = 1000.00 WHERE account_id IN (1, 2);

-- Scenario 2: With Concurrency Control
-- Set isolation level in both sessions before starting
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Session 1 (Transaction 1): Senor transfers $200 to Larry
-- Run in one session
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id IN (1, 2) FOR UPDATE;
UPDATE accounts SET balance = balance - 200 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 200 WHERE account_id = 2;
DO SLEEP(5); -- Simulate delay
COMMIT;

-- Session 2 (Transaction 2): Larry transfers $300 to Senor
-- Run in another session immediately after starting Session 1
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id IN (1, 2) FOR UPDATE;
UPDATE accounts SET balance = balance - 300 WHERE account_id = 2;
UPDATE accounts SET balance = balance + 300 WHERE account_id = 1;
COMMIT;

-- Verifying results (Correct: Senor: 1100, Larry: 900)
SELECT * FROM accounts;