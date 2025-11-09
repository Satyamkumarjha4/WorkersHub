import prisma from "../config/prisma.js";
import { io, getSocketId } from "../socket/socket.js";
import { containsURL,containsNumber } from "../utils/messageValidator.js";

export const sendMessage = async (req, res) => {
  try {
    const { senderId, message } = req.body;
    console.log(message);
    const receiverId = req.params.receiverId;

    if (!senderId || !receiverId || !message) {
      return res.status(400).json({
        success: false,
        message: "All fields (senderId, receiverId, message) are required",
      });
    }

    // Get sender and receiver details
    const sender = await prisma.user.findUnique({
      where: { id: senderId },
      include: { client: true, worker: true },
    });

    const receiver = await prisma.user.findUnique({
      where: { id: receiverId },
      include: { client: true, worker: true },
    });

    if (!sender || !receiver) {
      return res.status(404).json({
        success: false,
        message: "Sender or receiver not found",
      });
    }

    if (containsNumber(message) || containsURL(message)) {
      return res.status(400).json({
        success: false,
        
        message: "Messages cannot contain phone numbers or links.",
      });
    }

    // Determine roles
    let workerId, clientId;
    if (sender.role === "Worker") {
      workerId = sender.worker?.id;
      clientId = receiver.client?.id;
    } else {
      clientId = sender.client?.id;
      workerId = receiver.worker?.id;
    }
    console.log("workerId", workerId);
    // conso
    if (!workerId || !clientId) {
      return res.status(400).json({
        success: false,
        message: "Either client or worker record missing",
      });
    }

    // Find or create conversation
    let conversation = await prisma.conversation.findFirst({
      where: { workerId, clientId },
    });

    if (!conversation) {
      conversation = await prisma.conversation.create({
        data: {
          worker: { connect: { id: workerId } },
          client: { connect: { id: clientId } },
        },
      });
    }

    // Create message
    const newMessage = await prisma.message.create({
      data: {
        text: message,
        senderId,
        conversation: { connect: { id: conversation.id } },
      },
      include: { conversation: true },
    });
    io.to(getSocketId(receiverId)).emit('newMessage', message)

    return res.status(200).json({
      success: true,
      message: "Message sent successfully",
      data: newMessage,
    });
  } catch (error) {
    console.error("Error in sendMessage:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message,
    });
  }
};

export const getMessages = async (req, res) => {
  try {
    const { myId, otherId } = req.body;
    if (!myId || !otherId) {
      throw new Error("all field are required senderId and reciverId");
    }
    console.log("completed ")
    //getting sender and receiver role ;
    const myData = await prisma.user.findUnique({
      where: { id: myId },
      include: { client: true, worker: true },
    });
    console.log("completed till here ")
    const otherData = await prisma.user.findUnique({
      where: { id: otherId },
      include: { client: true, worker: true },
    });

    if (!myData || !otherData) {
      return res.status(404).json({
        success: false,
        message: "Sender or receiver not found",
      });
    }
    // asigning role 
    let workerId, clientId;
    if (myData.role === "Worker") {
      workerId = myData.worker?.id;
      clientId = otherData.client?.id;
    } else {
      clientId = myData.client?.id;
      workerId = otherData.worker?.id;
    }

    if (!workerId || !clientId) {
      throw new Error(" dono mea se koe missing hai")
    }
    // Find
    let conversation = await prisma.conversation.findFirst({
      where: { workerId, clientId },
      include: { messages: true }
    });
    if (!conversation) {
      res.status(200).json({
        success: true,
        conversation,
        message: "their is no conversation between worker and client"
      })
    }
    res.status(200).json({
      success: true,
      messages: conversation.messages
    })

  } catch (error) {
    console.log("error in fetching messages:", error)
    res.status(500).json({
      success: false,
      error: error
    })
  }
}

export const getAllConversations = async (req, res) => {
  try {
    const { userId } = req.body;
    if (!userId) {
      return res.status(500).json({
        success: false,
        message: "userId not found"
      })
    }
    const userData = await prisma.user.findFirst(userId);
    const conversationRes = {};
    if (userData.role == "client") {
      const converstationRes = await prisma.conversation.findMany({
        where: {

        }
      })
    }

  } catch (error) {
    console.log("error in get all Conversation:", error)
    res.status(200).json({

    })
  }
}
export const getUserDetailsWithConversations = async (req, res) => {
  try {
    const { userId } = req.body;
    if (!userId) {
      return res.status(400).json({ message: "User ID is required" });
    }

    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { role: true },
    });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    let conversations = [];

    // ===== If user is a Client =====
    if (user.role === "Client") {
      const client = await prisma.client.findUnique({
        where: { userId },
        include: {
          conversations: {
            include: {
              worker: true,
              messages: {
                orderBy: { createdAt: "desc" },
                take: 1,
              },
            },
            orderBy: { createdAt: "desc" },
          },
        },
      });

      conversations =
        client?.conversations?.map((conv) => ({
          id: conv.id,
          worker: {
            id: conv.worker.id,
            name: conv.worker.name,
            idForChat: conv.worker.userId,
            avatar: conv.worker.avatar,
          },
          messages: conv.messages.map((msg) => ({
            id: msg.id,
            conversationId: msg.conversationId,
            senderId: msg.senderId,
            text: msg.text,
            createdAt: msg.createdAt,
          })),
        })) || [];
    }

    // ===== If user is a Worker =====
    else if (user.role === "Worker") {
      const worker = await prisma.worker.findUnique({
        where: { userId },
        include: {
          conversations: {
            include: {
              client: true,
              messages: {
                orderBy: { createdAt: "desc" },
                take: 1,
              },
            },
            orderBy: { createdAt: "desc" },
          },
        },
      });

      conversations =
        worker?.conversations?.map((conv) => ({
          id: conv.id,
          client: {
            id: conv.client.id,
            name: conv.client.name,
            idForChat: conv.client.userId,
            avatar: conv.client.avatar,
          },
          messages: conv.messages.map((msg) => ({
            id: msg.id,
            conversationId: msg.conversationId,
            senderId: msg.senderId,
            text: msg.text,
            createdAt: msg.createdAt,
          })),
        })) || [];
    }

    res.status(200).json({
      success: true,
      conversations,
    });
  } catch (error) {
    console.error("Error fetching user conversations:", error);
    res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message,
    });
  }
};
