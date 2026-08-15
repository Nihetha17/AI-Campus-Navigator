require("dotenv").config();

const connectDB = require("./config/db");
const express = require("express");
const cors = require("cors");
const campusData = require("./data/campusData");
const Chat = require("./models/Chat");

const { GoogleGenerativeAI } = require("@google/generative-ai");

const app = express();
connectDB();
app.use(cors());
app.use(express.json());
const genAI = new GoogleGenerativeAI(
  process.env.GEMINI_API_KEY
);

app.get("/", (req, res) => {
  res.send("Campus Navigator AI Backend Running");
});

app.post("/chat", async (req, res) => {
  try {
    const { message } = req.body;

    const model = genAI.getGenerativeModel({
      model: "gemini-2.5-flash",
    });

const prompt = `
You are an AI Campus Assistant.

Answer only using the campus information below.

Campus Information:
${campusData}

Question:
${message}
`;

const result = await model.generateContent(prompt);

    const response = result.response.text();

await Chat.create({
  question: message,
  response: response,
});

res.json({
  success: true,
  response,
});
  } catch (error) {
    console.error(error);

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});
app.get("/history", async (req, res) => {
  try {
    const chats = await Chat.find()
      .sort({ createdAt: 1 });

    res.json({
      success: true,
      chats,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
});
app.listen(process.env.PORT, () => {
  console.log(
    `Server running on port ${process.env.PORT}`
  );
});
