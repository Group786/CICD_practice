const http = require('http');

const hostname = '0.0.0.0'; // Listen on all network interfaces
const port = 8080; // The port inside the container

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello from the CI/CD Pipeline on EC2! (V1.0)\n'); // Change the version number here for testing
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
