const express = require("express");
const app = express();
const port = 3000;
const customersRouter = require("./routes/customers");
const accountsRouter = require("./routes/accounts");
const personRouter = require("./routes/person");

app.use(express.json());
app.use(
    express.urlencoded({
        extended: true,
    })
);

app.get("/", (req, res) => {
    res.json({
        message: "ok"
    });
});

app.use("/customers", customersRouter);
app.use("/accounts", accountsRouter);
app.use("/person", personRouter);

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});