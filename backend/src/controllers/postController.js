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

export const getAllPost = async (req, res) => {
  try {
    const posts = await prisma.post.findMany({
      select: {
        id: true,
        title: true,
        description: true,
        budget: true,
        category: true,
        acceptedStatus: true,
        selectedWorkerId: true,
        author: {
          select: {
            id: true,
            name: true,
            avatar: true,
          },
        },
        appliedWorkers: {
          select: {
            id: true,
            selected: true,
            budget: true,
            worker: {
              select: {
                id: true,
                name: true,
                avatar: true,
              },
            },
          },
        },
      },
      orderBy: {
        createdAt: 'desc',
      },
    });

    res.status(200).json({
      success: true,
      total: posts.length,
      posts,
    });
  } catch (error) {
    console.log('Error in getAllPost:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch posts',
      error: error.message,
    });
  }
};
   export const applyToPostHandler = async (req, res) => {
  try {
    const { workerId, description, budget,postId  } = req.body;

    if (!postId || !workerId) {
      return res.status(400).json({
        success: false,
        message: "postId and workerId are required",
      });
    }

    const post = await prisma.post.findUnique({ where: { id: postId } });
    if (!post) {
      return res.status(404).json({
        success: false,
        message: "Post not found",
      });
    }

    const alreadyApplied = await prisma.appliedWorker.findFirst({ where: { postId, workerId } });
    if (alreadyApplied) {
      return res.status(400).json({
        success: false,
        message: "You have already applied to this post",
      });
    }

    const application = await prisma.appliedWorker.create({
      data: { postId, workerId, description, budget: Number(budget) },
      include: {
        worker: { select: { id: true, name: true, avatar: true } },
        post: { select: { id: true, title: true, category: true } },
      },
    });

    res.status(201).json({
      success: true,
      message: "Proposal submitted successfully",
      application,
    });
  } catch (error) {
    console.error("Error in applyToPost:", error);
    res.status(500).json({ success: false, message: "Failed to apply to post", error: error.message });
  }
};
