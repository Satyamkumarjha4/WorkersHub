import prisma from "../config/prisma.js";

export const createPost = async (req, res) => {
  try {
    const {
      title,
      description,
      budget,
      category,
      deadline,
      authorId,
      mediaUrls,
    } = req.body;

    const post = await prisma.post.create({
      data: {
        title,
        description,
        budget,
        category,
        deadline,
        author: {
          connect: { id: authorId },
        },
      },
      include: { media: true, author: true },
    });

    if (mediaUrls && mediaUrls.length > 0) {
      const media = mediaUrls.map((url) => ({
        url,
        post: {
          connect: { id: post.id },
        },
      }));
      await prisma.media.createMany({ data: media });
    }

    res.status(201).json(post);
  } catch (error) {
    console.error("Error creating post:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const applyToPost = async (req, res) => {
  try {
    const { postId, workerId, description, budget } = req.body;
    const application = await prisma.appliedWorker.create({
      data: {
        description,
        budget,
        post: { connect: { id: postId } },
        worker: { connect: { id: workerId } },
      },
      include: { post: true, worker: true },
    });
    res.status(201).json(application);
  } catch (error) {
    console.error("Error applying to post:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

export const getPostById = async (req, res) => {
  try {
    const { postId } = req.query;
    const post = await prisma.post.findUnique({
      where: { id: postId },
      include: { media: true, author: true, appliedWorkers: true },
    });
    if (!post) {
      return res.status(404).json({ error: "Post not found" });
    }
    res.status(200).json(post);
  } catch (error) {
    console.error("Error fetching post:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};
