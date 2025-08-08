-- Demonstrate explicit locking
-- Shared Lock (FOR SHARE)
START TRANSACTION;
SELECT * FROM accounts WHERE account_id = 1 FOR SHARE;
-- Other transactions can read but not modify this row
-- COMMIT or ROLLBACK to release lock

-- Exclusive Lock (FOR UPDATE)
START TRANSACTION;
SELECT * FROM accounts WHERE account_id = 1 FOR UPDATE;
-- Other transactions cannot read or modify this row
-- COMMIT or ROLLBACK to release lock

-- Table-level locking
LOCK TABLES accounts WRITE;
-- Only this session can read/write the accounts table
UPDATE accounts SET balance = balance * 1.05; -- 5% interest
UNLOCK TABLES;

-- Demonstrate deadlock prevention with ordered locking
-- Transaction 1:
START TRANSACTION;
SELECT * FROM accounts WHERE account_id = 1 FOR UPDATE; -- Lock account 1 first
SELECT * FROM accounts WHERE account_id = 2 FOR UPDATE; -- Then lock account 2
-- Perform operations
COMMIT;

-- Transaction 2 should follow same order to prevent deadlock:
START TRANSACTION;
SELECT * FROM accounts WHERE account_id = 1 FOR UPDATE; -- Lock account 1 first
SELECT * FROM accounts WHERE account_id = 2 FOR UPDATE; -- Then lock account 2
-- Perform operations  
COMMIT;