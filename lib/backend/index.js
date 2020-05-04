const express = require('express');
const mysql = require('mysql');

//create connection

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database : 'nodedb'
});

//connect

db.connect((err)=>{
    if(err){
       throw err;
    }
    console.log('MySql Connected..');
});

const app = express();

//Select data to the table
app.get('/getData',(req,res) => {
    let sql = 'SELECT * FROM userJobList';
    let query = db.query(sql,(err,result) => {
        if(err) throw err;
        console.log(result);
        res.send(result);
    });
});




app.listen('58271',()=>{
    console.log('Server started');
});