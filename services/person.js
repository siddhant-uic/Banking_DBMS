const db = require('./db');
const helper = require('../helper');

async function getAllPersons(){
  const rows = await db.runQuery(
    `SELECT * FROM person`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}

async function getPersonById(aadharNo){
    const rows = await db.runQuery(
      `select * from person where AadharNo = ${aadharNo}`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}

module.exports = {
  getAllPersons,
  getPersonById
}