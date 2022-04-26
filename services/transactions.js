const db = require('./db');
const helper = require('../helper');

async function getTransactionsByCustomerId(customerId) {
    const rows = await db.runQuery(
      `SELECT * FROM transactions where custid = ${customerId}`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}

async function getTransactionsByAccountNumber(accountNumber) {
    const rows = await db.runQuery(
      `SELECT * FROM transactions where \`Account#\` = ${accountNumber}`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}


 

module.exports = {
    getTransactionsByCustomerId,
    getTransactionsByAccountNumber,
}