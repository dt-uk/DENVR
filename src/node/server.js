const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Theorem data
const theorem = {
    name: "SLK6 Noetherian Module Equivalence",
    conditions: [
        "P is projective",
        "Pp is free over Ap for every prime ideal p",
        "Pm is free over Am for every maximal ideal m"
    ],
    equivalence: true,
    references: [
        "Serre, 1955",
        "Kaplansky, 1958",
        "Matsumura, 1986"
    ]
};

// API endpoints
app.get('/', (req, res) => {
    res.json({
        project: 'Noetherian Module Equivalence API',
        version: '1.0',
        endpoints: ['/theorem', '/verify', '/health']
    });
});

app.get('/theorem', (req, res) => {
    res.json(theorem);
});

app.post('/verify', (req, res) => {
    const { ring_properties, module_rank } = req.body;
    
    // Simplified verification logic
    const isProjective = module_rank > 0;
    const isLocallyFree = ring_properties?.noetherian === true;
    
    res.json({
        equivalent: isProjective === isLocallyFree,
        conditions: {
            projective: isProjective,
            locally_free_at_primes: isLocallyFree,
            locally_free_at_maximals: isLocallyFree
        }
    });
});

app.get('/health', (req, res) => {
    res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Start server
if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`SLK6 Theorem API running on port ${PORT}`);
        console.log(`Access: http://localhost:${PORT}/theorem`);
    });
}

module.exports = app;
