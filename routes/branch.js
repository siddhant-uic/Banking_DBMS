const express = require("express");
const router = express.Router();
const branch = require("../services/branch");

router.get("/loans/:branchId", async (req, res) => {
    try {
        const branchData = await branch.getLoansByBid(req.params.branchId);
        res.json(branchData.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;