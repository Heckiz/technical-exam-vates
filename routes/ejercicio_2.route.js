import { Router } from "express";
import { pool_ej2 } from "../db.js";
import  fs from 'fs';
import path from 'path'

// Leo archivo SQL donde guardo las consultas
function readSqlFile(filePath) {
  const fileContent = fs.readFileSync(filePath, 'utf-8');
// Dividir el contenido en líneas
const lines = fileContent.split('\n');
// Filtrar líneas que no sean comentarios
const queryLines = lines.filter(line => !line.trim().startsWith('--')); // Se queda con las lineas que NO inicien con "--"(start coment in sql)
// Unir las líneas restantes para formar las consultas
const queries = queryLines.join('\n')
  .split(';')
  .map(query => query.trim())
  .filter(query => query !== '');
  return queries;
}
const filePath = './sql/ejercicio_2/queries.sql';
const queries = readSqlFile(filePath);

const router = Router();


router.get("/", function (req, res) {
  const filePath = path.resolve(".", "client", "ejercicio_2.html");
  res.sendFile(filePath);
});

// RESULTADO DE LOS EJERCICIOS 
router.get("/api/result", async (req, res) => {
  try { 
    const result = [];
    // Recorro la lista de queries
    for (let i = 0; i < queries.length; i++) {
      // Realizo la consulta 
      const [rows] = await pool_ej2.query(queries[i] + ';');
      // Separo los subejercicios del punto 8 y voy guardando las respuestas de los ejercicios en result
      if (i >= 7 && i < 11) {
        result.push({
          ejercicio: "8." + (i - 6),
          query: queries[i] + ";",
          result: rows
        });
      } else {
        result.push({
          ejercicio: i ==11 ? 9 : i + 1,
          query: queries[i] + ";",
          result: rows
        });

      }
    }
  res.json(result);

  } catch (error) {
    return res.status(500).json(error);
  }
});

// Función genérica para las consultas GET de cada tabla
const getTableData = async (table, res) => {
  try {
    const [rows] = await pool_ej2.query(`SELECT * FROM ${table}`);
    res.json(rows);
  } catch (error) {
    return res.status(500).json(error);
  }
};

// Consultas GET de cada tabla
router.get("/api/owners", async (req, res) => {
  await getTableData("dueño", res);
});

router.get("/api/casas", async (req, res) => {
  await getTableData("casa", res);
});

router.get("/api/inquilinos", async (req, res) => {
  await getTableData("inquilino", res);
});

router.get("/api/contratos", async (req, res) => {
  await getTableData("contrato", res);
});

  export default router;