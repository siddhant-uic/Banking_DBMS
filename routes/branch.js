const express = require("express");
const router = express.Router();
const branch = require("../services/branch");
var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({
    extended: false
})

router.get("/loans/:branchId", async (req, res) => {
    try {
        const branchData = await branch.getLoansByBid(req.params.branchId);
        res.json(branchData.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/fixedDeposit/:branchId", async (req, res) => {
    try {
        const branchData = await branch.getFixedDepositByBid(req.params.branchId);
        res.json(branchData.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.post("/reject", urlencodedParser, async (req, res) => {
    try {
        const rejectLoan = await branch.rejectLoan(req.body.requestId);
        res.json(rejectLoan.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.post("/approve", urlencodedParser, async (req, res) => {
    try {
        const grantLoan = await branch.approveLoan(req.body.requestId);
        res.json(grantLoan.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/all", async (req, res) => {
    try {
        const allBranches = await branch.getAllBranches();
        res.json(allBranches.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;