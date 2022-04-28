const express = require("express");
const router = express.Router();
const customers = require("../services/customers");

var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({
    extended: false
})

router.get("/", async (req, res) => {
    // console.log(req);
    try {
        const customersData = await customers.getAllCustomers();
        res.json(customersData.data);
        // await customers.getAllCustomers();
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});
router.get("/:customerId", async (req, res) => {
    try {
        const customerById = await customers.getCustomerById(req.params.customerId);
        res.json(customerById.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});
router.get("/login/:customerId/:password", async (req, res) => {
    try {
        console.log(req.params.customerId, req.params.password);
        const customerLogin = await customers.loginCustomer(req.params.customerId, req.params.password);
        res.json(customerLogin.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/totals/:customerId", async (req, res) => {
    try {
        const totalById = await customers.getTotalsByCustId(req.params.customerId);
        res.json(totalById.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.post("/requestLoan", urlencodedParser, async (req, res) => {
    try {
        const requestLoan = await customers.requestLoan(req.body.customerId, req.body.durationMonths, req.body.amount, req.body.loanType, req.body.branchId);
        res.json(requestLoan.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});


module.exports = router;