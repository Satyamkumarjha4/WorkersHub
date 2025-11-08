import prisma from "../config/prisma.js";

export const createAndUpdateForm = async (req, res) => {
  const {
    email,
    age,
    workingAddress,
    category,
    contact,
    aadhaarNumber,
    panNumber,
    description,
    gender,
    upi,
  } = req.body;

  try {
    const worker = await prisma.worker.findFirst({
      where: { user: { email } },
    });
    console.log("Found worker:", worker);

    if (!worker) {
      return res.status(404).json({ error: "Worker not found for this email" });
    }

    const form = await prisma.form.upsert({
      where: { workerId: worker.id },
      update: {
        ...(age && { age }),
        ...(workingAddress && { workingAddress }),
        ...(category && { category }),
        ...(contact && { contact }),
        ...(aadhaarNumber && { aadhaarNumber }),
        ...(panNumber && { panNumber }),
        ...(description && { description }),
        ...(gender && { gender }),
        ...(upi && { upi }),
      },
      create: {
        worker: { connect: { id: worker.id } },
        age,
        workingAddress,
        category,
        contact,
        aadhaarNumber,
        panNumber,
        description,
        gender,
        upi,
      },
    });

    res.json(form);
  } catch (error) {
    console.error("Error creating/updating form:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getFormByWorkerEmail = async (req, res) => {
  const { email } = req.query;
  try {
    const worker = await prisma.worker.findFirst({
      where: { user: { email } },
    });
    if (!worker) {
      return res.status(404).json({ error: "Worker not found for this email" });
    }
    const form = await prisma.form.findUnique({
      where: { workerId: worker.id },
    });
    res.json(form);
  } catch (error) {
    console.error("Error fetching form:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};
