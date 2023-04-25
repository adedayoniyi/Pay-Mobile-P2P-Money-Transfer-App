const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(401).json({ message: "No auth token, access denied" });
    }
    const verified = jwt.verify(token, process.env.TOKEN_STRING);
    if (!verified) {
      return res
        .status(401)
        .json({ message: "Token not veified,access denied" });
    }
    req.user = verified.id;
    req.token = token;
    next();
  } catch (errs) {
    res.status(500).json({ message: errs.message });
  }
};

module.exports = auth;
