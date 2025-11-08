import express from 'express';
import { getUserById, getUserByIdAndRole } from '../controllers/userControllers.js';
// import tokenVerify from '../middleware/tokenVerify';
const router = express.Router();



router.get("/", getUserById);
router.get("/role", getUserByIdAndRole);

export default router;