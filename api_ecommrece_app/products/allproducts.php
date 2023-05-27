<?php
include '../connection.php';

$sqlQuery = "Select * FROM items_table ORDER BY item_id DESC";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery->num_rows > 0) 
{
    $ProductItemsRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc())
    {
        $ProductItemsRecord[] = $rowFound;
    }

    echo json_encode(
        array(
            "success"=>true,
            "ProductItemsData"=>$ProductItemsRecord,
        )
    );
}
else 
{
    echo json_encode(array("success"=>false));
}