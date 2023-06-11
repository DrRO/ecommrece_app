<?php
include '../connection.php';

$sqlQuery = "Select * FROM items_table ORDER BY item_id DESC";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery->num_rows > 0) 
{
    $productItemsRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc())
    {
        $productItemsRecord[] = $rowFound;
    }

    echo json_encode(
        array(
            "success"=>true,
            "productItemsData"=>$productItemsRecord,
        )
    );
}
else 
{
    echo json_encode(array("success"=>false));
}