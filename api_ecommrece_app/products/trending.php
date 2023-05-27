<?php
include '../connection.php';


$minRating = 4.4;
$limitProductItems = 5; //not greater than 5

$sqlQuery = "Select * FROM items_table WHERE rating>= '$minRating' ORDER BY rating DESC LIMIT $limitProductItems";
                                                                    
                                                                    

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