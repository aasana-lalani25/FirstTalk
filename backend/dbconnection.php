<?php

function dbconnection(){
    $conn=mysqli_connect("localhost","root","","deafapp");
    return $conn;
}

?>