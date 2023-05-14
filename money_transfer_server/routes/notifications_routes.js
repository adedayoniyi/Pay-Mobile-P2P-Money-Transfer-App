const express = require("express");
const Transactions = require("../models/transaction_model");
const Notifications = require("../models/notifications_model");
const auth = require("../middlewares/auth_middleware");

const notificationsRouter = express.Router();

notificationsRouter.get(
  "/api/credit-notification/:username",
  auth,
  async (req, res) => {
    try {
      const { username } = req.params;
      const notifications = await Notifications.find({ username: username });
      let showNotificationsFromRecentToLast = notifications.reverse();
      res.status(200).json(showNotificationsFromRecentToLast[0]);
    } catch (e) {
      res.status(500).json({ message: e.message });
    }
  }
);
notificationsRouter.post("/api/deleteNotification", auth, async (req, res) => {
  try {
    const { username } = req.body;
    await Notifications.deleteMany({ username });
    res.status(200).json({ message: "Deleted Successfully" });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
});
module.exports = notificationsRouter;
