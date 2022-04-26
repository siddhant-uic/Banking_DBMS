const db = require('./db');
const helper = require('../helper');

async function getAllManagers() {
  const rows = await db.runQuery(
    `SELECT m1.*
    FROM employeeworks e1
      LEFT OUTER JOIN employeeworks e2
        ON (e1.branchid = e2.branchid AND e1.doj < e2.doj)
    WHERE e2.branchid IS NULL`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function loginEmployee(empId, password) {
  const rows = await db.runQuery(
    `select * from employee where empId = ${empId}`
  );
  const data = helper.emptyOrRows(rows);
  if (data.length === 0) {
    return {
      data: "Employee not found",
    }
  }
  if (data[0].password === password) {
    return {
      data,
    }
  } else {
    return {
      data: "Login Failed",
    }
  }
}

async function getManagersByEid(eid) {
    const rows = await db.runQuery(
      `SELECT m1.*
      FROM manages m1
        LEFT OUTER JOIN manages m2
          ON (m1.branchid = m2.branchid AND m1.doj < m2.doj)
      WHERE m2.branchid IS NULL AND m1.empid = ${eid}`
    );
    const data = helper.emptyOrRows(rows);
  
    return {
      data,
    }
}








module.exports = {
    loginEmployee,
    getAllManagers,
    getManagersByEid,
}