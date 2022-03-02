-- Query 1 those who depository account but no loans
SELECT CustID
FROM accountopened
WHERE custid NOT IN (SELECT DISTINCT custid 
							FROM `loanrequests`)
							
-- Query 2
select pid from person where age >30 and gender="M"

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
HAVING count(*) > 2
) and p.aadharno = c.aadharno;

-- Query 5 exactly one debit and one credit
SELECT p.firstname, p.lastname, cus.custid
FROM person p, customer cus, cards c
WHERE cus.custid NOT IN (SELECT )