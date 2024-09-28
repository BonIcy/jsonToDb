const db = require('../db/config');

const getDataOne = async (req, res, table, correo) => {
  try {
    const connection = await db;
    const query = `SELECT * FROM ${table} WHERE correo = ?`;
    const [results] = await connection.query(query, [correo]);
    
    res.json(results);
  } catch (error) {
    console.log(`Error trying to get table data from ${table}:`, error);
    res.status(500).json({
      error: `Error trying to consult the db for ${table}`,
    });
  }
};

module.exports = { getDataOne };