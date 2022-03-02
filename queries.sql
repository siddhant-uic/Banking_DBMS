-- SQL Queries:

-- Query 1:  Return Customer IDs of those customers who have a depository account but no loan.
-- SQL Query:

SELECT custid
FROM accountopened
WHERE custid NOT IN (
SELECT DISTINCT custid  
FROM loanrequests
);

-- Query 2:  Return  first name, last name and CustomerID of those customers who have both fixed deposit and credit card.
-- SQL Query:
SELECT p.firstname, p.lastname, c.custid
FROM person as p, customer as c, fixeddeposits as f, creditcardrequests as r
WHERE p.AadharNo=c.AadharNo AND c.custid=f.custid AND c.custid=r.custid;


-- Query 3: Return first name, last name and CustomerID of those customers who have made more than 2 transactions.
-- SQL Query:
SELECT DISTINCT p.firstname, p.lastname, c.custid
FROM person as p, customer as c
WHERE c.custid IN (
SELECT custid
FROM transactions
GROUP BY custid
HAVING count(*) >2
) AND p.aadharno=c.aadharno;


-- Query 4: Return first name, last name and EmployeeID of those employees who are from the same city as the branch of Bank they are working in.
-- SQL Query:
SELECT DISTINCT p.firstname, p.lastname, e.empid
FROM person p, employee e, employeeworks w, branch b
WHERE p.aadharno=e.aadharno AND e.empid=w.empid AND w.branchid=b.branchid AND p.city=b.city;




-- Query 5: Update the withdrawal limit of ‘VISA’ debit card to 100000.
-- SQL Query:
UPDATE debitcard 
SET withdrawal_limit= 100000
WHERE ctype = 'VISA';


-- Query 6: Delete the record of the person whose Aadhar number is 122142880209.
-- SQL Query:
DELETE
FROM person
WHERE aadharno=122142880209;


-- Query 7: Create view for manager whose employee id is 435198 who can see all employees in his branch.
-- SQL Query:
CREATE VIEW employees_of_branch_of_435198 AS
SELECT DISTINCT p.firstname, p.lastname, e.empid
FROM person p, employee e
WHERE p.aadharno = e.aadharno AND e.empID in
 (SELECT e1.empid 
 FROM employee e1, employeeworks w, branch b
  WHERE e1.empid = w.empid AND w.branchid = b.branchid AND b.branchid =
 (SELECT branchid 
from manages 
where empid = 435198
ORDER BY doj desc LIMIT 1)
);

SELECT * FROM employees_of_branch_of_435198;


-- Query 8: Return the customer ID of the customer with the max assets in the branch. 
-- SQL Query:
SELECT t.sums, t.CustomerID from (SELECT (SUM(Balance) + sum(amount)) as sums, custid as CustomerID FROM account NATURAL JOIN accountopened NATURAL JOIN fixeddeposits
GROUP BY custID) as t
ORDER BY t.sums desc LIMIT 1;


-- Query 9: Creates a user called managerUser and grants it permission to select and insert to the database.
-- SQL Query:
CREATE USER IF NOT EXISTS managerUser@localhost IDENTIFIED BY 'manager';
CREATE ROLE IF NOT EXISTS 'manager':
GRANT SELECT, INSERT ON bank.* TO 'manager';

-- Query 10: Return the customer ID, first name, last name of the customers whose first name starts with a and has balance more than 100000.
-- SQL Query: 
Select distinct c.`CustID`, p.firstName, p.lastName
From customer c, person p
where p.`FirstName` like 'A%' AND c.`AadharNo` = p.`AadharNo` and Exists(
Select c1.`CustID`from customer c1 where exists( 
					Select ac.`CustID` 
					from accountopened ac,account acc  
					where ac.`Account#`= acc.`Account#` and acc.`Balance`>100000)
);

-- Query 11: Return the average age of persons in every state.
-- SQL Query: 
SELECT AVG(DATEDIFF(CURDATE(), DOB) DIV 365.25) as Average_Age, state  
FROM person
GROUP BY state;
