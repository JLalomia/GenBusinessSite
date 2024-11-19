const express = require("express");
const path = require('path');
const routes = require('./routes'); // Import the route registry
const { url } = require('./helpers/urlHelper'); // Import the URL helper

const app = express();
const PORT = process.env.PORT || 3000;

app.set('view engine', 'ejs');
app.use(express.static('public'));

app.set('views', path.join(__dirname, '../views'));

app.use('/css', express.static('public/css'));

app.use((req, res, next) => {
    // Extract the last part of the URL path as the current page name
    const path = req.path.split('/').filter(Boolean).pop();
    res.locals.currentPage = path || 'home'; // Default to 'home' if the path is empty
    next();
});

app.locals.url = url;
app.locals.routes = routes;

app.get(routes.home, (req, res) => {
    res.render('index');
});

/*app.get("/", (req, res) => {
    res.send("Hello, world!");
});*/

app.use((req, res) => {
    res.status(404).render('404', { title: '404: Page Not Found' });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});