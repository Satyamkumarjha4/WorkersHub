import prisma from "../config/prisma.js";
import bcrypt from "bcrypt";

export const loginUserWithGoogle = async (req, res) => {
  try {
    const { email } = req.body;
    console.log("Logging in user with Google, email:", email);

    const existingUser = await prisma.user.findUnique({
      where: { email },
      include: {
        client: true,
        worker: {
          include: { form: true },
        },
      },
    });
    console.log(existingUser);
    if (!existingUser) {
      return res.status(400).json({ message: "User does not exist" });
    }
    if (existingUser.role=="Client"){
      const clientData={}
      clientData.id= existingUser.client?.id;
      clientData.name=existingUser.client?.name;
      clientData.role= existingUser.role;
      clientData.avatar=existingUser.client?.avatar;
      return res.status(200).json({
        success:true,
        message:"client login successfully",
        userData:clientData
      })
    }
    else {
      const workerData={};
      workerData.id= existingUser.worker?.id;
      workerData.name= existingUser.worker?.name;
      workerData.role= existingUser.role;
      workerData.avatar= existingUser.worker?.avatar;
      return res.status(200).json({
        success:true,
        message:"worker login successfully",
        userData:workerData,
      })
    }
    return res
      .status(500)
      .json({ message: "Login unsuccessful", });
  } catch (error) {
    console.error("Error logging in user with Google:", error);
    return res.status(500).json({ message: "Something went wrong", error });
  }
};
