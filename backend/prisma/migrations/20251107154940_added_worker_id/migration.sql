-- CreateEnum
CREATE TYPE "PostStatus" AS ENUM ('Open', 'InProgress', 'Completed', 'Cancelled');

-- AlterTable
ALTER TABLE "AppliedWorker" ADD COLUMN     "selected" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Post" ADD COLUMN     "acceptedStatus" "PostStatus",
ADD COLUMN     "selectedWorkerId" TEXT;
