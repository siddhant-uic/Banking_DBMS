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
        `Select transactionid from transactions order by transactionid`
    );
    var transactionIdNumber = transactionId[transactionId.length - 1].transactionid + 1;

    console.log(transactionIdNumber);
    const DateTime = new Date();
    var date = DateTime.toISOString().split('T')[0];
    // console.log(date);
    const rows = await db.runQuery(
        `INSERT INTO transactions (transactionid , custid, \`Account#\`, amount, type, datetime, status) VALUES (${transactionIdNumber}, ${customerId}, ${accountNumber}, ${amount}, "${transactionType}", "${date}", "P")`
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