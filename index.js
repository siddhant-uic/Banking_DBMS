const express = require("express");
const app = express();
const cors = require('cors')
const port = 3000;
const customersRouter = require("./routes/customers");
const accountsRouter = require("./routes/accounts");
const personRouter = require("./routes/person");
const FDsRouter = require("./routes/FD");
const transactionsRouter = require("./routes/transactions");
const employeeRouter = require("./routes/employee");
const branchRouter = require("./routes/branch");

app.use(express.json());
app.use(cors());
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
app.use("/FD", FDsRouter);
app.use("/transactions", transactionsRouter);
app.use("/employee", employeeRouter);
app.use("/branch", branchRouter);

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});