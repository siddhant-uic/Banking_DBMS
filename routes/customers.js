const express = require("express");
const router = express.Router();
const customers = require("../services/customers");

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

router.get("/assets/:customerId", async (req, res) => {
    try {
        const customerById = await customers.getAssetsByCustId(req.params.customerId);
        res.json(customerById.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/liabilities/:customerId", async (req, res) => {
    try {
        const customerById = await customers.getLiabilitiesByCustId(req.params.customerId);
        res.json(customerById.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});


module.exports = router;