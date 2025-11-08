import express from "express";
import { createAndUpdateForm, getFormByWorkerEmail } from "../controllers/formController.js";

const router = express.Router();

router.patch("/", createAndUpdateForm);
router.get("/", getFormByWorkerEmail);

export default router;
