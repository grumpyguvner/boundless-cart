<?php

date_default_timezone_set('Europe/Paris') ;

$url = "http://localhost/admin/batch/dispatcher.php";

$action = 'amazon/synchronize/synchronize' ;


$useragent = "Mozilla" ;

$language_id=1 ;
$language="en" ;
$startDate=date('Y-m-d', time() - (24 * (3600))) ;

$postfields = 'action=' . $action . '&synch-date=' . $startDate . '&language=' . $language . '&language_id=' . $language_id ;
echo $postfields ;

$ch = curl_init();

//you might need to set some cookie details up (depending on the site)
curl_setopt($ch, CURLOPT_COOKIEJAR, "cookies.txt");
curl_setopt($ch, CURLOPT_COOKIEFILE, "cookies.txt");

curl_setopt($ch, CURLOPT_USERAGENT, $useragent); //set our user agent
curl_setopt($ch, CURLOPT_POST, 1); //set how many paramaters to post
curl_setopt($ch, CURLOPT_URL, $url); //set the url we want to use
curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields); //set the user_name field to 'joeyjohns'

$result= curl_exec ($ch); //execute and get the results
curl_close ($ch);
print $result; //display the reuslt
?>
