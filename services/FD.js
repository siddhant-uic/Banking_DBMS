const db = require('./db');
const helper = require('../helper');

async function getAllFDs() {
  const rows = await db.runQuery(
    `SELECT * FROM fixeddeposits`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getFDByCustID(CustID) {
  const rows = await db.runQuery(
    `select * from fixeddeposits where CustID = ${CustID}`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getFDByDepositNo(DepositNo) {
    const rows = await db.runQuery(
        `select * from fixeddeposits where DepositNo = ${DepositNo}`
    );
    const data = helper.emptyOrRows(rows);
    
    return {
        data,
    }
}

module.exports = {
    getAllFDs,
    getFDByCustID,
    getFDByDepositNo,
}