<?php
require('connection.php');
if($connect === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}

$JobID = mysqli_real_escape_string($connect, $_REQUEST['JobID']);
$jobTitle = mysqli_real_escape_string($connect, $_REQUEST['jobTitle']);
$jobType = mysqli_real_escape_string($connect, $_REQUEST['jobType']);
$jobPrice = mysqli_real_escape_string($connect, (float)$_REQUEST['jobPrice']);
$jobLocation = mysqli_real_escape_string($connect, $_REQUEST['jobLocation']);
$jobWorkingHours = mysqli_real_escape_string($connect, (int)$_REQUEST['jobWorkingHours']);
$jobDescription = mysqli_real_escape_string($connect, $_REQUEST['jobDescription']);
$jobMobileNumber = mysqli_real_escape_string($connect, (int)$_REQUEST['jobMobileNumber']);
$jobEmail = mysqli_real_escape_string($connect, $_REQUEST['jobEmail']);
$userID = mysqli_real_escape_string($connect, (int)$_REQUEST['userID']);
$dateTimeStart = mysqli_real_escape_string($connect, (int)$_REQUEST['dateTimeStart']);
$dateTimeStart = date('Y-m-d',$dateTimeStart);
$dateTimeFinish = mysqli_real_escape_string($connect, (int)$_REQUEST['dateTimeFinish']);
$dateTimeFinish = date('Y-m-d',$dateTimeFinish);

$sql = "UPDATE `userJobList` SET `jobTitle`='$jobTitle',`jobType`='$jobType' ,`jobPrice`='$jobPrice',`jobLocation`='$jobLocation',`jobWorkingHours`='$jobWorkingHours',`jobDescription`='$jobDescription',`jobMobileNumber`='$jobMobileNumber',`jobEmail`='$jobEmail',`JobID`='$JobID',`userID`='$userID',`dateTimeStart`='$dateTimeStart',`dateTimeEnd`='$dateTimeFinish' WHERE `JobID`= '$JobID'";

if(mysqli_query($connect, $sql)){
    echo "Records updated successfully.";
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($connect);
}
 
mysqli_close($connect);
?>