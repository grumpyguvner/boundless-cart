<?php
require_once(dirname(__FILE__) . '/libs/aws_signed_request.php');

class Amazon_Fetch
{
    //construct
    function __construct($marketplace, $key, $secret){
            $this->marketplace = str_replace('_', '.', $marketplace);
            $this->key = $key ;
            $this->secret = $secret ;
    }
    //query
    function query($params){
        return aws_signed_request($this->marketplace,$params,$this->key,$this->secret);
    }
    //fetch item
    function fetch($mode,$val){
        //validate mode
        $modes = array("EAN","UPC","ASIN","ISBN");
        if(!in_array($mode,$modes))
        {
            return(false) ;
        }
        $operation = array() ;
        $operation['Operation'] = 'ItemLookup' ;
        $operation['ItemId'] = $val ;
        $operation['IdType'] = $mode ;
        $operation['ResponseGroup'] = 'Large,BrowseNodes' ;
        $operation['AssociateTag'] = 'None' ;
        
        if ( $mode != 'ASIN' )
            $operation['SearchIndex'] = 'All' ;

        if ( ! ($response = $this->query($operation)) )
        {
            return(false) ;
        }
//       file_put_contents('toto.bin', serialize($response)) ;


  //   $response = unserialize(file_get_contents('toto.bin')) ;
//       print_r($response);
       return $this->parse($response, $mode, $val);
    }


    //parse response
    function parse($response, $mode, $val)
    {
        $data = array() ;
        $data[$mode] = $val ;

        //validate $Request
        $Request = $response['Items']['Request'];
        $error_message = $this->error_message($Request);
        if( ! empty($error_message) )
        {
              echo "Invalid request. " . $error_message ;
              return(false);
        }


        //item data
        $Item = $response['Items']['Item'];
        //Atributes
        $ItemAtributes = $Item['ItemAttributes'];
        //Assign atributes
        foreach($ItemAtributes as $key=>$val)
            $data[$key] = $val;
        //Photos
        $ItemImages = isset($Item['ImageSets']['ImageSet'])?$Item['ImageSets']['ImageSet']:"";
        //if(isset($ItemImages[0]) && is_array($ItemImages[0]))
       //     $ItemImages = $ItemImages[0];
        //Assign photos
        $data['pictures'] = array() ;

        foreach($Item['ImageSets']['ImageSet'] as $ItemImage)
        {
          if(!empty($ItemImage['LargeImage'])){
              $data['pictures'][] = $ItemImage['LargeImage'];
            }
          elseif(!empty($ItemImage['SwatchImage'])){
             $data['pictures'][] = $ItemImage['SwatchImage'];
            }

        }

        if ( ! count($data['pictures']) )
        {
           $data['pictures'] = array() ;
           $data['pictures'][] = $Item['LargeImage'] ;
        }

        //Assign description
        if(isset($Item['EditorialReviews'])){
            $itemReview = $Item['EditorialReviews']['EditorialReview'];
            $data['review'] = $itemReview['Content'];
            $data['review_short'] = $data['review'];
        }
        // Assign Nodes
        if(isset($Item['BrowseNodes']))
        {
            $browseNode = $Item['BrowseNodes']['BrowseNode'];
            $data['nodes'] = $browseNode ;

        }

        return $data;
    }

   //truncate
      function truncate($text,$length,$ending="..."){
          if(strlen($text)>$length)
              $text = substr($text,0,strpos($text,' ',TRUNCATE_FROM)).$ending;
          return $text;
      }
    //returns error message
    function error_message($param){
        return isset($param['Errors']['Error']['Message'])?$param['Errors']['Error']['Message']:"";
    }


}

?>