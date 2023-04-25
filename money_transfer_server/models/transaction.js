const mongoose = require("mongoose");

const transactionSchema = new mongoose.Schema(
  {
    trnxType: {
      type: String,
      required: true,
      enum: ["Credit", "Debit"],
    },
    purpose: {
      type: String,
      enum: ["deposit", "transfer", "reversal", "withdrawal"],
      required: true,
    },
    amount: {
      type: Number,
      required: true,
      default: 0.0,
    },
    username: {
      type: String,
      ref: "User",
    },
    reference: {
      type: String,
      required: true,
    },
    balanceBefore: {
      type: Number,
      required: true,
    },
    balanceAfter: {
      type: Number,
      required: true,
    },

    summary: {
      type: String,
      required: true,
    },
    trnxSummary: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

const Transactions = mongoose.model("Transactions", transactionSchema);
module.exports = Transactions;
