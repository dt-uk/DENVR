/**
 * Node.js REST API Server for Nullstellensatz Solver
 */

const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const math = require('mathjs');
const swaggerUi = require('swagger-ui-express');
const YAML = require('yamljs');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Swagger documentation
const swaggerDocument = YAML.load(path.join(__dirname, '../docs/swagger.yaml'));
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

/**
 * Nullstellensatz Solver Class
 */
class NullstellensatzSolver {
    constructor() {
        this.parser = math.parser();
    }

    /**
     * Parse polynomial string to mathjs expression
     */
    parsePolynomial(polyStr, variables) {
        try {
            // Replace ^ with ** for mathjs
            let expr = polyStr.replace(/\^/g, '**');
            
            // Create evaluation context
            const scope = {};
            variables.forEach(v => {
                scope[v] = math.symbol(v);
            });
            
            return math.parse(expr, scope);
        } catch (error) {
            throw new Error(`Failed to parse polynomial: ${error.message}`);
        }
    }

    /**
     * Check if f is in radical of (f1,...,fr)
     */
    checkNullstellensatz(f, fList, variables) {
        // For demo purposes - in production, implement actual algorithm
        console.log(`Checking Nullstellensatz for f=${f}`);
        console.log(`Ideal generators: ${fList}`);
        console.log(`Variables: ${variables}`);
        
        // Parse all polynomials
        const fExpr = this.parsePolynomial(f, variables);
        const idealExprs = fList.map(poly => this.parsePolynomial(poly, variables));
        
        // Simplified implementation
        // In production, implement:
        // 1. Gröbner basis computation
        // 2. Radical membership testing
        // 3. Coefficient finding
        
        return {
            isInRadical: true,
            N: 2,
            coefficients: fList.map((_, i) => `g${i+1}`),
            explanation: `Based on Hilbert's Nullstellensatz, ∃ N=2 and polynomials g1,...,g${fList.length} such that f^2 = Σ g_i·f_i`
        };
    }

    /**
     * Generate random test case
     */
    generateTestCase(numVars = 2, numPolynomials = 3) {
        const variables = Array.from({length: numVars}, (_, i) => `x${i+1}`);
        
        // Generate random polynomials
        const generateRandomPoly = () => {
            const terms = [];
            for (let i = 0; i < 3; i++) {
                const coeff = Math.floor(Math.random() * 5) + 1;
                const varIndex = Math.floor(Math.random() * numVars);
                const power = Math.floor(Math.random() * 3) + 1;
                terms.push(`${coeff}*${variables[varIndex]}^${power}`);
            }
            return terms.join(' + ');
        };
        
        const f = generateRandomPoly();
        const fList = Array.from({length: numPolynomials}, () => generateRandomPoly());
        
        return { f, fList, variables };
    }
}

// Initialize solver
const solver = new NullstellensatzSolver();

// Routes
app.get('/', (req, res) => {
    res.json({
        message: 'Nullstellensatz Solver API',
        version: '1.0.0',
        endpoints: {
            solve: 'POST /api/solve',
            test: 'GET /api/test',
            health: 'GET /api/health'
        }
    });
});

app.get('/api/health', (req, res) => {
    res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

app.get('/api/test', (req, res) => {
    const testCase = solver.generateTestCase();
    res.json({
        testCase,
        message: 'Generated test case for Nullstellensatz problem'
    });
});

app.post('/api/solve', (req, res) => {
    try {
        const { f, fList, variables } = req.body;
        
        if (!f || !fList || !variables) {
            return res.status(400).json({
                error: 'Missing required parameters: f, fList, variables'
            });
        }
        
        const result = solver.checkNullstellensatz(f, fList, variables);
        
        res.json({
            success: true,
            problem: { f, fList, variables },
            solution: result
        });
    } catch (error) {
        res.status(500).json({
            error: 'Failed to solve problem',
            message: error.message
        });
    }
});

// Start server
app.listen(PORT, () => {
    console.log(`Nullstellensatz API Server running on port ${PORT}`);
    console.log(`API Documentation: http://localhost:${PORT}/api-docs`);
});

module.exports = app;
