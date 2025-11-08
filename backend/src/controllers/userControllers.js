import prisma from "../config/prisma.js";

export const getUserById = async (req, res) => {
  try {
    const { userId } = req.query;
    console.log("Fetching user with ID:", userId);
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        email: true,
        role: true,
        client: true,
        worker: true,
        createdAt: true,
        updatedAt: true,
      },
    });
    res.status(200).json({ user });
  } catch (error) {
    console.error("Error fetching user by ID:", error);
    return res.status(500).json({ message: "Something went wrong", error });
  }
};

export const getUserByIdAndRole = async (req, res) => {
  try {
    const { userId, role } = req.query;
    console.log("Fetching user with ID:", userId);
    const user = await prisma.user.findUnique({
      where: { id: userId, role: role },
      select: {
        id: true,
        email: true,
        role: true,
        client: true,
        worker: true,
        createdAt: true,
        updatedAt: true,
      },
    });
    res.status(200).json({ user });
  } catch (error) {
    console.error("Error fetching user by ID:", error);
    return res.status(500).json({ message: "Something went wrong", error });
  }
};
