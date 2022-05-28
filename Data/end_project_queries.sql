-- Query 1:
SELECT c.custid, c.`Credit Score`
FROM customer c
WHERE c.`Credit Score` BETWEEN 550 AND 750 AND c.custid NOT IN (
SELECT DISTINCT custid
FROM creditcardrequests);

-- Query 2
UPDATE loanacc
SET InterestRate = InterestRate - 1
WHERE loanacc.`Account#` IN (SELECT loanrequests.`Acc#`
FROM loanrequests
WHERE loanrequests.type = 'HOME');

-- Query 3
SELECT p.firstname, p.lastname, e.empid FROM person p NATURAL JOIN employee e WHERE e.empid IN (SELECT empid FROM (
SELECT max(DOJ) as latestjoining, empid
FROM employeeworks
GROUP BY empid
HAVING DATEDIFF(CURDATE(), latestjoining) > 3650) AS currworks );

-- Query 4
SELECT a.`Account#` , sum(t.amount) as total_withdrawal
FROM account a, transactions t
WHERE a.`Account#` = t.`Account#` AND t.type = 'DEBIT' AND t.status = 'C'
GROUP BY a.`Account#`
HAVING total_withdrawal < 5000000;

-- Query 5
SELECT d.`Account#`, a.balance
FROM depositoryacc d, account a WHERE d.`Account#` = a.`Account#`
AND d.`DebitCard#` NOT IN (SELECT c.cardNo FROM cards c
WHERE DATEDIFF(CURDATE(), c.`IssueDate`) - (c.`Term_Months` *30) < 0);

-- Query 6
DELETE
FROM account
WHERE account.`Account#` NOT IN ((SELECT DISTINCT transactions.`Account#`
FROM transactions
WHERE DATEDIFF(CURDATE(), transactions.`DateTime`) < 3653
) UNION (SELECT loanacc.`Account#` FROM loanacc));


-- Query 7
SELECT COUNT(DISTINCT p.AadharNo) as num_people FROM person p, customer c, employee e
WHERE p.AadharNo = c.AadharNo AND p.AadharNo = e.AadharNo AND p.firstname LIKE 'R%';


-- Views SQL
-- 1. View created ofemployees with their name and employee ID working at the branch whose ID is 2176:
-- Ans: 
CREATE VIEW employees_of_branch_2176 AS
SELECT DISTINCT p.firstname, p.lastname, e.empid
FROM person p, employee e
WHERE p.aadharno = e.aadharno AND e.empID in
(SELECT e1.empid 
 FROM employee e1, employeeworks w, branch b
  	WHERE e1.empid = w.empid AND w.branchid = b.branchid AND b.branchid = 2176
);

-- 2.  View created of customers with their name and Customer ID who have a Debit Card of type Master Card:
-- Ans:
CREATE VIEW MasterCardTypeDebit AS
SELECT DISTINCT p.firstname, p.lastname, cust.CustID
FROM person p,  customer cust 
WHERE p.aadharno = cust.aadharno AND cust.CustID in
	(SELECT distinct cust1.CustID
	FROM customer cust1,  depositoryacc d1, accountopened a1
	WHERE cust1.CustID = a1.CustID AND a1.`Account#` in
		(SELECT distinct a2.`Account#`
		FROM  depositoryacc d2, accountopened a2
		WHERE a2.`Account#` = d2.`Account#` and d2.`DebitCard#`in
			(Select cards.CardNo
			FROM cards
			where cards.CSubType = "MasterCard" and cards.CType="Debit")));
			
-- 3. View created of customers with their name, customer ID, income who have some holdings in the branch with ID 2176 and whose income is more than 3 lakhs:
-- Ans:
CREATE VIEW customers_of_branch_2176_income_morethan_300000 AS
SELECT DISTINCT p.firstname, p.lastname, c.custID, c.Income, a1.BranchID
FROM person p, customer c, accountopened a1
WHERE p.aadharno = c.aadharno AND a1.BranchID=2176 AND c.CustID in
	(SELECT c1.CustID
	FROM customer c1, accountopened a
	WHERE c1.custID= a.CustID AND c1.Income>300000 AND a.BranchID =2176);
		
-- 4. View created of female customers who own a fixed deposit in any branch.
-- Ans:
CREATE VIEW Female_Customers_with_FD AS
SELECT DISTINCT p.firstname, p.lastname, c.custID
FROM person p, customer c
WHERE p.Gender ='F' and  p.aadharno = c.aadharno AND  c.CustID in
	(SELECT c1.CustID
	FROM customer c1, fixeddeposits f
	WHERE c1.custID= f.CustID );

-- Grants:
-- 1. A role for Administrator is created who has been granted the authority to SELECT, INSERT, UPDATE, DELETE the database tables of the entire Banking System.
CREATE USER IF NOT EXISTS AdminBank@localhost IDENTIFIED BY 'Administrator';
CREATE ROLE IF NOT EXISTS 'Administrator';
GRANT SELECT, INSERT, UPDATE, DELETE  ON BankingSystem.* TO 'Administrator';

-- 2. A role for Manager of the branch with ID 2176 is created who has been granted the authority to SELECT, INSERT, UPDATE, DELETE the database tables of the employees and customers of that branch.
CREATE USER IF NOT EXISTS BranchManager2176@localhost IDENTIFIED BY 'Manager';
CREATE ROLE IF NOT EXISTS 'Manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON employees_of_branch_2176  TO 'Manager';
GRANT SELECT, INSERT, UPDATE, DELETE  ON customers_of_branch_2176 TO 'Manager'; 

-- 3. A role for employees working at the branch with ID 2176 is created who have been given the authority to SELECT, INSERT, UPDATE, DELETE the database tables of the customers of that branch.
CREATE USER IF NOT EXISTS Employee1@localhost IDENTIFIED BY 'Employees_2176';
CREATE ROLE IF NOT EXISTS 'Employees_2176';
GRANT SELECT, INSERT, UPDATE, DELETE  ON customers_of_branch_2176 TO 'Employees_2176';


-- Triggers
-- 1. Trigger to process pending transactions, when a customer requests for a transaction, it checks the status and proceeds accordingly.
-- Ans:
DELIMITER $$ 
CREATE TRIGGER `pendingTransactionsToAcc` 
AFTER INSERT ON transactions FOR EACH ROW
BEGIN
IF ( new.`Status`="P")
	then 
    IF new.`Type` = "CREDIT" 
		THEN
		update account
		set account.`Balance` = account.`Balance` + new.`Amount`
		WHERE account.`Account#` = new.`Account#`;

	ELSE 
    update account
    set account.`Balance` = account.`Balance` - new.`Amount`
	WHERE account.`Account#` = new.`Account#`;
    END IF;
END IF;
END
$$

-- 2. Trigger to increment salary of an employee by 10,000 when promoted as manager
DELIMITER $$
CREATE TRIGGER `Promotion` 
AFTER INSERT ON manages FOR EACH ROW
BEGIN
update employee
set Salary = Salary  + 10000
WHERE employee.`empId` = new.`empId`;
END
$$


-- 3. Trigger to increase balance by 1000 on request of a credit card.
DELIMITER $$
CREATE TRIGGER `Cashback` 
AFTER INSERT ON `creditcardrequests` FOR EACH ROW
BEGIN
update account
set Balance = Balance  + 1000
WHERE `account#` = (SELECT  a1.`account#` FROM accountopened a1 WHERE a1.`custid` = new.`custid` LIMIT 1);
END
$$


-- 4. Trigger to charge extra on transactions beyond 100000
-- Ans:
DELIMITER $$
CREATE TRIGGER `TransactionCharge` 
AFTER INSERT ON transactions FOR EACH ROW
BEGIN
IF (new.`amount` > 100000) THEN
	update account
	set `Balance` = `Balance` - 5
	WHERE account.`Account#` = new.`Account#`;
END IF;
END
$$

-- Indexing:
-- Query 1:						
CREATE INDEX indexForCS 
ON customer(`Credit Score`); 
-- Row reduction : 30 → 8 
					
-- Query 2:				
-- Added index on loan type reduce row nos 5 → 1 

CREATE INDEX idxloanrequests
ON loanrequests(type); 

					
-- Query 3: 			
						
CREATE INDEX idx10yrs 
ON employeeworks(DOJ); 
					
-- Query 	4: 
-- created index to reduce no. of rows to query on. The index on account no. was already present. Added index on transaction type and status. Reduced row nos 50 → 32
CREATE INDEX idx
ON transactions(Type);
CREATE INDEX idx2 
ON transactions(Status); 
					
-- Query 5:						
CREATE INDEX idxcards ON cards(`Term_Months`); 
CREATE INDEX idxcards2 ON cards(`IssueDate`); 
CREATE INDEX idxcards3 ON cards(`cardNo`);						
CREATE INDEX idxdep ON depositoryacc(`DebitCard#`); 
-- Query 6:					
CREATE INDEX inactiveAccounts ON account(`Account#`);
CREATE INDEX inactiveAccounts2 ON transactions(`DateTime`); 
					
-- Query 7:	
CREATE INDEX indexForCount ON person(`firstname`);
-- Rows reduced to 50 → 5 
