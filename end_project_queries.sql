-- Updating interest rate for home loans only
-- changed column name to avoid error
UPDATE loanacc 
SET InterestRate = InterestRate + 1
WHERE Account IN (SELECT Acc
					FROM loanrequests
                    WHERE Type = "HOME")
;

-- Delete accounts who have not done any transactions in the last 10 years
-- have to see if this always deletes all loan accounts or we should add some constraint for loan account
DELETE 
FROM account
WHERE `account#` NOT IN (SELECT DISTINCT `account#`
                        FROM transactions
                        WHERE DATEDIFF(CURDATE(), datetime) < 3653
                        );


-- Combine assets of everyone in bank
-- this is wrong rn and only shows for those who have all
SELECT t.sums, t.CustomerID from (SELECT (SUM(Balance) + sum(amount)) as sums, custid as CustomerID FROM account NATURAL JOIN accountopened NATURAL JOIN fixeddeposits
GROUP BY custID) as t;

SELECT (
    SELECT sum(balance) 
    FROM account NATURAL JOIN accountopened 
    WHERE balance < 0 
    GROUP BY custid 
    HAVING custid = 981785) + 
    (
        SELECT sum(amount) 
        FROM fixeddeposits 
        GROUP BY custid 
        HAVING custid = 981785) as total_amount;


-- give bonus to those employees working in same branch more than 5 years
-- this is for selecting have to see about updating
SELECT p.firstname, p.lastname, e.empid
FROM person p NATURAL JOIN employee e
WHERE e.empid IN (SELECT empid FROM (
									SELECT max(DOJ) as latestjoining, empid
									FROM employeeworks 
									GROUP BY empid
									HAVING DATEDIFF(CURDATE(), latestjoining) > 3650) AS currworks
                                    );

-- to get latest branch of any employee
SELECT max(DOJ) as latestjoining, empid, branchid as current_branch 
FROM employeeworks 
GROUP BY empid;

-- give 1000rs to all customers below poverty line, that is, having balance less than 5000.


-- those accounts total withdrawal less than 50000
SELECT a.accountnum, sum(t.amount) as total_withdrawal
FROM account_c a, transactions t
WHERE a.accountnum = t.accountnum AND t.type = "DEBIT"
GROUP BY a.accountnum
HAVING total_withdrawal < 500000;


-- People with less than minimum balance
UPDATE account_c
SET balance = balance - 500
WHERE account_c.accountnum IN (SELECT a.accountnum
					FROM account_c a, depositoryacc d
					WHERE a.accountnum = d.accountnum AND balance < minbalance);

SELECT a.accountnum
FROM account_c a, depositoryacc d
WHERE a.accountnum = d.accountnum AND balance < minbalance


-- Could add the avg age query since it was not used in midsem