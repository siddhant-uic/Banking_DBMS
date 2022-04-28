const db = require('./db');
const helper = require('../helper');

async function getAllCustomers() {
  const rows = await db.runQuery(
    `SELECT * FROM customer`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}
async function getCustomerById(customerId) {
  const rows = await db.runQuery(
    `select * from customer where CustID = ${customerId}`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function loginCustomer(customerId, password) {
  const rows = await db.runQuery(
    `select * from customer where CustID = ${customerId}`
  );
  const data = helper.emptyOrRows(rows);
  if (data.length === 0) {
    return {
      data: "Customer not found",
    }
  }
  if (data[0].Password === password) {
    return {
      data,
    }
  } else {
    return {
      data: "Login Failed",
    }
  }
}

async function getTotalsByCustId(customerId) {
  const rows = await db.runQuery(
    `SELECT (SELECT sum(balance) FROM account NATURAL JOIN accountopened WHERE balance > 0 GROUP BY custid HAVING custid = ${customerId}) + (SELECT sum(amount) FROM fixeddeposits GROUP BY custid HAVING custid = ${customerId}) as assets, (SELECT sum(balance) FROM account NATURAL JOIN accountopened WHERE balance < 0 GROUP BY custid HAVING custid = ${customerId}) as liabilities;`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function requestLoan(customerId, durationMonths, amount, loanType, branchId) {
  const reqId = await db.runQuery(
    `Select requestId from loanrequests order by requestid`
  );
  var reqIdNumber = reqId[reqId.length - 1].requestId + 1;

  const loanacc = await db.runQuery(
    `Select \`Account#\` as account from loanacc order by \`Account#\``
  );
  var loanaccNum = loanacc[loanacc.length - 1].account + 1;

  const DateTime = new Date();
  var date = DateTime.toISOString().split('T')[0];

  const repaymentDate = new Date(DateTime.setMonth(DateTime.getMonth() + durationMonths));
  const interestRate = Math.floor(Math.random() * (10 - 5 + 1)) + 5;
  const rows4 = await db.runQuery(
    `INSERT INTO account
    (\`Account#\`, balance) VALUES
    (${loanaccNum}, ${0 - amount})`
  );
  const rows3 = await db.runQuery(
    `INSERT INTO accountopened
    (custid, \`Account#\`, branchid, dateofopening) VALUES
    (${customerId}, ${loanaccNum}, ${branchId}, "${date}")`
  );
  const rows = await db.runQuery(
    `INSERT INTO loanrequests 
    (requestID, durationmonths, amount, type, custid, dateofopening, \`Acc#\`, status, branchId) VALUES 
    (${reqIdNumber}, ${durationMonths}, ${amount}, "${loanType}", "${customerId}", "${date}", "${loanaccNum}", "P", "${branchId}")`
  );
  const data = helper.emptyOrRows(rows);
  const rows2 = await db.runQuery(
    `INSERT INTO loanacc
    (\`Account#\`, repaymentdate, interestrate) VALUES
    (${loanaccNum}, "${repaymentDate.toISOString().split('T')[0]}", ${interestRate})`
  );

  const data2 = helper.emptyOrRows(rows2);
  return {
    data,
  }
}

module.exports = {
  getAllCustomers,
  getCustomerById,
  loginCustomer,
  getTotalsByCustId,
  requestLoan,
}