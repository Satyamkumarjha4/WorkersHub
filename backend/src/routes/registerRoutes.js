import express from 'express';
// import tokenVerify from '../middleware/tokenVerify';
const router = express.Router();
import { registerUser, registerUserWithGoogle } from "../controllers/registerControllers.js";


router.post("/", registerUser);
router.post("/auth/google", registerUserWithGoogle);


export default router;