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



export const getNearbyWorkers = async (req, res) => {
  try {
    const { latitude, longitude, range } = req.body;

    if (!latitude || !longitude || !range) {
      return res.status(400).json({
        success: false,
        message: "latitude, longitude and range (km) are required",
      });
    }

    // Fetch all workers with coordinates
    const workers = await prisma.worker.findMany({
      where: {
        latitude: { not: null },
        longitude: { not: null },
      },
      include: {
        form: true
      }
    });

    // Calculate distances and filter
    const nearbyWorkers = workers.filter((worker) => {
      const distance = calculateDistance(
        latitude,
        longitude,
        worker.latitude,
        worker.longitude
      );
      return distance <= range;
    });
    const workerList = nearbyWorkers.map((worker) => {
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
      total: nearbyWorkers.length,
      workers: workerList,
    });
  } catch (error) {
    console.error("Error in getNearbyWorkers:", error);
    res.status(500).json({
      success: false,
      message: "Server error",
      error: error.message,
    });
  }
};

