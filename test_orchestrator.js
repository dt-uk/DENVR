const { exec } = require('child_process');
console.log('Node.js Test Orchestrator');
async function runTest(service) {
    return new Promise((resolve) => {
        exec(`docker-compose -f docker-compose.test.yml up ${service}`, (err, stdout) => resolve(stdout));
    });
}
