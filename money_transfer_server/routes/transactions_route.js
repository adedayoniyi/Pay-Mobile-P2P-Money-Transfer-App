const express = require("express");
const transactionRouter = express.Router();
const mongoose = require("mongoose");
const { v4 } = require("uuid");
const Transactions = require("../models/transaction_model");
const { creditAccount, debitAccount } = require("../utils/transactions");
const User = require("../models/user_model");
const auth = require("../middlewares/auth_middleware");
const Notifications = require("../models/notifications_model");

transactionRouter.post("/api/transactions/transfer", auth, async (req, res) => {
  const session = await mongoose.startSession();
  session.startTransaction();
  try {
    // Get the request body data
    const { recipientsUsername, sendersUsername, amount, description } =
      req.body;
    // Generate a reference number
    const reference = v4();
    if (!recipientsUsername || !sendersUsername || !amount || !description) {
      await session.endSession();
      return res.status(409).json({
        message: `Please provide the following details: ${recipientsUsername},${sendersUsername}, ${amount}, ${description}`,
      });
    }
    const transferResult = await Promise.all([
      debitAccount({
        amount,
        username: sendersUsername,
        purpose: "Transfer",
        reference,
        description,
        session,
        fullNameTransactionEntity: recipientsUsername,
      }),
      creditAccount({
        amount,
        username: recipientsUsername,
        purpose: "Transfer",
        reference,
        description,
        session,
        fullNameTransactionEntity: sendersUsername,
      }),
    ]);

    // Filter out any failed operations
    const failedTxns = transferResult.filter(
      (result) => result.status !== true
    );
    if (failedTxns.length) {
      const errors = failedTxns.map((a) => a.message);
      await session.abortTransaction();
      await session.endSession();
      return res.status(409).json({
        message: errors,
      });
    }

    // If everything is successful, commit the transaction and end the session
    await session.commitTransaction();
    await session.endSession();

    // Find the latest transaction for the recipient and create a notification for it
    const transactions = await Transactions.find({
      username: recipientsUsername,
      trnxType: "Credit",
    })
      .sort({ createdAt: -1 })
      .limit(1);

    let notifications = await Notifications.create({
      username: transactions[0].username,
      trnxType: transactions[0].trnxType,
      amount: transactions[0].amount,
      sendersName: transactions[0].fullNameTransactionEntity,
    });
    notifications = await notifications.save();

    return res.status(201).json({
      message: "Transfer successful",
      transferResult,
    });
  } catch (err) {
    // If there is any error, abort the transaction, end the session and send an error response
    await session.abortTransaction();
    await session.endSession();

    return res.status(500).json({
      message: `Unable to perform transfer. Please try again. \n Error:${err}`,
    });
  }
});

transactionRouter.get(
  "/api/getTransactions/:username",
  auth,
  async (req, res) => {
    try {
      const { username } = req.params;
      const userTransactions = await Transactions.find({
        $or: [{ username: username }, { username: username }],
      });
      let showTransactionsFromRecentToLast = userTransactions.reverse();
      res.status(200).json(showTransactionsFromRecentToLast);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
);

transactionRouter.post("/api/fundWallet/:username", auth, async (req, res) => {
  try {
    const { username } = req.params;
    /*please note if this will be used with the flutter app,
    only integers are allowed, no decimals allowed or an error will be thrown*/
    const { amount } = req.body;
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(400).json({ mesage: "User not found!!" });
    }
    if (amount > 5000) {
      return res
        .status(400)
        .json({ message: "The maximum amount that can be funded is 5000" });
    }
    await User.findOneAndUpdate(
      { username },
      { balance: user.balance + amount }
    );
    res.status(200).json({ message: "Account funded successfully" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = transactionRouter;
