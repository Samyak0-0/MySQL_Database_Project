-- Example 1: Basic Transaction with Table-Level Lock
START TRANSACTION;
LOCK TABLES employees WRITE;
UPDATE employees SET salary = salary * 1.1 WHERE department_id = 10;
COMMIT;
UNLOCK TABLES;

-- Example 2: Row-Level Locking with SELECT ... FOR UPDATE
START TRANSACTION;
SELECT * FROM orders WHERE order_id = 1001 FOR UPDATE;
UPDATE orders SET status = 'processed' WHERE order_id = 1001;
COMMIT;

-- Example 3: Handling Concurrent Updates with Transaction Isolation
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id = 500;
UPDATE accounts SET balance = balance - 100 WHERE account_id = 500;
COMMIT;

-- Example 4: Deadlock Prevention with Ordered Locking
START TRANSACTION;
LOCK TABLES accounts WRITE, transactions WRITE;
UPDATE accounts SET balance = balance - 50 WHERE account_id = 200;
INSERT INTO transactions (account_id, amount, type) VALUES (200, -50, 'WITHDRAWAL');
COMMIT;
UNLOCK TABLES;

-- Example 5: Read Lock for Consistent Reads
START TRANSACTION;
LOCK TABLES inventory READ;
SELECT quantity FROM inventory WHERE product_id = 300;
COMMIT;
UNLOCK TABLES;