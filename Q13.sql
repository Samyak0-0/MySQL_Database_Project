-- First, let's create a simple banking scenario
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(10,2)
);

INSERT INTO accounts VALUES
(1, 'Alice', 1000.00),
(2, 'Bob', 500.00);

-- Show initial state
SELECT * FROM accounts;

-- Now we'll simulate two concurrent transactions that can cause inconsistency
-- Transaction 1: Transfer $100 from Alice to Bob
-- Transaction 2: Transfer $50 from Bob to Alice

-- Without proper concurrency control, this could cause problems
-- Let's demonstrate with two separate sessions:

-- SESSION 1 (run in first MySQL connection):
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1; -- Alice has $1000
SELECT balance FROM accounts WHERE account_id = 2; -- Bob has $500
-- (simulate delay here)
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1; -- Alice loses $100
-- DON'T COMMIT YET

-- SESSION 2 (run in second MySQL connection):
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 1; -- Still sees Alice with $1000
SELECT balance FROM accounts WHERE account_id = 2; -- Still sees Bob with $500
UPDATE accounts SET balance = balance - 50 WHERE account_id = 2;  -- Bob loses $50
UPDATE accounts SET balance = balance + 50 WHERE account_id = 1;  -- Alice gains $50
COMMIT;

-- Back to SESSION 1:
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2; -- Bob gains $100
COMMIT;

-- Check final state - there might be inconsistency!
SELECT * FROM accounts;