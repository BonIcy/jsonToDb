const db = require('../db/config');
const generateJWT = require('../helpers/generateJWT');

const login = async (req, res) => {
  if (!req.body) {
    return res.status(400).json({
      msg: 'Data required',
    });
  }

  const { contrasena } = req.body;

  try {
    const connection = await db;
    const query = 'SELECT correo, contrasena, rolId FROM usuario WHERE contrasena = ?';
    const results = await connection.query(query, [contrasena]);

    if (results.length === 0) {
      return res.status(400).json({
        msg: 'User with this email address cant be found',
      });
    }

    const user = results[0];
    const token = await generateJWT(user.correo, user.rolId);
    res.json({
      msg: 'Login successufully',
      token,
      userEmail: user.correo,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      msg: 'Error  in the server',
    });
  }
};

module.exports = { login };