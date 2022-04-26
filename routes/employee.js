const express = require("express");
const router = express.Router();
const employee = require("../services/employee");

router.get("/", async (req, res) => {
    try {
        const managerData = await employee.getAllManagers();
        res.json(managerData.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/:empID", async (req, res) => {
    try {
        const managerById = await employee.getManagersByEid(req.params.empID);
        res.json(managerById.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/login/:empId/:password", async (req, res) => {
    try {
        console.log(req.params.empId, req.params.password);
        const empLogin = await employee.loginEmployee(req.params.empId, req.params.password);
        res.json(empLogin.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});


module.exports = router;