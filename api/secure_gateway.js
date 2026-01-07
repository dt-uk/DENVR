// M-DOD Secure API Gateway with JWT validation
const express = require('express');
const jwt = require('jsonwebtoken');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const MDOD_SECRET = process.env.MDOD_JWT_SECRET || 'default-secret-change-in-prod';

app.use('/api', (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).send('Unauthorized');
  try {
    req.user = jwt.verify(token, MDOD_SECRET);
    next();
  } catch (err) {
    res.status(403).send('Invalid token');
  }
});

// Proxy to backend services
app.use('/api/fusion', createProxyMiddleware({ 
  target: 'http://localhost:8000', changeOrigin: true 
}));
app.use('/api/stream', createProxyMiddleware({ 
  target: 'http://localhost:9090', changeOrigin: true 
}));

// Health check endpoint for Kubernetes/Docker
app.get('/health', (req, res) => {
  res.json({ status: 'operational', timestamp: new Date().toISOString() });
});

app.listen(3000, () => console.log('M-DOD Gateway on :3000'));
