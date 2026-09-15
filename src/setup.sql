-- ============================================
-- CSE 340 W02 DATABASE SETUP
-- COMMUNITY SERVICE HUB
-- ============================================


-- ============================================
-- REMOVE OLD TABLES
-- ============================================

DROP TABLE IF EXISTS project_category;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS organization;


-- ============================================
-- ORGANIZATION TABLE
-- ============================================

CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,

    name VARCHAR(150) NOT NULL,

    description TEXT NOT NULL,

    contact_email VARCHAR(255) NOT NULL,

    logo_filename VARCHAR(255) NOT NULL
);


-- ============================================
-- ORGANIZATIONS
-- ============================================

INSERT INTO organization (
    name,
    description,
    contact_email,
    logo_filename
)
VALUES
(
    'BrightFuture Builders',
    'An organization focused on improving communities through construction and development projects.',
    'contact@brightfuture.org',
    'organization1.jpg'
),
(
    'GreenHarvest Growers',
    'A community organization promoting environmental sustainability and food production.',
    'info@greenharvest.org',
    'organization2.jpg'
),
(
    'UnityServe Volunteers',
    'A volunteer organization connecting people with meaningful community service opportunities.',
    'hello@unityserve.org',
    'organization3.jpg'
);


-- ============================================
-- PROJECT TABLE
-- ============================================

CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,

    organization_id INTEGER NOT NULL,

    title VARCHAR(200) NOT NULL,

    description TEXT NOT NULL,

    location VARCHAR(200) NOT NULL,

    date DATE NOT NULL,

    CONSTRAINT fk_project_organization
        FOREIGN KEY (organization_id)
        REFERENCES organization (organization_id)
        ON DELETE CASCADE
);


-- ============================================
-- PROJECTS
-- ============================================

INSERT INTO project (
    organization_id,
    title,
    description,
    location,
    date
)
VALUES

-- ORGANIZATION 1

(
    1,
    'Community Center Renovation',
    'Help renovate and improve a local community center.',
    'Accra',
    '2026-10-05'
),

(
    1,
    'School Building Project',
    'Assist with improvements to a local school building.',
    'Tema',
    '2026-10-12'
),

(
    1,
    'Public Library Improvement',
    'Help improve facilities and learning spaces in a public library.',
    'Kumasi',
    '2026-10-19'
),

(
    1,
    'Community Playground Construction',
    'Assist with the construction of a community playground.',
    'Accra',
    '2026-10-26'
),

(
    1,
    'Housing Support Project',
    'Support families with basic housing improvement projects.',
    'Kasoa',
    '2026-11-02'
),


-- ORGANIZATION 2

(
    2,
    'Community Garden',
    'Help establish and maintain a community vegetable garden.',
    'Accra',
    '2026-10-07'
),

(
    2,
    'Tree Planting Campaign',
    'Plant trees and educate residents about environmental conservation.',
    'Tema',
    '2026-10-14'
),

(
    2,
    'Urban Farming Workshop',
    'Teach community members basic urban farming techniques.',
    'Kumasi',
    '2026-10-21'
),

(
    2,
    'Clean Water Awareness',
    'Promote clean water practices in local communities.',
    'Cape Coast',
    '2026-10-28'
),

(
    2,
    'Environmental Cleanup',
    'Participate in a community cleanup and environmental awareness project.',
    'Accra',
    '2026-11-04'
),


-- ORGANIZATION 3

(
    3,
    'Youth Mentoring Program',
    'Mentor young people and provide educational support.',
    'Accra',
    '2026-10-09'
),

(
    3,
    'Food Distribution',
    'Help distribute food packages to families in need.',
    'Tema',
    '2026-10-16'
),

(
    3,
    'Health Awareness Campaign',
    'Support a community health education campaign.',
    'Kumasi',
    '2026-10-23'
),

(
    3,
    'Senior Support Program',
    'Provide assistance and companionship to elderly community members.',
    'Accra',
    '2026-10-30'
),

(
    3,
    'Community Volunteer Day',
    'Join volunteers for a day of community service activities.',
    'Cape Coast',
    '2026-11-06'
);


-- ============================================
-- CATEGORY TABLE
-- ============================================

CREATE TABLE category (

    category_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL UNIQUE

);


-- ============================================
-- CATEGORIES
-- ============================================

INSERT INTO category (name)
VALUES
    ('Environmental'),
    ('Educational'),
    ('Community Service'),
    ('Health and Wellness');


-- ============================================
-- PROJECT CATEGORY
-- MANY-TO-MANY RELATIONSHIP
-- ============================================

CREATE TABLE project_category (

    project_id INTEGER NOT NULL,

    category_id INTEGER NOT NULL,

    PRIMARY KEY (
        project_id,
        category_id
    ),

    CONSTRAINT fk_project_category_project
        FOREIGN KEY (project_id)
        REFERENCES project (project_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_project_category_category
        FOREIGN KEY (category_id)
        REFERENCES category (category_id)
        ON DELETE CASCADE

);


-- ============================================
-- PROJECT/CATEGORY RELATIONSHIPS
-- ============================================

INSERT INTO project_category (
    project_id,
    category_id
)
VALUES

(1, 3),

(2, 2),

(3, 2),
(3, 3),

(4, 3),

(5, 3),

(6, 1),
(6, 3),

(7, 1),

(8, 1),
(8, 2),

(9, 1),
(9, 4),

(10, 1),
(10, 3),

(11, 2),

(12, 3),

(13, 4),
(13, 3),

(14, 4),
(14, 3),

(15, 3);


-- ============================================
-- TEST QUERIES
-- ============================================

SELECT
    organization_id,
    name,
    description,
    contact_email,
    logo_filename
FROM organization
ORDER BY organization_id;


SELECT
    project_id,
    organization_id,
    title,
    description,
    location,
    date
FROM project
ORDER BY project_id;


SELECT
    category_id,
    name
FROM category
ORDER BY category_id;


SELECT
    pc.project_id,
    p.title,
    pc.category_id,
    c.name AS category_name
FROM project_category AS pc
JOIN project AS p
    ON pc.project_id = p.project_id
JOIN category AS c
    ON pc.category_id = c.category_id
ORDER BY pc.project_id, pc.category_id;