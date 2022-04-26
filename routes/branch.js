const express = require("express");
const router = express.Router();
const branch = require("../services/branch");
var bodyParser = require('body-parser'); 
var urlencodedParser = bodyParser.urlencoded({ extended: false })  

router.get("/loans/:branchId", async (req, res) => {
    try {
        const branchData = await branch.getLoansByBid(req.params.branchId);
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

router.post("/grant", urlencodedParser, async (req, res) => {
    try {
        const grantLoan = await branch.grantLoan(req.body.requestId);
        res.json(grantLoan.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;