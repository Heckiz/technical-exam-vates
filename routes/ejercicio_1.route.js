import { Router } from "express";
import { pool_ej1 } from "../db.js";
import path from 'path'

const router = Router();


router.get("/", function (req, res) {
  const filePath = path.resolve(".", "client", "ejercicio_1.html");
  res.sendFile(filePath);
});
router.post("/", async (req, res) => {
    const {dni_est, id_curso} = req.body;

    try {
      const [rows] = await pool_ej1.query('call inscripcion(?, ?)', [dni_est, id_curso]);
      res.json(rows);
    } catch (error) {
      return res.status(500).json(error);
    }
  });


  export default router;