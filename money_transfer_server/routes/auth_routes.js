const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user_model");
const auth = require("../middlewares/auth_middleware");

authRouter.post("/api/createUser", async (req, res) => {
  try {
    const { fullname, username, email, password } = req.body;
    const userExists = await User.findOne({ username });
    if (userExists) {
      return res.status(409).json({
        status: false,
        message: "User already exists",
      });
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    let user = new User({
      fullname,
      username,
      email,
      password: hashedPassword,
    });
    user = await user.save();

    // const result = await Wallets.create({ username });
    // console.log(result);
    return res.status(201).json({
      status: true,
      message: "User created successfully",
      data: user,
    });
  } catch (e) {
    return res.status(500).json({
      status: false,
      message: `Unable to create wallet. Please try again.\n Error:${e}`,
    });
  }
});

authRouter.post("/api/login", async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(409).json({
        status: false,
        message: "This user does not exist",
      });
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(409).json({
        status: false,
        message: "Incorrect password",
      });
    }
    const token = await jwt.sign({ id: user._id }, process.env.TOKEN_STRING);
    res.status(201).json({
      token,
      ...user._doc,
    });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
});

authRouter.post("/checkToken", auth, async (req, res) => {
  const token = req.header("x-auth-token");
  if (token) {
    try {
      const { id } = jwt.verify(token, process.env.TOKEN_STRING);
      const user = await User.findById(id);
      if (user) {
        return res.json(true);
      }
    } catch (e) {
      res.status(500).json({ message: e.message });
    }
  }
  return res.json(false);
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

authRouter.get("/api/getUsername/:username", auth, async (req, res) => {
  try {
    const { username } = req.params;
    const user = await User.findOne({ username });
    if (!user) {
      return res
        .status(200)
        .json({ message: `${username} username is available` });
    }
    res.status(400).json({ message: "This username has been taken" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

authRouter.get(
  "/api/getUsernameFortransfer/:username",
  auth,
  async (req, res) => {
    try {
      const { username } = req.params;
      const user = await User.findOne({ username });
      if (user) {
        return res.status(200).json({ message: user.fullname });
      }
      res
        .status(400)
        .json({ message: "Invalid username, please check and try again" });
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
);

authRouter.post("/api/createLoginPin/:username", auth, async (req, res) => {
  try {
    const { username } = req.params;
    const { pin } = req.body;

    const user = await User.findOne({ username });
    if (!user) {
      return res.status(400).json({ message: `User ${username} is not found` });
    }
    const pinEncrypt = await bcryptjs.hash(pin, 8);
    await User.findOneAndUpdate({ username }, { pin: pinEncrypt });
    res.status(200).json({ message: "Pin created successfully" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

authRouter.post("/api/loginUsingPin/:username", auth, async (req, res) => {
  try {
    const { username } = req.params;
    const { pin } = req.body;
    const user = await User.findOne({ username });
    const isPinCorrect = await bcryptjs.compare(pin, user.pin);
    if (!isPinCorrect) {
      return res.status(400).json({ message: "Incorrect Pin. Try again!" });
    }
    res.status(200).json({ message: "Login Successful" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

authRouter.post("/api/changePin/:username", auth, async (req, res) => {
  try {
    const { username } = req.params;
    const { oldPin, newPin } = req.body;
    const user = await User.findOne({ username });
    const isPinCorrect = await bcryptjs.compare(oldPin, user.pin);
    if (!isPinCorrect) {
      return res.status(400).json({ message: "Incorrect Pin. Try again!" });
    }

    const encryptNewPin = await bcryptjs.hash(newPin, 8);
    await User.findOneAndUpdate(
      { username },
      {
        pin: encryptNewPin,
      }
    );

    res.status(200).json({ message: "Pin changed successfully" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});
module.exports = authRouter;
