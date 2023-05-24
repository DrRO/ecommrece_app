<?php
include '../connection.php';


//POST = send/save data to mysql db
//GET = retrive/read data from mysql db


$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_password']);  //md5 to make password secure in Binary formate

//email and password must be true

$sqlQuery = "SELECT * FROM users_table WHERE  user_email ='$userEmail' AND user_password = '$userPassword'"; 

$resultofQuery = $connectNow->query($sqlQuery);

if ($resultofQuery->num_rows > 0){ 
    // allow user to login

    $userRecord = array();


    //fetch_assoc() is a method fetch a result row
    while($rowExist = $resultofQuery->fetch_assoc())
    {
        $userRecord[] = $rowExist;
    }

    echo json_encode(array("success"=>true, 
                             "userData"=>$userRecord[0],
));
}else{  // prevent user to login

    echo json_encode(array("success"=>false));
}