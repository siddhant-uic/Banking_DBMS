const express = require("express");
const router = express.Router();
const transactions = require("../services/transactions");

var bodyParser = require('body-parser'); 
var urlencodedParser = bodyParser.urlencoded({ extended: false })  

router.get("/:customerId", async (req, res) => {
    try {
        const transactionsByCustomerId = await transactions.getTransactionsByCustomerId(req.params.customerId);
        res.json(transactionsByCustomerId.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/:accountNumber", async (req, res) => {
    try {
        const transactionsByAccountNumber = await transactions.getTransactionsByAccountNumber(req.params.accountNumber);
        res.json(transactionsByAccountNumber.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;