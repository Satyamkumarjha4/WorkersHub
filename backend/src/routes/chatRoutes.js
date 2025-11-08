import express from "express";
import { getMessages, getUserDetailsWithConversations, sendMessage} from "../controllers/chatController.js";

const chatRouter = express.Router();

chatRouter.post("/sendmessage/:receiverId", sendMessage); // to send messages
chatRouter.get("/getmessage", getMessages);
chatRouter.get('/getAllConversation', getUserDetailsWithConversations)



export default chatRouter;
