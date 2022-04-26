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

module.exports = {
    getLoansByBid,
};
