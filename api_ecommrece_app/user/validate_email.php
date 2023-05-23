<?php
include '../connection.php';

$userEmail = $_POST['user_email'];

 $sqlQuery = "SELECT * FROM users_table WHERE user_email='$userEmail'";  //SELECT * means select all

 $resultofQuery = $connectNow->query($sqlQuery);

if ($resultofQuery->num_rows > 0){

   // num rows length == 1 means email already in someone else use  >>> Error
    echo json_encode(array("emailexist"=>true));
}else{

   // num rows length == 0 means email is not already in someone else use  >>> user can signup successfully
    echo json_encode(array("emailexist"=>false));
}

//