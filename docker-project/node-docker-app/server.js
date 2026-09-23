const express = require("express");
const { createClient } = require("redis");

const app = express();

const PORT = process.env.PORT || 3000;

// Redis configuration
const redisClient = createClient({
    url: process.env.REDIS_URL || "redis://redis:6379"
});

// Redis error handling
redisClient.on("error", (err) => {
    console.error("Redis Client Error:", err);
});

// Connect to Redis
redisClient.connect()
    .then(() => {
        console.log("Connected to Redis");
    })
    .catch((err) => {
        console.error("Redis connection failed:", err);
    });

// Root endpoint
app.get("/", (req, res) => {
    res.json({
        message: "Hello from DevOps Bootcamp!",
        application: "Node.js Docker Application",
        sprint: "11.7"
    });
});

// Health check endpoint
app.get("/health", (req, res) => {
    res.status(200).json({
        status: "healthy"
    });
});

// Application information endpoint
app.get("/api/info", (req, res) => {
    res.json({
        application: "DevOps Bootcamp API",
        version: "1.0.0",
        environment: process.env.NODE_ENV || "development"
    });
});

// Redis test endpoint
app.get("/cache", async (req, res) => {
    try {
        await redisClient.set("message", "Hello from Redis!");

        const value = await redisClient.get("message");

        res.json({
            message: value
        });
    } catch (error) {
        console.error("Redis communication failed:", error);

        res.status(500).json({
            error: "Redis communication failed"
        });
    }
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server running on port ${PORT}`);
});
