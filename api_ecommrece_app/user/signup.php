<?php
include '../connection.php';

//POST = send/save data to mysql db
//GET = retrive/read data from mysql db

$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_password']);  //md5 to make password secure in Binary formate

$sqlQuery = "INSERT INTO users_table SET user_name ='$userName', user_email ='$userEmail' , user_password = '$userPassword'";

$resultofQuery = $connectNow->query($sqlQuery);

if ($resultofQuery){
    echo json_encode(array("success"=>true));
}else{

    echo json_encode(array("success"=>false));
}