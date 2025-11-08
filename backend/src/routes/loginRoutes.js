import express from "express";
import { loginUser, loginUserWithGoogle } from "../controllers/loginControllers.js";
// import tokenVerify from "../middleware/tokenVerify";
const router = express.Router();

router.post("/", loginUser);
router.post("/auth/google", loginUserWithGoogle);

export default router;
