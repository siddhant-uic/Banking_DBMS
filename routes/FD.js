const express = require("express");
const router = express.Router();
const FDs = require("../services/FD");

router.get("/", async (req, res) => {
    try {
        const FDsData = await FDs.getAllFDs();
        res.json(FDsData.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/customerId=:customerId", async (req, res) => {
    try {
        const FDByCustID = await FDs.getFDByCustID(req.params.customerId);
        res.json(FDByCustID.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/depositNo=:DepositNo", async (req, res) => {
    try {
        const FDByDepositNo = await FDs.getFDByDepositNo(req.params.DepositNo);
        res.json(FDByDepositNo.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;