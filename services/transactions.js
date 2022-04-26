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

async function createTransaction(customerId, accountNumber, amount, transactionType) {
    const transactionId = await db.runQuery(
        `Select transactionid from transactions`
    );
    var transactionIdNumber;
    while (transactionId.contains(transactionIdNumber)) {
        transactionIdNumber = transactionId[0].transactionid + 1;   
    }
    console.log(transactionIdNumber);
    const DateTime = new Date.now();
    const rows = await db.runQuery(
      `INSERT INTO transactions (transactionid , custid, \`Account#\`, amount, transactiontype, datetime) VALUES (${transactionIdNumber}, ${customerId}, ${accountNumber}, ${amount}, '${transactionType}, ${DateTime}')`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}
 

module.exports = {
    getTransactionsByCustomerId,
    getTransactionsByAccountNumber,
    createTransaction,
}