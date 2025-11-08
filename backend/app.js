import { app, server } from "./src/socket/socket.js";
import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import userRoutes from "./src/routes/userRoutes.js";
import loginRoutes from "./src/routes/loginRoutes.js";
import registerRoutes from "./src/routes/registerRoutes.js";
import chatRouter from "./src/routes/chatRoutes.js";
import formRoutes from "./src/routes/formRoutes.js";
import postRoutes from "./src/routes/postRoutes.js";
import workerRouter from "./src/routes/workerRoute.js";

dotenv.config();

app.use(cors());
app.use(express.json());

app.use("/api/user", userRoutes);
app.use("/api/login", loginRoutes);
app.use("/api/register", registerRoutes);
app.use("/api/conversation", chatRouter);
app.use("/api/provider/form", formRoutes);
app.use("/api/post", postRoutes);
app.use('/api/worker',workerRouter)

const PORT = process.env.PORT || 5000;

app.get("/", (req, res) => {
  res.send("WorkersHub Backend is running");
});

app.get("/api", (req, res) => {
  res.send("Mast chal reh api");
});

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
