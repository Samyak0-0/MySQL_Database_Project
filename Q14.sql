-- Create a test table for demonstration
CREATE TABLE transaction_demo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(100),
    amount DECIMAL(10,2)
);

-- Demonstrate COMMIT
START TRANSACTION;
INSERT INTO transaction_demo (description, amount) VALUES ('Purchase 1', 25.50);
INSERT INTO transaction_demo (description, amount) VALUES ('Purchase 2', 15.75);
SELECT * FROM transaction_demo; -- You should see 2 records
COMMIT;
SELECT * FROM transaction_demo; -- Records are permanently saved

-- Demonstrate ROLLBACK  
START TRANSACTION;
INSERT INTO transaction_demo (description, amount) VALUES ('Purchase 3', 45.00);
INSERT INTO transaction_demo (description, amount) VALUES ('Purchase 4', 35.25);
SELECT * FROM transaction_demo; -- You should see 4 records
ROLLBACK;
SELECT * FROM transaction_demo; -- Only 2 records remain (purchases 3&4 are rolled back)

-- Demonstrate SAVEPOINT
START TRANSACTION;
INSERT INTO transaction_demo (description, amount) VALUES ('Purchase 5', 55.00);
SAVEPOINT sp1;
INSERT INTO transaction_demo (description, amount) VALUES ('Purchase 6', 65.00);
SAVEPOINT sp2;
INSERT INTO transaction_demo (description, amount) VALUES ('Purchase 7', 75.00);
SELECT * FROM transaction_demo; -- Should see 5 records

-- Rollback to savepoint 2
ROLLBACK TO sp2;
SELECT * FROM transaction_demo; -- Should see 4 records (Purchase 7 is gone)

-- Rollback to savepoint 1
ROLLBACK TO sp1;
SELECT * FROM transaction_demo; -- Should see 3 records (Purchase 6&7 are gone)

COMMIT; -- Commit Purchase 5
SELECT * FROM transaction_demo; -- Final count: 3 records