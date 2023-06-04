import { createPool } from "mysql2/promise";
import {  DB_DATABASE_1, DB_DATABASE_2, DB_HOST, DB_PASSWORD, DB_PORT, DB_USER } from "./config.js";


export const pool_ej1 = createPool({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  port: DB_PORT,
  database: DB_DATABASE_1,
});
export const pool_ej2 = createPool({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  port: DB_PORT,
  database: DB_DATABASE_2,
});