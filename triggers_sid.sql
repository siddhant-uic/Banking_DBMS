
-- grants
CREATE USER IF NOT EXISTS AdminBank@localhost IDENTIFIED BY 'Administrator';
CREATE ROLE IF NOT EXISTS 'Administrator';
GRANT SELECT, INSERT, UPDATE, DELETE  ON BankingSystem.* TO 'Administrator';

CREATE USER IF NOT EXISTS BranchManager2176@localhost IDENTIFIED BY 'Manager';
CREATE ROLE IF NOT EXISTS 'Manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON employees_of_branch_2176  TO 'Manager';
GRANT SELECT, INSERT, UPDATE, DELETE  ON customers_of_branch_2176 TO 'Manager'; 

CREATE USER IF NOT EXISTS Employee1@localhost IDENTIFIED BY 'Employees_2176';
CREATE ROLE IF NOT EXISTS 'Employees_2176';
GRANT SELECT, INSERT, UPDATE, DELETE  ON customers_of_branch_2176 TO 'Employees_2176';

-- views
CREATE VIEW employees_of_branch_2176 AS
SELECT DISTINCT p.firstname, p.lastname, e.empid
FROM person p, employee e
WHERE p.aadharno = e.aadharno AND e.empID in
 (SELECT e1.empid 
 FROM employee e1, employeeworks w, branch b
  WHERE e1.empid = w.empid AND w.branchid = b.branchid AND b.branchid = 2176
);
select* from employees_of_branch_2176;


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
    from cards
    where cards.CSubType = "MasterCard" and cards.CType="Debit")));

SELECT * FROM MasterCardTypeDebit;

CREATE VIEW customers_of_branch_2176_income_morethan_300000 AS
SELECT DISTINCT p.firstname, p.lastname, c.custID, c.Income, a1.BranchID
FROM person p, customer c, accountopened a1
WHERE p.aadharno = c.aadharno AND a1.BranchID=2176 AND c.CustID in
 (SELECT c1.CustID
 FROM customer c1, accountopened a
  WHERE c1.custID= a.CustID AND c1.Income>300000 AND a.BranchID =2176
 );

CREATE VIEW customers_of_branch_2176 AS
SELECT DISTINCT p.firstname, p.lastname, c.custID, c.Income, a1.BranchID
FROM person p, customer c, accountopened a1
WHERE p.aadharno = c.aadharno AND a1.BranchID=2176 AND c.CustID in
 (SELECT c1.CustID
 FROM customer c1, accountopened a
  WHERE c1.custID= a.CustID  AND a.BranchID =2176
 );
 
CREATE VIEW Female_Customers_with_FD AS
SELECT DISTINCT p.firstname, p.lastname, c.custID
FROM person p, customer c
WHERE p.Gender ='F' and  p.aadharno = c.aadharno AND  c.CustID in
 (SELECT c1.CustID
 FROM customer c1, fixeddeposits f
  WHERE c1.custID= f.CustID  
 );
 
 
 -- triggers

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

DELIMITER $$
CREATE TRIGGER `ConfirmTransaction` 
AFTER UPDATE ON account FOR EACH ROW
BEGIN
IF ( transactions.`Status`="P")
	THEN
	update transactions
	set transactions.Status = 'C'
	WHERE new.`Account#` = transactions.`Account#`;
END IF;
END
$$

DELIMITER $$
CREATE TRIGGER `NegativeBalanceError` 
AFTER UPDATE ON account FOR EACH ROW
BEGIN
	IF ( new.Balance<0 and account.`Account#` not in(select loan.`Acc#` from loanrequests loan) )THEN
		update transactions
		set transactions.`Status` = 'F'
		where transactions.`Account#` = new.`Account#`
		ORDER BY transactions.datetime desc limit 1;
		UPDATE account
		set account.`Balance` = old.`Balance`
		where account.`Account#` = old.`Account#`;
	ELSE
		update transactions
		set transactions.`Status` = 'C'
		where transactions.`Account#` = new.`Account#`
		ORDER BY transactions.datetime desc limit 1;
	END IF;
END;
$$


DELIMETER $$
CREATE TRIGGER 'CreditCardAllow'
AFTER INSERT ON creditcardrequests FOR EACH ROW
BEGIN
    IF (customer)
END
$$

DELIMTER $$
CREATE TRIGGER `DeductTransactionCost`


DELIMITER $$
CREATE TRIGGER `LoanRepayementComplete` 
AFTER UPDATE ON account FOR EACH ROW
BEGIN
IF ( new.Balance>0 and account.`Account#` in (select loan.`Acc#` from loanrequests loan)) 
	THEN	
	delete from account
    where new.`Account#` = account.`Account#`;
	
END IF;
END;
$$