import prisma from "../config/prisma.js";
import bcrypt from "bcrypt";

export const registerUser = async (req, res) => {
  try {
    const { role } = req.query;
    const { name, email, password } = req.body;
    console.log("Registering user with data:", req.body, "and role:", role);

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    console.log("Hashed Password:", hashedPassword);

    const user = await prisma.user.create({
      data: {
        role,
        email,
        password: hashedPassword,
      },
    });

    let profile;

    if (role === "Worker") {
      profile = await prisma.worker.create({
        data: {
          name,
          userId: user.id,
        },
      });
    } else if (role === "Client") {
      profile = await prisma.client.create({
        data: {
          name,
          userId: user.id,
        },
      });
    }

    return res.status(201).json({
      message: `${role} registered successfully`,
      user: { ...user, profile },
    });
  } catch (error) {
    console.error("Error registering user:", error);
    return res.status(500).json({ message: "Something went wrong", error });
  }
};
