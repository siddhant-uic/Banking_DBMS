const express = require("express");
const router = express.Router();
const accounts = require("../services/accounts");

router.get("/", async (req, res) => {
    try {
        const allAccounts = await accounts.getAllAccounts();
        res.json(allAccounts.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/:customerId", async (req, res) => {
    try {
        const accountsByCustomerId = await accounts.getAccountsByCustomerId(req.params.customerId);
        res.json(accountsByCustomerId.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/details/:accountNumber", async (req, res) => {
    try {
        const accountDetailsByAccountNumber = await accounts.getAccountDetailsByAccountNumber(req.params.accountNumber);
        res.json(accountDetailsByAccountNumber.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/debitcard/:debitcardNumber", async (req, res) => {
    try {
        const debitCardByNumber = await accounts.getDebitCardByNumber(req.params.debitcardNumber);
        res.json(debitCardByNumber.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;