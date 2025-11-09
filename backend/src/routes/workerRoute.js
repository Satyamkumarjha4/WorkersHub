import {Router} from "express"
import { getNearbyWorkers, getWorkerList } from "../controllers/workerController.js";

const workerRouter= Router();

workerRouter.get('/getWorkerList',getWorkerList)
workerRouter.get('/getWorkerByRange',getNearbyWorkers);


export default workerRouter
