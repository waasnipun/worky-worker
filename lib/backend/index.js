const express = require('express');
const mysql = require('mysql');

//create connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database : 'test'
});

//connect
db.connect((err)=>{
    if(err){
       throw err;
    }
    console.log('MySql Connected..');
});

const app = express();

app.use(express.static('public'));
app.use(express.json({limit:'1mb'}));

//Select data to the table
app.get('/workerHome',(req,res) => {
    let sql = 'SELECT * FROM userJobList';
    let query = db.query(sql,(err,result) => {
        if(err) throw err;
        // console.log(result);
        res.send(result);
    });
});

//post data to the database
app.post('/createGig', (req, res)=>{
    console.log(req.body.dateTimeStart);
    let post = {jobTitle: req.body.jobTitle,jobType: req.body.jobType,jobPrice: req.body.jobPrice,
        jobLocation: req.body.jobLocation,jobWorkingHours: req.body.jobWorkingHours,jobDescription: req.body.jobDescription,
        jobMobileNumber: req.body.jobMobileNumber,jobEmail: req.body.jobEmail,imageUrl: req.body.imageUrl,
        dateTimeStart: req.body.dateTimeStart,dateTimeEnd: req.body.dateTimeEnd};
    var name = 'INSERT INTO userjoblist SET ?';
    let query =  db.query(name,post);
    res.json({status:"OK"});
});

app.listen('8000',()=>{
    console.log('Server started');
});


