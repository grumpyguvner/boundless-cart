<?php

date_default_timezone_set('Europe/Paris') ;

$url = "http://localhost/admin/batch/dispatcher.php";

$action = 'amazon/orders/cron' ;

$limit = 1000 ;

$useragent = "Mozilla" ;

if ( $argc == 4 )
{
  $date_start = strtotime($argv[1]) ;
  $date_end   = strtotime($argv[2] . ' + 1 day - 1min') ;
  $language   = $argv[3] ;
}
else
{
  $date_start = strtotime('today') ;
  $date_end   = strtotime('tomorrow now - 15min') ;
  $language   = 'de' ;
}

$postfields = 'action=' . $action . '&date_start=' . $date_start . '&date_end=' . $date_end . '&limit=' . $limit ;
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
