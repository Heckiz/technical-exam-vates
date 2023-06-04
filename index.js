import express from "express";
import { PORT } from "./config.js";
import ejercicio_1_route from './routes/ejercicio_1.route.js'
import ejercicio_2_route from './routes/ejercicio_2.route.js'

import morgan from 'morgan'

const app = express();
app.use(express.json());
app.use(morgan("dev"));
app.listen(PORT, () => {
    console.log(`Servidor en ejecución en el puerto ${PORT}`);
  });

// Routes
app.use("/ejercicio_1", ejercicio_1_route);
app.use("/ejercicio_2", ejercicio_2_route);