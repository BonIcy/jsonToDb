const db = require('../db/config');

const register = async (req, res) => {
  if (!req.body) {
    return res.status(400).json({
      msg: 'Data required',
    });
  }

  const { nombre, correo, contrasena, tipo_documentoId, dni } = req.body;

  try {
    const connection = await db;
    const query = 'INSERT INTO usuario (nombre, correo, contrasena, tipo_documentoId, dni) VALUES (?, ?, ?, ?, ?)';
    const results = await connection.query(query, [nombre, correo, contrasena, tipo_documentoId, dni]);

    if (results.affectedRows = 1) {
      return res.status(201).json({
        msg: 'User created successfully',
      });
    }

    return res.status(500).json({
      msg: 'Error creating user',
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      msg: 'Error in the server',
    });
  }
};

module.exports = { register };