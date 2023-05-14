const Transactions = require("../models/transaction_model");
const User = require("../models/user_model");

const creditAccount = async ({
  amount,
  username,
  purpose,
  reference,
  description,
  session,
  fullNameTransactionEntity,
}) => {
  const user = await User.findOne({ username });

  if (!user) {
    return {
      status: false,
      statusCode: 404,
      message: `User ${username} dosent exist`,
    };
  }

  const updatedWallet = await User.findOneAndUpdate(
    { username },
    { $inc: { balance: amount } },
    { session }
  );
  const sendersFullName = await User.findOne({
    username: fullNameTransactionEntity,
  });
  const transaction = await Transactions.create(
    [
      {
        trnxType: "Credit",
        purpose,
        amount,
        username: username,
        reference,
        balanceBefore: Number(user.balance),
        balanceAfter: Number(user.balance) + Number(amount),
        description,
        fullNameTransactionEntity: sendersFullName.fullname,
      },
    ],
    { session }
  );
  console.log(`Credit Successful`);
  return {
    status: true,
    statusCode: 201,
    message: "Credit Successful",
    data: { updatedWallet, transaction },
  };
};

const debitAccount = async ({
  amount,
  username,
  purpose,
  reference,
  description,
  session,
  fullNameTransactionEntity,
}) => {
  const user = await User.findOne({ username });

  if (!user) {
    return {
      status: false,
      statusCode: 404,
      message: `User ${username} dosent exist`,
    };
  }

  if (Number(user.balance) < amount) {
    return {
      status: false,
      statusCode: 400,
      message: `User ${username} has insufficient balance`,
    };
  }

  const updatedWallet = await User.findOneAndUpdate(
    { username },
    { $inc: { balance: -amount } },
    { session }
  );
  const recipientFullName = await User.findOne({
    username: fullNameTransactionEntity,
  });
  const transaction = await Transactions.create(
    [
      {
        trnxType: "Debit",
        purpose,
        amount,
        username: username,
        reference,
        balanceBefore: Number(user.balance),
        balanceAfter: Number(user.balance) - Number(amount),
        description,
        fullNameTransactionEntity: recipientFullName.fullname,
      },
    ],
    { session }
  );
  console.log(`Debit Successful`);
  return {
    status: true,
    statusCode: 201,
    message: "Debit Successful",
    data: { updatedWallet, transaction },
  };
};

module.exports = {
  creditAccount,
  debitAccount,
};
