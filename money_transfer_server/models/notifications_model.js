const mongoose = require("mongoose");

const notificationsSchema = mongoose.Schema({
  username: {
    required: true,
    type: String,
  },
  amount: {
    type: Number,
    required: true,
  },
  trnxType: {
    type: String,
  },
  sendersName: {
    type: String,
  },
});
const Notifications = mongoose.model("Notifications", notificationsSchema);
module.exports = Notifications;
