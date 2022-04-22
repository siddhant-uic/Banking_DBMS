const express = require("express");
const router = express.Router();
const person = require("../services/person");

router.get("/", async (req, res) => {
    try {
        const personData = await person.getAllPersons();
        res.json(personData.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

router.get("/:personId", async (req, res) => {
    try {
        const personById = await person.getPersonById(req.params.personId);
        res.json(personById.data);
    } catch (error) {
        console.log(error);
        res.json(error);
    }
});

module.exports = router;