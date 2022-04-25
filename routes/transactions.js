const express = require("express");
const router = express.Router();
const transactions = require("../services/transactions");

router.get("/:customerId", async (req, res) => {
    try {
        const transactionsByCustomerId = await transactions.getTransactionsByCustomerId(req.params.customerId);
        res.json(transactionsByCustomerId.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;