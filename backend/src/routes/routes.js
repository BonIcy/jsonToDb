const express = require('express');
const router = express.Router();
const {limiter} = require('../middlewares/limiter');
const { getData } = require('../controllers/get');
const { getDataOne } = require('../controllers/getOne');
const { deleteData } = require('../controllers/del');
const { postData } = require('../controllers/add');
const { updateData } = require('../controllers/upd.js');
const {login} = require('../controllers/login');
const {register} = require('../controllers/register');
const validateJwt = require('../middlewares/validateJWT');
const validateRoles = require('../middlewares/validateRol');
const db = require('../db/config');

router.get('/test', (req, res)=>{
    console.log('working');
})


router.post('/login/user', login);
router.post('/register/user', register);

router.get('/getOne/:correo', async (req, res) => {
  const { correo } = req.params;
  const results = await getDataOne(req, res, 'usuario', correo);
  res.json(results);
});


module.exports = router;

router.get('/:table', validateJwt, limiter, (req, res) => {
  const { table } = req.params;
  getData(req, res, table);
});

router.post('/:table', validateJwt, limiter, (req, res) => {
    const { table,  } = req.params;
    const data = req.body;
postData(req, res, table, data)
});

router.put('/:table/:id',validateJwt, limiter, (req, res) =>{
    const {table, id} = req.params
    const data = req.body;
    updateData(req,res, table, id, data)
});

router.delete('/:table/:id', validateJwt, limiter, (req, res) => {
  const { table, id } = req.params;
  deleteData(req, res, table, id);
});


// searcher for productss
router.get('/producto/search/:nombre', validateJwt, limiter, async (req, res) => {
    const { nombre } = req.params;
    try {
      const connection = await db;
      const query = `SELECT * FROM producto WHERE nombre LIKE '%${nombre}%'`;
      const results = await connection.query(query);
  
      res.json(results);
    } catch (error) {
      console.log(`Error trying to search for products with the name ${nombre}:`, error);
      res.status(500).json({
        error: `Error trying to search for products with the name ${nombre}`,
      });
    }
  });
  



module.exports = router
