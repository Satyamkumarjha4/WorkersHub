import prisma from "../config/prisma.js";
import calculateDistance from "../utils/distanceCalculator.js"
export const getWorkerList = async (req, res) => {
  try {
    const workerL = await prisma.worker.findMany({
      include: { form: true }
    })
    const workerList = workerL.map((worker) => {
      return {
        id: worker.id,
        name: worker.name,
        avatar: worker.avatar,
        idForChat: worker.userId,
        age: worker.form?.age,
        workingAdress: worker.form?.age,
        description: worker.form?.description
      }
    })

    res.status(200).json({
      success: true,
      worker: workerList
    })
  }
  catch (error) {
    console.log("error in getworkList:", error)
    res.status(500).json({
      success: false,
      error: error
    })
  }
}