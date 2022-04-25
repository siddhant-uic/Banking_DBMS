const db = require('./db');
const helper = require('../helper');
const router = require('../routes/accounts');

async function getAllAccounts() {
  const rows = await db.runQuery(
    `SELECT * FROM account`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getAccountsByCustomerId(customerId) {
  const rows = await db.runQuery(
    `select * from account, accountopened where account.\`Account#\` = accountopened.\`Account#\` and accountopened.CustID = ${customerId}`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getAccountDetailsByAccountNumber(accountNumber) {
  const rows = await db.runQuery(
    `select * from depositoryacc where \`Account#\` = ${accountNumber}`
  );
  // console.log(rows);
  if (rows.length === 0) {
    // console.log('no rows');
    const loanrows = await db.runQuery(
      `select * from loanacc where \`Account#\` = ${accountNumber}`
    );

    const data = helper.emptyOrRows(loanrows);

    return {
      data,
    }
  }
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getDebitCardByNumber(debitcardNumber) {
  const rows = await db.runQuery(
    `select * from cards where CardNo = ${debitcardNumber}`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

module.exports = {
  getAllAccounts,
  getAccountsByCustomerId,
  getAccountDetailsByAccountNumber,
  getDebitCardByNumber,
}