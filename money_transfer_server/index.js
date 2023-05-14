const express = require("express");
const dotenv = require("dotenv");
const mongoose = require("mongoose");
dotenv.config();
const authRouter = require("./routes/auth_routes");
const balanceRouter = require("./routes/balance_routes");
const transactionRouter = require("./routes/transactions_route");
const notificationsRouter = require("./routes/notifications_routes");

const app = express();
app.use(express.json());
app.use(authRouter);
app.use(transactionRouter);
app.use(balanceRouter);
app.use(notificationsRouter);

mongoose
  .connect(process.env.DATABASE_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Successfully connected to MongoDB!");
  })
  .catch((e) => {
    console.log("Unable to connect to MongoDB");
  });

const PORT = process.env.PORT || 4000;

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server listening on port ${PORT}`);
});
