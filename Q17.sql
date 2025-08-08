-- Transaction A: Transfer $100 from Account 1 to Account 2
-- Transaction B: Transfer $50 from Account 2 to Account 1
-- Both run simultaneously

-- Transaction A (Session 1):
SELECT balance FROM accounts WHERE account_id = 1; -- Reads $1000
SELECT balance FROM accounts WHERE account_id = 2; -- Reads $500
-- Calculate new balances: A1=$900, A2=$600
UPDATE accounts SET balance = 900 WHERE account_id = 1;

-- Transaction B (Session 2) runs here:
SELECT balance FROM accounts WHERE account_id = 1; -- Still reads $1000 (dirty read)
SELECT balance FROM accounts WHERE account_id = 2; -- Reads $500
-- Calculate new balances: A1=$1050, A2=$450
UPDATE accounts SET balance = 1050 WHERE account_id = 1; -- Overwrites Transaction A!
UPDATE accounts SET balance = 450 WHERE account_id = 2;

-- Transaction A continues:
UPDATE accounts SET balance = 600 WHERE account_id = 2; -- Overwrites Transaction B!

-- RESULT: Lost updates! Final state may be inconsistent









-- Transaction A: Proper locking
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id IN (1,2) FOR UPDATE; -- Lock both accounts
-- Now Transaction A has exclusive access to both accounts
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
COMMIT; -- Releases locks

-- Transaction B: Must wait for Transaction A to complete
START TRANSACTION;
SELECT balance FROM accounts WHERE account_id IN (1,2) FOR UPDATE; -- Waits for lock
-- Gets consistent view after Transaction A commits
UPDATE accounts SET balance = balance + 50 WHERE account_id = 1;
UPDATE accounts SET balance = balance - 50 WHERE account_id = 2;
COMMIT;


-- real world example 
-- Without control: Two customers buy the last item
-- Customer A sees: stock = 1, proceeds to buy
-- Customer B sees: stock = 1, proceeds to buy  
-- Result: Overselling! Stock = -1

-- With control: Second customer sees "out of stock"
-- Customer A locks item, reduces stock to 0
-- Customer B waits, then sees stock = 0, gets "sold out" message