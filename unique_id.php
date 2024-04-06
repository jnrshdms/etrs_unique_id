<?php

// Function to generate 
function generate_erts_request_id($unique_id)
{
    if ($unique_id == "") {
        $unique_id = date("ymdh");
        $rand = substr(md5(microtime()), rand(0, 26), 5);
        $unique_id = 'ETRS:' . $unique_id;
        $unique_id = $unique_id . '' . $rand;
    }
    
    // Limit the unique ID to 15 characters
    $unique_id = substr($unique_id, 0, 15);
    
    return $unique_id;
}

// Connect to your database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "etrs_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM etrs_training_record";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    // Update each record with a unique ID
    while ($row = $result->fetch_assoc()) {
        $uniqueID = generate_erts_request_id($row['unique_id']); // Use the function to generate or modify the request_id
        $updateSql = "UPDATE etrs_training_record SET unique_id = '$uniqueID' WHERE id = " . $row['id'];
        $conn->query($updateSql);
    }

    echo "Unique IDs added successfully!";
} else {
    echo "No records found.";
}
// Close the database connection
$conn->close();

?>

