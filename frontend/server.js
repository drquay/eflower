var express = require('express');
var app = express();
app.use(express.static('dist/eflower'));
app.get('/', function (req, res,next) {
res.redirect('/');
});
app.listen(4200)