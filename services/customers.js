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

async function getAssetsByCustId(customerId) {
  const rows = await db.runQuery(
    `SELECT (SELECT sum(balance) FROM account NATURAL JOIN accountopened WHERE balance > 0 GROUP BY custid HAVING custid = ${customerId}) + (SELECT sum(amount) FROM fixeddeposits GROUP BY custid HAVING custid = ${customerId}) as total_amount`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getLiabilitiesByCustId(customerId) {
  const rows = await db.runQuery(
    `SELECT sum(balance) as liabilities FROM account NATURAL JOIN accountopened WHERE balance > 0 GROUP BY custid HAVING custid = ${customerId}`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

module.exports = {
  getAllCustomers,
  getCustomerById,
  loginCustomer,
  getAssetsByCustId,
  getLiabilitiesByCustId,
}