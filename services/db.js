const mysql = require('mysql');
const config = require('../config');


async function runQuery(sql) {
    const connection = mysql.createConnection(config.db);
    // connection.connect();
    // console.log(connection);
    // const [results,];
    return new Promise((resolve, reject) => {
        connection.query(sql, (err, results) => {
            if (err) {
                reject(err);
            } else {
                resolve(results);
            }
        });
    });


}

module.exports = {
    runQuery,
};