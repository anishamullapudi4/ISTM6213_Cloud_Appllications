<?php
/*
Name: Anisha Mullapudi
Filename: currencyconverter.php
*/

if ($_SERVER["REQUEST_METHOD"] == "POST") {
	$servername = "localhost";
	$username = "root";
	$password = "buOhG51Fx9HI";
	$dbname = "finalexam";
	if (empty($_POST["amount"])) {
		echo "amount required";
	}else{
		// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);

		// Check connection
		if ($conn->connect_error) {
		  die("Connection failed: " . $conn->connect_error);
		}
		$sql = "SELECT `".$_POST["currencyto"]."` FROM `exchangerate` where 1;" ;
		$result = mysqli_query($conn, $sql);
		if($result){
			$row = mysqli_fetch_assoc($result);
			echo $row[$_POST["currencyto"]];
		}else {
		  echo json_encode("Error");
		}
		$conn->close();
	}
}
if ($_SERVER["REQUEST_METHOD"] == "GET") {
	$servername = "localhost";
	$username = "root";
	$password = "buOhG51Fx9HI";
	$dbname = "finalexam";
	$conn = new mysqli($servername, $username, $password, $dbname);
	// Check connection
	if ($conn->connect_error) {
	  die("Connection failed: " . $conn->connect_error);
	}
	$sql = "SELECT * FROM `exchangerate` where 1;" ;
	$result = mysqli_query($conn, $sql);
	if($result){
		$row = mysqli_fetch_assoc($result);
		echo json_encode($row);
	}else {
	  echo json_encode("Error");
	}
	$conn->close();
}
?>
