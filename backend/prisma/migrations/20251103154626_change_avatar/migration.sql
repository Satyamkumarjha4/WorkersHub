/*
  Warnings:

  - You are about to drop the column `avatar` on the `Form` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Client" ADD COLUMN     "avatar" TEXT;

-- AlterTable
ALTER TABLE "Form" DROP COLUMN "avatar";

-- AlterTable
ALTER TABLE "Worker" ADD COLUMN     "avatar" TEXT;
