<?php
/*
Name: Anisha Mullapudi
Filename: exchangerates.php
*/

//MySQL connection parameters. Remains the same for all connections to the database
$servername = "localhost";
$username = "root";
$password = "buOhG51Fx9HI";

// Create connection
$conn = mysqli_connect($servername, $username, $password);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

//Select database
mysqli_select_db ( $conn , 'finalexam' );
// make request of the web service using curl library (all one line)
$request = 'https://v6.exchangerate-api.com/v6/c82ee85d3d2a308976f610d2/latest/USD';
$http = curl_init($request);
// set curl options
curl_setopt($http, CURLOPT_HEADER, false);
curl_setopt($http, CURLOPT_RETURNTRANSFER, true);
curl_setopt($http, CURLOPT_SSL_VERIFYPEER, false);
// make the request
$response = curl_exec($http);
// get the status code
$status_code = curl_getinfo($http, CURLINFO_HTTP_CODE);
// close the curl session
curl_close($http);
// if the request worked then we have a string with XML in it
if ($status_code == 200) {
// create simpleXML object by loading string
	$conversionrates = json_decode($response, true);
	if (json_last_error() == JSON_ERROR_NONE) {
		if($conversionrates['result'] = "success"){
			$last_updated_date = gmdate("Y-m-d", $conversionrates["time_last_update_unix"]);
			$last_updated_date_time = gmdate("Y-m-d H:i:s", $conversionrates["time_last_update_unix"]);
			$data = array(
			"DATE" => $last_updated_date,
			"TIME_UPDATED" => $last_updated_date_time,
			"USD" => $conversionrates["conversion_rates"]["USD"],
			"AUD" => $conversionrates["conversion_rates"]["AUD"],
			"CAD" => $conversionrates["conversion_rates"]["CAD"],
			"CHF" => $conversionrates["conversion_rates"]["CHF"],
			"CNY" => $conversionrates["conversion_rates"]["CNY"],
			"EUR" => $conversionrates["conversion_rates"]["EUR"],
			"GBP" => $conversionrates["conversion_rates"]["GBP"],
			"HKD" => $conversionrates["conversion_rates"]["HKD"]
			);
			$query1 = "Insert into `exchangerate`(`DATE`,`TIME_UPDATED`, `USD`, `AUD`,`CAD`,`CHF`,`CNY`, `EUR`, `GBP`,`HKD`) values('";
			$query2 = $query1.$data['DATE']."','".$data['TIME_UPDATED']."','".$data['USD']."','".$data['AUD']."','".$data['CAD']."','".$data['CHF']."','".$data['CNY']."','".$data['EUR']."','".$data['GBP']."','".$data['HKD']."')";
			if(mysqli_query($conn, $query2))
			{
				echo "ExchangeRate data inserted";
			}
			else
			{
				echo "ExchangeRate not inserted !";
			}
		}
	}
}
else {
	die("Your call to web service failed -- code=" . $status_code);
}


?>
