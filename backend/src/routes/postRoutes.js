import express from "express";
import {
  applyToPost,
  applyToPostHandler,
  createPost,
  getAllPost,
  getAllPostsOfClient,
  getPostById,
} from "../controllers/postController.js";

// import tokenVerify from "../middleware/tokenVerify";
const router = express.Router();

router.post("/create", createPost); //create Post
router.post("/apply", applyToPost); //apply to post
router.get("/getAllPosts", getAllPost); //get all posts
router.get("/getAllPostById", getPostById); //get post by id

router.get("/getAllPostsOfClient", getAllPostsOfClient); //get all posts of a client
router.post("/postProposal", applyToPostHandler);

// router.get("/", getPostById);
// router.put("/:id", updatePost);
// router.delete("/:id", deletePost);

export default router;
