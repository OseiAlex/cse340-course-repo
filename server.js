import 'dotenv/config';

import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

import { testConnection } from './src/models/db.js';

import {
    getAllOrganizations
} from './src/models/organizations.js';

import {
    getAllProjects
} from './src/models/projects.js';

import {
    getAllCategories
} from './src/models/categories.js';


const app = express();

const PORT = process.env.PORT || 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);


// ============================================
// VIEW ENGINE
// ============================================

app.set('view engine', 'ejs');

app.set(
    'views',
    path.join(__dirname, 'views')
);


// ============================================
// STATIC FILES
// ============================================

app.use(
    express.static(
        path.join(__dirname, 'public')
    )
);


// ============================================
// HOME
// ============================================

app.get('/', async (req, res) => {

    const title = 'Community Service Hub';

    res.render('home', {
        title
    });
});


// ============================================
// ORGANIZATIONS
// ============================================

app.get('/organizations', async (req, res) => {

    try {

        const organizations =
            await getAllOrganizations();

        const title =
            'Our Partner Organizations';

        res.render('organizations', {
            title,
            organizations
        });

    } catch (error) {

        console.error(
            'Error retrieving organizations:',
            error
        );

        res.status(500).render('home', {
            title: 'Database Error'
        });
    }
});


// ============================================
// PROJECTS
// ============================================

app.get('/projects', async (req, res) => {

    try {

        const projects =
            await getAllProjects();

        const title =
            'Service Projects';

        res.render('projects', {
            title,
            projects
        });

    } catch (error) {

        console.error(
            'Error retrieving projects:',
            error
        );

        res.status(500).render('home', {
            title: 'Database Error'
        });
    }
});


// ============================================
// CATEGORIES
// W02 REQUIREMENT
// ============================================

app.get('/categories', async (req, res) => {

    try {

        const categories =
            await getAllCategories();

        const title =
            'Service Project Categories';

        res.render('categories', {
            title,
            categories
        });

    } catch (error) {

        console.error(
            'Error retrieving categories:',
            error
        );

        res.status(500).render('home', {
            title: 'Database Error'
        });
    }
});


// ============================================
// 404
// ============================================

app.use((req, res) => {

    res.status(404).send(
        'Page not found.'
    );
});


// ============================================
// START SERVER
// ============================================

app.listen(PORT, async () => {

    try {

        await testConnection();

        console.log(
            `Server is running at http://127.0.0.1:${PORT}`
        );

        console.log(
            `Environment: ${
                process.env.NODE_ENV || 'development'
            }`
        );

    } catch (error) {

        console.error(
            'Error connecting to the database:',
            error.message
        );

    }

});