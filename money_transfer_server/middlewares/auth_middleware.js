const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  const token = req.header("x-auth-token");
  if (token) {
    try {
      const verified = jwt.verify(token, process.env.TOKEN_STRING);
      req.user = verified.id;
      req.token = token;
      next();
    } catch (errs) {
      res.status(401).json({ message: "Token not veified,access denied" });
    }
  } else {
    res.status(401).json({ message: "No auth token, access denied" });
  }
};

module.exports = auth;
