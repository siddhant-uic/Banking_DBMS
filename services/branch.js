const db = require("./db");
const helper = require("../helper");

async function getLoansByBid(branchId) {
  const rows = await db.runQuery(
    `SELECT * from loanrequests l where l.status = \'P\' AND branchid = ${branchId}`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  };
}

async function rejectLoan(requestID) {
    console.log(transactionIdNumber);
    const rows = await db.runQuery(
      `UPDATE loanrequests SET status = 'F' WHERE requestid = ${requestID};`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}

async function grantLoan(requestID) {
    console.log(transactionIdNumber);
    const rows = await db.runQuery(
      `UPDATE loanrequests SET status = 'C' WHERE requestid = ${requestID};`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}

module.exports = {
    getLoansByBid,
    rejectLoan,
    grantLoan,
};
