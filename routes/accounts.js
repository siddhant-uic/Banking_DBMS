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

module.exports = router;