<?php
$conn = new mysqli(null, "worky-waas", "worky123", "worker", 
	null, "/cloudsql/workytest:asia-south1:workytestsql");

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 


$makeQuery = "SELECT * FROM clientList";

$statement = $conn->query($makeQuery);

$myarray = array();

while($resultFrom = $statement->fetch_assoc()){
    $myarray[] = $resultFrom;

}

echo json_encode($myarray);
?>