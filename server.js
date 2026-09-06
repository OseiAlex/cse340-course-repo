import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const app = express();
const port = process.env.PORT || 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Set EJS as the view engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Serve static files from the public folder
app.use(express.static(path.join(__dirname, 'public')));

// Home page
app.get('/', async (req, res) => {
    res.render('home', {
        title: 'Home'
    });
});

// Organizations page
app.get('/organizations', async (req, res) => {
    res.render('organizations', {
        title: 'Organizations'
    });
});

// Service projects page
app.get('/projects', async (req, res) => {
    res.render('projects', {
        title: 'Service Projects'
    });
});

// Service project categories page
app.get('/categories', async (req, res) => {
    res.render('categories', {
        title: 'Service Project Categories'
    });
});

// 404 page
app.use(async (req, res) => {
    res.status(404).send('Page not found');
});

// Start server
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});