/*
  Warnings:

  - You are about to drop the column `email` on the `Client` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `Client` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `Worker` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `Worker` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `email` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "public"."Client_email_key";

-- DropIndex
DROP INDEX "public"."Worker_email_key";

-- AlterTable
ALTER TABLE "Client" DROP COLUMN "email",
DROP COLUMN "password";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "password" TEXT;

-- AlterTable
ALTER TABLE "Worker" DROP COLUMN "email",
DROP COLUMN "password";

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
