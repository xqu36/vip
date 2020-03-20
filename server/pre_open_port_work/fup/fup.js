var express = require('express');
var multer = require('multer'),
	bodyParser = require('body-parser'),
	path = require('path');
var storage = multer.diskStorage({
	destination: function(req, file, cb) {
		cb(null, './uploads');
	},
	filename: function(req, file, cb) {
		cb(null, file.fieldname + '-' + Date.now());
	}
});
var upload = multer({ storage: storage }).any();

var app = express();
app.use(bodyParser.json());

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.get('/', function (req, res) {
	res.render('index');
});

app.post('/', upload, function(req,res) {
		console.log(req.body);
		console.log(req.file);
		res.status(204).end();
});
app.listen(8000, function() {
	console.log('Test listening on port 8000');
});
