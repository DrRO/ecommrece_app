<?php
include '../connection.php';


//POST = send/save data to mysql db
//GET = retrive/read data from mysql db


$adminEmail = $_POST['admin_email'];
$adminPassword = $_POST['admin_password'];  

//email and password must be true

$sqlQuery = "SELECT * FROM admins_table WHERE  admin_email ='$adminEmail' AND admin_password = '$adminPassword'"; 

$resultofQuery = $connectNow->query($sqlQuery);

if ($resultofQuery->num_rows > 0){ 
    // allow admin to login

    $adminRecord = array();


    //fetch_assoc() is a method fetch a result row
    while($rowExist = $resultofQuery->fetch_assoc())
    {
        $adminRecord[] = $rowExist;
    }

    echo json_encode(array("success"=>true, 
                             "adminData"=>$adminRecord[0],
));
}else{  // prevent admin to login

    echo json_encode(array("success"=>false));
}