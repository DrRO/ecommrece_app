<?php
include '../connection.php';


$minRating = 4.4;
$limitproductItems = 5;

$sqlQuery = "Select * FROM items_table WHERE rating>= '$minRating' ORDER BY rating DESC LIMIT $limitproductItems";
                                                                    //5 or less than 5 newly available top rated products item
                                                                    //not greater than 5

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