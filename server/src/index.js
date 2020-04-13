require("dotenv").config();

const bodyparser = require("body-parser");
const express = require("express");
const cors = require("cors");
const app = express();

const userRoutes = require("./routes/users");
const requestRoutes = require("./routes/requests");

const PORT = process.env.PORT;

app.use(cors());
app.use(express.static("public"));
app.use(bodyparser.json());

app.use("/users", userRoutes);
app.use("/requests", requestRoutes);

app.listen(PORT, () => console.log(`Listening on port ${PORT}`));
