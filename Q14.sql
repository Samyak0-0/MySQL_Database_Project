-- Create a test table for demonstration
CREATE TABLE transaction_demo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(100),
    amount DECIMAL(10,2)
);

-- Demonstrate COMMIT
START TRANSACTION;
INSERT INTO transaction_demo (description, amount) VALUES ('Order A', 32.75);
INSERT INTO transaction_demo (description, amount) VALUES ('Order B', 19.90);
SELECT * FROM transaction_demo; -- We should see 2 records
COMMIT;
SELECT * FROM transaction_demo; -- Records are permanently saved

-- Demonstrate ROLLBACK  
START TRANSACTION;
INSERT INTO transaction_demo (description, amount) VALUES ('Order C', 52.30);
INSERT INTO transaction_demo (description, amount) VALUES ('Order D', 41.15);
SELECT * FROM transaction_demo; -- We should see 4 records
ROLLBACK;
SELECT * FROM transaction_demo; -- Only 2 records remain (Orders C&D are rolled back)

-- Demonstrate SAVEPOINT
START TRANSACTION;
INSERT INTO transaction_demo (description, amount) VALUES ('Order E', 67.80);
SAVEPOINT sp1;
INSERT INTO transaction_demo (description, amount) VALUES ('Order F', 78.25);
SAVEPOINT sp2;
INSERT INTO transaction_demo (description, amount) VALUES ('Order G', 89.50);
SELECT * FROM transaction_demo; -- Should see 5 records

-- Rollback to savepoint 2
ROLLBACK TO sp2;
SELECT * FROM transaction_demo; -- Should see 4 records (Order G is gone)

-- Rollback to savepoint 1
ROLLBACK TO sp1;
SELECT * FROM transaction_demo; -- Should see 3 records (Orders F&G are gone)

COMMIT; -- Commit Order E
SELECT * FROM transaction_demo; -- Final count: 3 records