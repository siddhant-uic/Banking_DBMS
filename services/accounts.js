const db = require('./db');
const helper = require('../helper');

async function getAllAccounts(){
  const rows = await db.runQuery(
    `SELECT * FROM account`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getAccountsByCustomerId(customerId){
    const rows = await db.runQuery(
      `select * from account, accountopened where account.\`Account#\` = accountopened.\`Account#\` and accountopened.CustID = 412991`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}

module.exports = {
  getAllAccounts,
  getAccountsByCustomerId
}