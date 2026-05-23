const express = require('express');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// helmet adds security headers automatically
app.use(helmet());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    message: 'DevSecOps Demo App',
    version: '1.0.0',
    status: 'healthy'
  });
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;
