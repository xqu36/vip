var express = require('express');
var multer = require('multer'),
	bodyParser = require('body-parser'),
	path = require('path');

var app = express();
app.use(bodyParser.json());

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.get('/', function (req, res) {
	res.render('index');
});

app.post('/', multer({ dest: './uploads'}).single('upl'), function(req,res){
	console.log(req.body); //form fields
	console.log(req.file); //form files
	res.status(204).end();
});

app.listen(8000, function() {
	console.log('Test listening on port 8000');
});
