-- Set up test data
CREATE TABLE isolation_test (
    id INT PRIMARY KEY,
    value INT
);

INSERT INTO isolation_test VALUES (1, 100);

-- Demonstrate different isolation levels
-- First, show current isolation level
SELECT @@transaction_isolation;

-- READ UNCOMMITTED (Dirty Read possible)
-- Session 1:
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
SELECT * FROM isolation_test; -- Shows value = 100

-- Session 2:
START TRANSACTION;
UPDATE isolation_test SET value = 200 WHERE id = 1;
-- DON'T COMMIT

-- Back to Session 1:
SELECT * FROM isolation_test; -- May show value = 200 (dirty read)

-- Session 2:
ROLLBACK; -- Undo the change

-- Session 1:
SELECT * FROM isolation_test; -- Back to 100
COMMIT;

-- READ COMMITTED (Prevents dirty reads)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Repeat the above test - Session 1 won't see uncommitted changes

-- REPEATABLE READ (Default in MySQL)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Demonstrates phantom reads prevention

-- SERIALIZABLE (Strictest)
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- All transactions run as if they were executed serially