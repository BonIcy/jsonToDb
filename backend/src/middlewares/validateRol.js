const jwt = require('jsonwebtoken');

const validateRoles = async (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token) {
    return res.status(401).json({
      error: 'invalid token',
    });
  }

  const decodedToken = await jwt.verify(token, process.env.JWT256);
  const rolId = decodedToken.rolId;

  if (rolId != 2 && rolId != 3) {
    return res.status(403).json({
      error: 'user does not have permission to do this',
    });
  }

  next();
};


module.exports = validateRoles;