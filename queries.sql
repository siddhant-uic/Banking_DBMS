-- Query 1 those who depository account but no loans
SELECT CustID
FROM accountopened
WHERE custid NOT IN (SELECT DISTINCT custid FROM `loanrequests`)
							
-- Query 2
select AadharNo from person where age >30 and gender="M"

-- query 3 customers with both fixed deposit and credit card
SELECT p.firstname, p.lastname , c.custid
FROM person as p, customer as c, fixeddeposits as f, creditcardrequests as r
WHERE p.`AadharNo`= c.`AadharNo`AND c.`CustID`= f.`CustId`AND c.`CustID`= r.`CustId`;

-- Query 4 customers with more than 2 transactions
SELECT DISTINCT p.firstname, p.lastname, c.custid
FROM person as p, customer as c
WHERE c.custid in (
SELECT custid 
From transactions
GROUP BY custid
HAVING count(*) = 1
) and p.aadharno = c.aadharno;

-- Query 5 exactly one debit and one credit
SELECT p.firstname, p.lastname, cus.custid
FROM person p, customer cus, cards c
WHERE cus.custid NOT IN (SELECT )

-- Select those users who are from the city where they work
SELECT firstname, lastname, empid
FROM person NATURAL JOIN employee
WBERE empid IN (SELECT empid
				FROM person p NATURAL JOIN employee e NATURAL JOIN employeeworks w NATURAL JOIN branch b
				WHERE b.city = p.city)


Mumbai	Delhi	Bangalore	Hyderabad	Ahmedabad	Chennai,	Kolkata