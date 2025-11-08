import express from "express";
import { applyToPost, createPost, getPostById } from "../controllers/postController.js";

// import tokenVerify from "../middleware/tokenVerify";
const router = express.Router();

router.post("/create", createPost);
router.post("/apply", applyToPost);
// router.get("/", getAllPosts);
router.get("/", getPostById);
// router.put("/:id", updatePost);
// router.delete("/:id", deletePost);

export default router;