<?php
include("send.php");

extract($_POST);
$sqlq = "INSERT INTO `feedback` (`name`, `uname`, `rating`, `phno`, `comm`)
VALUES ('".$name"', '".$uname"', '".$rating"', '".$phno"', '".$comm"')";
$result=$mysqli->sqlq($sqlq);
if(!$result)
{
    echo "SOmo".$mysqli->err();
}

echo "THanks";
$mysqli->close();

print_r($_POST);

?>