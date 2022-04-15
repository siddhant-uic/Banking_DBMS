const db = require('./db');
const helper = require('../helper');

async function getAllCustomers(){
  const rows = await db.runQuery(
    `SELECT * FROM customer`
  );
  const data = helper.emptyOrRows(rows);

  return {
    data,
  }
}
async function getCustomerById(customerId){
    const rows = await db.runQuery(
      `select * from customer where CustID = ${customerId}`
    );
    const data = helper.emptyOrRows(rows);

    return {
        data,
    }
}

module.exports = {
  getAllCustomers,
  getCustomerById
}