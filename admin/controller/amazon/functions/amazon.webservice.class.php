<?php
/* NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL SMC
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL SMC is strictly forbidden.
 * In order to obtain a license, please contact us: olivier@common-services.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe SMC
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL SMC est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter la SARL SMC a l'adresse: olivier@common-services.com
 * ...........................................................................
 * @package    Amazon Market Place
 * @copyright  Copyright (c) 2011-2011 S.A.R.L SMC (http://www.common-services.com)
 * @copyright  Copyright (c) 2011-2011 Olivier B.
 * @author     Olivier B.
 * @license    Commercial license
 * Support by mail  :  olivier@common-services.com
 * Support on forum :  delete
 * Skype : delete13_fr
 * Phone : +33.970465505
 */

class Service {
    //put your code here
    private $_debug;
    private $_cr;
    private $_att;
    private $region;
    private $Currency;

    //private $Service;

    private $mid;
    private $mpid;
    private $awsak;
    private $sk;


    // Anti Throttling
    //
    private $last_api_request ;
    private $elapsed_time ;
    
    /**
     *
     * @param <type> $auth - associative massive
     * auth['MerchantID'] - string, MerchantID
     * auth['MarketplaceID'] - string, MarketplaceID
     * auth['AWSAccessKeyID'] - string, AWSAccessKeyID
     * auth['SecretKey'] - string, SecretKey
     * @param <type> $from associative array
     * from['Country'] - country code, must be one of the following:
     * us, uk, de, fr, jp, cn, ca .
     * That codes means:
     * us - United States, uk - United Kingdom, de - Germany, fr - France, jp - Japan, cn - China, ca - Canada
     * from['Currency'] - must be one of the following:
     *
     * @param <bool> $debug
     */
    public function __construct($auth, $from, $debug = false, $cr = "<br/>\n") {
        if ($debug == true) $this->_debug = true;
        else $this->_debug = false;
        $this->_cr = $cr ; //new line symbol
        $this->_att = "<font color=\"red\">!!!</font>"; //this variable uses when debuging mode is on and error happened
                                                        //This is to draw attention to an error

        $this->setAuth($auth) ;

        //get Region
        $region = $from['Region'];

        if ($region === false)
        {
          printf("retRegion() function returns false to constructor of the Service class.
            It means, which that function comleted incorrectly. Object of the Service class can not be created now. " . $this->_cr);
            return(false) ;
        }
        
        $this->region = $region;
        if ($this->setCurrency($from['Currency']) == false)
        {
          printf("setCurrency() function returns false to constructor of the Service class.
            It means, which that function comleted incorrectly. Object of the Service class can not be created now. " . $this->_cr );
          return(false) ;
        }
        if ($this->_debug)
          printf ('Constructor Completed successfully%s', $this->_cr);


        if ($this->_debug) printf("$this->_cr Constructor. Object of the Service class created succesfully".  $this->_cr);
    }

    
    private function setAuth($auth)
    {
        if ($this->_debug)
                printf('setAuth() call', $this->_cr);
                
        if ($auth['MerchantID'] != null) $this->mid = $auth['MerchantID'];
        else
        {
            if ($this->_debug)
             printf('setAuth function. %s Error %s == null . Invalid value.%s', $this->_att, $auth['MerchantID'], $this->_cr);
            return false;
        }
        if ($auth['MarketplaceID'] != null) $this->mpid = $auth['MarketplaceID'];
        else
        {
            if ($this->_debug)
              printf('setAuth function. %s Error %s == null . Invalid value.%s', $this->_att, $auth['MarketplaceID'], $this->_cr);
            return false;
        }
        if ($auth['AWSAccessKeyID'] != null) $this->awsak = $auth['AWSAccessKeyID'];
        else
        {
            if ($this->_debug)
              printf('setAuth function. %s Error %s == null . Invalid value.%s', $this->_att, $auth['AWSAccessKeyID'], $this->_cr);
            return false;
        }
        if ($auth['SecretKey'] != null) $this->sk = $auth['SecretKey'];
        else
        {
            if ($this->_debug)
              printf("setAuth function. %s Error %s == null . Invalid value.%s", $this->_att, $auth['SecretKey'], $this->_cr);
            return false;
        }
        return ;
        if ($this->_debug)
            printf('%ssetAuth - Function Sets Authentification Parameters :
                    MerchantID : %s%s MarketplaceID : %s%s AWSAccessKeyID : %s%s AWSSecretKey : %s%s',
                    $this->_cr, $this->mid, $this->_cr, $this->mpid, $this->_cr,$this->awsak, $this->_cr,$this->sk, $this->_cr);
       return true;
    }

    private function setCurrency($curr)
    {
        if ($this->_debug) printf('setCurrency() call. curr = %s%s', $curr ,$this->_cr);
        
        if ( preg_match('/USD|GBP|EUR|JPY|CAD/i', $curr) )
        {
            $this->Currency = strtoupper($curr) ;
            return true;
        }
        if ($this->_debug)
          printf('setCurrency() function. %sError. You sent invalid currency:
                  %s Please verify this and try again. %s', $this->_att, $curr, $this->_cr);
        return false;
    }

    /**
     *
     * @param <string> $countryFrom country code.
     * Must be one of the following: us, uk, de, fr, jp, cn, ca
     * @return <string> - Feeds Web Service Url of false if unsuccessful
     */
    private function retRegion ($countryFrom)
    {
        if ($this->_debug) printf('generateFeedServiceUrl() call. countryFrom = %s%s', $countryFrom, $this->_cr);
        switch ($countryFrom)
        {
            case "us" : return "com";
            case "uk" : return "co.uk";
            case "de" : return "de";
            case "fr" : return "fr";
            case "it" : return "it";
            case "es" : return "es";
            case "be" : return "be";
            case "jp" : return "jp";
            case "cn" : return "com.cn";
            case "ca" : return "ca";
        }
        if ($this->_debug) printf('%sgenerateFeedServiceUrl() function. %sError. Incorrect Country Code "%s" . Please verify and try again.',
        $this->_cr, $this->_att, $countryFrom, $this->_cr);
        return false;
    }
    
    /**
     *All parameters must be specified, except of conditionNote. You can use another functions (partiallyUpdateProducts(), updateQuantities(), updatePrices())
     * if you want to partially update products
     * You can also update (overwrite) exesting product information using this function (AddProducts) if you want to.
     *
     * @param <type> $products - massive format:
     * $products[$i]['SKU'] - string, unique product identifier in the seller account
     * $products[$i]['ProductIDType'] - (string) Product Identification type. Must be one of the fellowing:
     *                          "ISBN", "UPC", "EAN", "ASIN", "GTIN"
     * $products[$i]['ProductIDCode'] - Product Code, based on the ProductType
     *
     * $products[$i]['ConditionType'] - string, one of the following: "New",
     *      "UsedLikeNew", "UsedVeryGood", "UsedGood", "UsedAcceptable",
     *      "CollectibleLikeNew", "CollectibleVeryGood", "CollectibleGood", "CollectibleAcceptable"
     *      "Refurbished", "Club"
     *
     * $products[$i]['ConditionNote'] - any string, up to 2000 symbols
     * $products[$i]['Quantity'] - number of items. that available for selling
     * $products[$i]['Price'] - price of the product
     * @return <int[]> Web Service Submission identifiers (3), or false, if unsuccessful
     */
    public function addProducts($products)
    {
        //when we add products all fields must be not null, except of $products[$i]['ConditionNote']
        if ($this->_debug)
        {
         echo "addProducts() call. $this->_cr";
         echo "addProducts() function. Checking for arguments... $this->_cr";
        }
        
        for ($i=0; $i<count($products); $i++)
        {
           if ($this->_debug)
            echo "addProducts() function. Checking of the $i-th product $this->_cr";
            
            if ($products[$i]['SKU'] == null || $products[$i]['ProductIDType'] == null || $products[$i]['ProductIDCode'] == null ||
                    $products[$i]['ConditionType'] == null || $products[$i]['Quantity'] == null || $products[$i]['Price'] == null)
            {
                if ($this->_debug)
                      echo "addProducts() function. $this->_att Warning. One of the fields is null (or not set) in the $i-th Product (SKU : $products[$i]['SKU']).
                            Function skips the product and continue execution. $this->_cr";
  
                $products[$i] = null;
                continue;
            }
            //check Quantity and Price in order to avoid partial data corruption
            if (!$this->checkQuantity($products[$i]['Quantity']))
            {
                if ($this->_debug)
                  printf('addProducts() function. %sQuantity Warning in the %d-th Product:
                         Function skips the product and continue execution (SKU : %s).%s',
                         $this->_att, $i, $products[$i]['SKU'], $this->_cr) ;
  
                $products[$i] = null;
                continue;
            }
            if (!$this->checkPrice($products[$i]['Price']))
            {
                 if ($this->_debug)
                   printf('addProducts() function. Warning. %s Invalid specified price, in the %d-th Product.
                          Function skips the product and continue execution  (SKU : %s). %s',
                          $this->_att, $i, $products[$i]['SKU'], $this->_cr) ;
  
                 $products[$i] = null;
                 continue;
            }
            if (!$this->partiallyCheckProduct($products[$i], "Update"))
            {
                if ($this->_debug)
                   printf('addProducts() function. %sWarning. %d-th product is partially incorrect. We skip it (SKU : %s). %s',
                           $this->_att, $i, $products[$i]['SKU'], $this->_cr);
                $products[$i] = null;
                continue;
            }
        }

        //if there is no products to add we terminate the function
        //we have to skip empty products
        $eproducts = array();
        if ($this->_debug)
        {
            $n = count($products);
            printf('addProducts() function. You sent $n products%s', $this->_cr);
        }
        
        for ($i=0; $i<count($products); $i++)
            if ($products[$i]!=null) $eproducts[] = $products[$i];
        
        if ($this->_debug)
        {
            $n = count($eproducts);
            printf('addProducts() function. %d products remaining after skippings%s', $n, $this->_cr);
        }
        
        if (count($eproducts) == 0)
        {
            if ($this->_debug)
              printf('addProducts() function. No products to add (or they are all skipped !). %sStop here with an Error.%s', $this->_att,  $this->_cr) ;
            return false;
        }
        
        $products = $eproducts;

        if ($this->_debug)
          printf('addProducts() function. Checking of the input arguments : here is the end.%s', $this->_cr);
          
        $SubmissionIDs = array();
        $SubmissionIDs[0] = $this->partiallyUpdateProducts($products, "Update", false);

        if ($this->_debug)
          printf('addProducts() function. Checking of the input arguments is finished in this function%s', $this->_cr) ;
          
        $SubmissionIDs[1] = $this->updateQuantities($products);
        $SubmissionIDs[2] = $this->updatePrices($products);
        
        if ($this->_debug)
          printf('addProducts() function : here is the end', $this->_cr) ;
        return $SubmissionIDs;
    }

    private function partiallyCheckProduct($product, $updatingType="PartialUpdate")
    {
        if ($this->_debug)
          printf('partiallyCheckProduct() call. Checking product starts here.%s', $this->_cr);

        if (!$this->checkSKU($product['SKU']))
        {
            if ($this->_debug)
            printf('partiallyCheckProduct() function. %sWarning. product["SKU"] : "%s" invalid value. Skipping the product and continue.%s', $this->_att, $product['SKU'], $this->_cr);
            return false;
        }

        if ($product['ProductIDType'] == null && $product['ProductIDCode']==null)
        {
            if ($updatingType == "Update")
            {
                if ($this->_debug)
                  printf('partiallyCheckProduct() function. %sWarning. product["ProductIDType"] AND product["ProductIDCode"]
                        are not set, but updatingType set to \"update\" It is incorrect. Please review the instructions on the top of the function.
                        Function skips the product and continue execution.%s',
                        $this->_att, $this->_cr);
                return false;
            }
        }
        else
        {
            if ($product['ProductIDType'] == null || $product['ProductIDCode'] == null)
            {
                if ($this->_debug)
                {
                    $val1 = $product['ProductIDType'];
                    $val2 = $product['ProductIDCode'];
                    printf('partiallyCheckProduct() function.  %sWarning. You specify:%s
                              product["ProductIDType"] : %s %s
                              product["ProductIDCode"] : %s %s
                              If one of that fields specified the other one must be also specified.%s',
                              $this->_att, $this->_cr, $val1, $this->_cr, $val2, $this->_cr);
                }
                return false;
            }
            if (!$this->checkProductIDType($product['ProductIDType']))
            {
                if ($this->_debug)
                {
                    $pridt = $product['ProductIDType'];
                    printf('partiallyCheckProduct() function. %sWarning. product["ProductIDType"] = %s. Incorrect Value. Function skips the product and continue execution. %s',
                            $this->_att, $pridt, $this->_cr);
                }
                return false;
            }
        }
         if ($product['ConditionType']!=null)
            if(!$this->checkConditionType($product['ConditionType']))
            {
                if ($this->_debug)
                {
                    $val1 = $product['ConditionType'];
                    printf('partiallyCheckProduct() function. %sWarning
                       products[$i]["ConditionType"] = %s . It is incorrect $this->_cr',
                       $this->_att, $val1, $this->_cr);
                }
                return false;
            }
        if ($product['ConditionNote']!=null)
        {
            if ($product['ConditionType']==null)
            {
                if ($this->_debug)
                {
                    $value = $product['ConditionNote'];
                    printf ('partiallyCheckProduct() function. %sWarning. You specify
                             products[$i]["ConditionNote"] = %s, but products[$i]["ConditionType"] is not specified. It is incorrect. Function skips the product and continue execution',
                             $this->_att, $value, $this->_cr);
                }
                return false;
            }
            if(!$this->checkConditionNote($product['ConditionNote']))
            {
                if ($this->_debug) printf('partiallyCheckProduct() function. %sError. product["ConditionNote"] : invalid value.%s', $this->_att,  $this->_cr);
                return false;
            }
        }
        if ($this->_debug) printf('partiallyCheckProduct() function successfully finished.', $this->_cr);
        return true;
    }
    

    /**
     *
     * @param <type> $products - object array:
     * $products[$i]['SKU'] - string, unique product identifier in the seller account. Must be specified.
     * $products[$i]['$ProductIDType'] - [optional] (string) Product Identification type. Must be one of the fellowing:
     *                          "ISBN", "UPC", "EAN", "ASIN", "GTIN"
     *               If $UpdatingType is equal to "Update", this field must be specified.
     * $products[$i]['$ProductIDCode'] - [optional] Product Code, based on the ProductType.
     *                    If specified, $products[$i]['$ProductIDType'] must be also specified
     *                    If null, $products[$i]['$ProductIDType'] must be also null
     *               If $UpdatingType is equal to "Update", this field must be specified.
     * $products[$i]['ConditionType'] - [optional] string, one of the following: "New",
     *      "UsedLikeNew", "UsedVeryGood", "UsedGood", "UsedAcceptable",
     *      "CollectibleLikeNew", "CollectibleVeryGood", "CollectibleGood", "CollectibleAcceptable"
     *      "Refurbished", "Club"
     *
     * $products[$i]['ConditionNote'] - [optional] any string, up to 2000 symbols
     *                if $products[$i]['ConditionNote'] specified, $products[$i]['ConditionType'] must be also specified
     *
     * @param <string> $UpdatingType - [optional] must be equal to "Update" or to "PartialUpdate".
     *         If you do not specify value of this field, this function uses "PartialUpdate" by default
     *
     *         If you use Update, all specified information overwrites any existing information.
     *         Any unspecified information is erased.
     *         If you use PartialUpdate, all specified information overwrites any existing information,
     *         but unspecified information is unaffected.
     *
     * @return <int> - FeedSubmissionID or false (if an error occurred)
     */
    public function partiallyUpdateProducts($products, $updatingType="PartialUpdate", $ch=true)
    {
        //checking input arguments
        if ($this->_debug) echo "$this->_cr partiallyUpdateProducts call. checking of the input arguments starts here. $this->_cr";

        //updating or partial updating ?
        if ($updatingType != "Update" && $updatingType != "PartialUpdate")
        {
            if ($this->_debug) printf("$this->_cr partiallyUpdateProducts function. $this->_att Error. UpdatingType must be equal to Update or to PartialUpdate. Now updatingType = $updatingType. It is incorrect. $this->_cr");
            return false;
        }
        if($ch==true)
        {
            for ($i=0; $i<count($products); $i++)
            {
                $r = $this->partiallyCheckProduct($products[$i], $updatingType);
                if($r == false) $products[$i] = null;
            }
        }
        
        if ($this->_debug)
          printf('partiallyUpdateProducts function. Checking input arguments is finished.%s', $this->_cr);

        //if there are no products to add, function will be terminated
        for ($i=0; $i<count($products); $i++)
        {
            if ($products[$i]!=null) break;
            if ($i == count($products)-1)
            {
                if ($this->_debug)
                  printf('partiallyUpdateProducts function. We have no products to add (or they all are skipped). Function is finished with $this->_att an Error.%s', $this->_cr);
                return false;
            }
        }

        $Document = new DOMDocument();
        $Messages = array();

        if ($this->_debug) printf("$this->_cr partiallyUpdateProducts function. Creating messages starts here. $this->_cr");
        $m = 0;
        for ($i=0; $i<count($products); $i++)
        {
            if ($this->_debug) printf("$this->_cr partiallyUpdateProducts function. Creating $i-th message starts here $this->_cr");
            if ($products[$i] != null)
            {
                $Messages[$m] = $this->createProductMessage ($Document, $products[$i]['SKU'],
                    $products[$i]['ProductIDType'], $products[$i]['ProductIDCode'], $products[$i]['ConditionType'],
                    $products[$i]['ConditionNote'], $m+1, $updatingType);
                $m++;
            }
            else
            {
                if ($this->_debug) printf("$this->_cr partiallyUpdateProducts function. $i-th product is incorrect. We skip it. $this->_cr");
            }
        }


        if ($this->_debug) printf("$this->_cr partiallyUpdateProducts function. Messages creating finished. $this->_cr");

        $feedDOM = $this->CreateFeed($Document, "Product", $Messages);
        $feed = $feedDOM->saveXML();
        if ($this->_debug) printf("$this->_cr partiallyUpdateProducts function. Now function starts sending query to the WebService (this->processFeed function calling).$this->_cr");
        $data = $this->processFeed("_POST_PRODUCT_DATA_", $feed);
        if ($this->_debug)
        {
            $state;
            if ($data == false) $state = "with an $this->_att error";
            else $state = "succesfully";
                printf("$this->_cr partiallyUpdateProducts function. Function execution is completed $state $this->_cr");
        }
        return $data;
    }


    public function updateProducts($products)
    {
        $SubmIDs = array();
        $SubmIDs[] = $this->partiallyUpdateProducts($products);
        $SubmIDs[] = $this->updateQuantities($products);
        $SubmIDs[] = $this->updatePrices($products);
        if ($SubmIDs[0] == false && $SubmIDs[1] == false && $SubmIDs[2] == false)
        {
            if ($this->_debug) printf("$this->_cr updateProducts() function. $this->_att Error. There are no products to update. All products are skipped. Function terminated. $this->_cr");
            return false;
        }
        return $SubmIDs;

    }

    public function partiallyUpdateProduct($SKU, $ProductIDType, $ProductIDCode, $ConditionType, $ConditionNote, $updatingType)
    {
        if ($this->_debug) printf("$this->_cr artiallyUpdateProduct() call. All checkings and operations will made in the partiallyUpdateProducts() function. Now an object array creation...  $this->_cr");
        $products = array();
        $products[0]['SKU'] = $SKU;
        $products[0]['ProductIDType'] = $ProductIDType;
        $products[0]['ProductIDCode'] = $ProductIDCode;
        $products[0]['ConditionType'] = $ConditionType;
        $products[0]['ConditionNote'] = $ConditionNote;
        if ($this->_debug) printf("$this->_cr partiallyUpdateProduct() function. Calling of the partiallyUpdateProducts() function... $this->_cr");
        $data = $this->partiallyUpdateProducts($products, $updatingType);
        if ($this->_debug)
        {
            if($data == false)
                printf("$this->_cr partiallyUpdateProduct() function is finished $this->_att with an error $this->_cr");
            else
                printf("$this->_cr partiallyUpdateProduct() function is finished successfully here $this->_cr");
        }
        return $data;
    }


    //add single product
    //All parameters must be specified!!!
    /* It is not recommended to use this function if you want to add many products at once.
     * Amazon may limit the number of requests from each seller account.
     * you can read more about throttling at
     * Now we make 3 request to the SubmitFeed operation.
     * You can find information about how many requests to the SubmitFeed operation we can submit each time, in that pdf document (page #10),
     * but that information, unfortunatelly, can be not fully correct.
     * In case, if request is throttled, you get an
     * MarketplaceWebService_Exception
    */
    //will return an array with 3 (three) submission IDs (we make 3 requets to the Web Service, so we have 3 submission IDs)
    //or false (if an error occurred)
    public function addProduct($SKU, $ProductIDType, $ProductIDCode, $ConditionType, $ConditionNote, $Quantity, $Price)
    {
        if ($this->_debug) printf("$this->_cr addProduct call. It will construct an object massive and sends it to the addProducts() function. All verifications (checkings) and operations will be performed there. $this->_cr");
        if ($this->_debug) printf("$this->_cr addProduct function. Creation of the object array starts here. (\$products[0]['SKU'] = \$SKU , etc.)...$this->_cr");
        $products = array();
        $products[0]['SKU'] = $SKU;
        $products[0]['ProductIDType'] = $ProductIDType;
        $products[0]['ProductIDCode'] = $ProductIDCode;
        $products[0]['ConditionType'] = $ConditionType;
        $products[0]['ConditionNote'] = $ConditionNote;
        $products[0]['Quantity'] = $Quantity;
        $products[0]['Price'] = $Price;
        if ($this->_debug) printf("$this->_cr addProduct function. Creation of the object array is finished. Calling addProducts() function... $this->_cr");
        $data = $this->addProducts($products);
        if ($this->_debug)
        {
            $state;
            if ($data == false) $state = "$this->_att with an error";
            else $state = "successfully";
            printf("$this->_cr addProduct function. Function execution is completed $state $this->_cr");
        }
        return $data;
    }
    
    /**
     *Update condition of existing single product
     * @param <type> $cond - object massive
     * $cond[$i]['SKU']
     * $cond[$i]['ConditionType']
     * $cond[$i]['ConditionNote']
     *  @return <int> - SubmissionID or false if unsuccessful
     */
    public function updateCondition($SKU, $ConditionType, $ConditionNote)
    {
        if ($this->_debug) printf("$this->_cr updateCondition() function. starts here $this->_cr");
        $products = array();
        $products[0]['SKU'] = $SKU;
        $products[0]['ConditionType'] = $ConditionType;
        $products[0]['ConditionNote'] = $ConditionNote;
        if ($this->_debug) printf("$this->_cr  function. $this->_cr");

        $data = $this->partiallyUpdateProducts($products);

        if ($this->_debug)
        {
            if($data == false)
                printf("$this->_cr updateCondition() function is finished $this->_att with an error $this->_cr");
            else
                printf("$this->_cr updateCondition() function is finished successfully here $this->_cr");
        }
        return $data;
    }




    /**
     *
     * @param <type> $products - object array
     * $products[$i]['SKU'] - must be not null
     * $products[$i]['Quantity'] - must be not null
     * @return <int> - FeedSubmissionID or false (if an error occurred)
     */
    public function updateQuantities($products)
    {
        if ($this->_debug) printf("$this->_cr updateQuantities() call, checking input arguments ...  $this->_cr");
        //checking input arguments
        for ($i=0; $i<count($products); $i++)
        {
            if ($this->_debug) printf("$this->_cr updateQuantities() function. \$products[$i] checking...  $this->_cr");
            if (!$this->checkSKU($products[$i]['SKU']))
            {
                $SKUValue = $products[$i]['SKU'];
                if ($this->_debug) printf("$this->_cr updateQuantities() function. $this->_att Warning. \$products[$i]['SKU'] = $SKUValue is incorrect. Please verify this... Function skips this product and continue excution.  $this->_cr");
                //return false;
                $products[$i] = null;
                continue;
            }
            if (!$this->checkQuantity($products[$i]['Quantity']) /* ||
                    $products[$i]['Quantity']==null*/)
            {
                $QuantityValue = $products[$i]['Quantity'];
                if ($this->_debug) printf("$this->_cr updateQuantities() function. $this->_att Warning. \$products[$i]['Quantity'] = $QuantityValue is incorrect. Please verify this... Function skips this product and continue excution. $this->_cr");
                //return false;
                $products[$i] = null;
                continue;
            }
        }


        //if there is no Quantities to update, function will be terminated
        for ($i=0; $i<count($products); $i++)
        {
            if ($products[$i]!=null) break;
            if ($i == count($products)-1)
            {
                if ($this->_debug) printf("$this->_cr updateQuantities() function. We have no Quantities to update (or all the instances are skipped). Function is finished with $this->_att an Error. $this->_cr");
                return false;
            }
        }

        $Document = new DOMDocument();
        $Messages = array();

        if ($this->_debug) printf("$this->_cr  updateQuantities() function. Creation of the QuantityMessages starts here  $this->_cr");
        $m = 0;
        for ($i=0; $i<count($products); $i++)
        {
            if ($products[$i]!=null)
            {
                $Messages[$m] = $this->createQuantityMessage($Document, $products[$i]['SKU'], $products[$i]['Quantity'], $m+1);
                $m++;
            }
            else
            {
                if ($this->_debug) printf("$this->_cr  updateQuantities() function. Incorrect product. Creation of the QuantityMessages skipped  $this->_cr");
            }
        }
        $feedDOM = $this->CreateFeed($Document, "Product", $Messages);
        $feed = $feedDOM->saveXML();
        $data = $this->processFeed("_POST_INVENTORY_AVAILABILITY_DATA_", $feed);
        if ($this->_debug)
        {
            if($data == false)
                printf("$this->_cr updateQuantities() function is finished $this->_att with an error $this->_cr");
            else
                printf("$this->_cr updateQuantities() function is finished successfully here $this->_cr");
        }
        return $data;
    }
    
    
    public function updateQuantity($SKU, $Quantity)
    {
       if ($this->_debug) printf("$this->_cr updateQuantity() call, creating an object array... $this->_cr");
       $products = array();
       $products[0]['SKU'] = $SKU;
       $products[0]['Quantity'] = $Quantity;
       if ($this->_debug) printf("$this->_cr updateQuantity() function. Calling the updateQuantities() function...  $this->_cr");
       $data = $this->updateQuantities($products);
       if ($this->_debug)
            if ($data == false) if ($this->_debug) printf("$this->_cr updateQuantity() function is finished with $this->_att an error. $this->_cr");
            else if ($this->_debug) printf("$this->_cr updateQuantity() function is finished successfully. $this->_cr");
       return $data;
    }

    public function updatePrices($products)
    {
        if ($this->_debug) printf("$this->_cr updatePrices() call, checking input arguments... $this->_cr");
        //checking input arguments
        for ($i=0; $i<count($products); $i++)
        {
            if ($this->_debug) printf("$this->_cr updatePrices() function. Checking \$products[$i]... $this->_cr");
            if ($this->checkSKU($products[$i]['SKU']) == false ||
                    ($products[$i]['Price'] = $this->checkPrice($products[$i]['Price'])) == false)
            {
                if ($this->_debug)
                {
                    $value1 = $products[$i]['SKU'];
                    $value2 = $products[$i]['Price'];
                    printf("$this->_cr updatePrices() function. $this->_att an Warning occured during the test of the $i-th argument
                        There are values:$this->_cr
                        \$products[\$i]['SKU']: $value1 $this->_cr
                        \$products[\$i]['Price']: $value2 $this->_cr
                        Function skips this item and continue xecution $this->_cr");
                }
                //return false;
                $products[$i] = null;
                continue;
            }
        }

        if ($this->_debug) printf("$this->_cr updatePrices() function. Checking input arguments completed $this->_cr");


        //if there is no Prices to update, function will be terminated
        for ($i=0; $i<count($products); $i++)
        {
            if ($products[$i]!=null) break;
            if ($i == count($products)-1)
            {
                if ($this->_debug) printf("$this->_cr updatePrices() function. We have no Prices to update (or all the instances are skipped). Function is finished with $this->_att an Error. $this->_cr");
                return false;
            }
        }

        $Document = new DOMDocument();
        $Messages = array();
        if ($this->_debug) printf("$this->_cr updatePrices() function. Creating messages here (based on the input arguments) $this->_cr");
        $m = 0;
        for ($i=0; $i<count($products); $i++)
        {
            if ($products[$i] != null)
            {
                if ($this->_debug) printf("$this->_cr updatePrices() function. The $i-th message creation... $this->_cr");
                $Messages[$m] = $this->createPriceMessage ($Document, $products[$i]['SKU'], $products[$i]['Price'], $m+1);
                $m++;
            }
            else
            {
                if ($this->_debug) printf("$this->_cr updatePrices() function. The $i-th message creation skipped $this->_cr");
            }
        }

        if ($this->_debug) printf("$this->_cr updatePrices() function. Calling the CreateFeed() function ... $this->_cr ");
        $feedDOM = $this->CreateFeed($Document, "Price", $Messages);
        $feed = $feedDOM->saveXML();

        if ($this->_debug) printf("$this->_cr updatePrices() function. Calling processFeed() function here $this->_cr");
        $data = $this->processFeed("_POST_PRODUCT_PRICING_DATA_", $feed);

        if ($this->_debug)
        {
            if($data == false)
                printf("$this->_cr updatePrices() function is finished $this->_att with an error $this->_cr");
            else
                printf("$this->_cr updatePrices() function is finished successfully here $this->_cr");
        }

        return $data;
    }

    public function updatePrice($SKU, $Price)
    {
        if ($this->_debug) printf("$this->_cr updatePrice() call. $this->_cr");
        $products = array();
        $products[0]['SKU'] = $SKU;
        $products[0]['Price'] = $Price;
        if ($this->_debug) printf("$this->_cr updatePrice() function. updatePrices() function is calling here... $this->_cr");
        $data = $this->updatePrices($products);
        if ($this->_debug)
        {
            if($data == false)
                printf("$this->_cr updatePrice() function is finished $this->_att with an error $this->_cr");
            else
                printf("$this->_cr updatePrice() function is finished successfully here $this->_cr");
        }
        return $data;
    }


       /**
     *Delete products from seller account
     * @param <type[]> $products - array of unique products
     * @return <int> - FeedSubmissionId or false if an error occured
     */
    public function deleteProducts($products)
    {
        if ($this->_debug) printf("$this->_cr deleteProducts() call. $this->_cr");
        //check input arguments
        for ($i=0; $i<count($products); $i++)
            if (!$this->checkSKU($products[$i]['SKU']))
            {
                if ($this->_debug) printf("$this->_cr deleteProducts() function. $this->_att Warning. You sent product with incorrect SKU. \$products[$i]['SKU'] . Please verify it. We skip this product $this->_cr");
                //return false;
                $products[$i] = null;
            }

        //existing SKUs
        $eSKUs = array();
        if ($this->_debug)
        {
            $n = count($products);
            printf("$this->_cr deleteProducts() function. You sent $n Products $this->_cr");
        }
        for ($i = 0; $i<count($products); $i++)
            if ($products[$i]['SKU'] != null) $eSKUs[] = $products[$i]['SKU'];

        if ($this->_debug)
        {
            $n = count($eSKUs);
            printf("$this->_cr deleteProducts() function. After skipping remains $n SKUs $this->_cr");
        }
        if (count($eSKUs)==0)
        {
            if ($this->_debug) printf("$this->_cr deleteProducts() function. $this->_att Error. There is no products to delete. Function terminated. $this->_cr");
            return false;
        }
        $SKUs = $eSKUs;

        $xml = new DOMDocument();
        $Messages = array();
        for ($i=0; $i<count($SKUs); $i++)
        {
            if ($this->_debug) printf("$this->_cr deleteProducts() function. Creation of the $i-th message. $this->_cr");
            $Messages[$i] = $this->createDelMessage ($xml, $i+1, $SKUs[$i]);
        }
        ////$message;
        if ($this->_debug) printf("$this->_cr deleteProducts() function. Calling the CreateFeed() function here $this->_cr");
        $feedDOM = $this->CreateFeed($xml, "Product", $Messages);
        $feed = $feedDOM->saveXML();

        //$feed = "<AmazonEnvelope xsi:noNamespaceSchemaLocation=\"amzn-envelope.xsd\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><Header><DocumentVersion>1.01</DocumentVersion><MerchantIdentifier>AMXABK87V96I9</MerchantIdentifier></Header><MessageType>Product</MessageType><Message><MessageID>1</MessageID><OperationType>Delete</OperationType><Product><SKU>15</SKU></Product></Message></AmazonEnvelope>";
        if ($this->_debug) printf("$this->_cr deleteProducts() function. Start processing feed here $this->_cr");
        $data = $this->processFeed("_POST_PRODUCT_DATA_", $feed);
        if ($this->_debug)
        {
            if($data == false)
                printf("$this->_cr deleteProducts() function is finished $this->_att with an error $this->_cr");
            else
                printf("$this->_cr deleteProducts() function is finished successfully here $this->_cr");
        }
        return $data;
    }




    public function deleteProduct($product)
    {
        if ($this->_debug)
        {
            $skuu = $product[$i]['SKU'];
            printf("$this->_cr deleteProduct() call \$product['SKU'] = $skuu .All checks and operations will be performed after creation of the array $this->_cr");
        }
        if ($this->_debug) printf("$this->_cr deleteProduct() function. creates an array... $this->_cr");
        $products = array();
        $products[0] = $product;
        if ($this->_debug) printf("$this->_cr deleteProduct() function. finish to create array. Calling deleteProducts() function... $this->_cr");
        $State = $this->deleteProducts($products);
        if ($State == false)
            if ($this->_debug) printf("$this->_cr deleteProduct() function is finished with $this->_att an error. $this->_cr");
        else
            if ($this->_debug) printf("$this->_cr deleteProduct() function is completed successfully. $this->_cr");
       return $State;
    }

    public function  getOrderById ($amazonOrderId)
    {
        $params = array();
        $params['Action'] = 'GetOrder';
        $params['AmazonOrderId.Id.1'] = $amazonOrderId;
        $params['SellerId'] = $this->mid;
        $params['SignatureVersion'] = '2';
        $params['SignatureMethod'] = 'HmacSHA256';
        $data = $this->_callWSs('Orders', $params);

        if ($data === false)
        {
            if ($this->_debug) printf("$this->_cr $this->_att An error happened during GetOrder request $this->_cr");
            return false;
        }

        if ($this->_debug)
        {
            $d = $data->saveXML();
            printf("$this->_cr getOrderById function got following response from the Orders WebService: $this->_cr
             $d $this->_cr");
        }

        $data = $data->GetOrderResult->Orders;

        if ($data->Order[0] == null)
        {
            if ($this->_debug) printf("$this->_cr getOrderById function. $this->_att No orders available (It seems, that you sent incorrect OrderId). Function returns false $this->_cr");
            return false; // no orders available
        }

        $itemsXml = $this->getOrderItemsXml($data->Order[0]->AmazonOrderId);
        if ($itemsXml === false)
        {
            if ($this->_debug) printf ("$this->_cr $this->_att An error happened during items xml request $this->_cr");
            return false;
        }

        if ($this->_debug == true)
        {
            $d = $itemsXml->saveXML();
            printf("$this->_cr getOrderById function(). We get next Item xml from the order: $this->_cr $d $this->_cr");
        }

        //$ItemsSimpleXMLElement = new SimpleXMLElement($itemsXml);
        $ItemsSimpleXMLElement = $itemsXml->ListOrderItemsResult->OrderItems;
        $Order = new PlacedOrder($data->Order[0], $ItemsSimpleXMLElement, $this->_debug);

        return $Order;
    }


    // Same function but with the recovery
    //
    public function _antithrottling($limit = 20, $per = 60, $recovery_time = 5, $action = 'SubmitFeed')
    {
      $now = microtime(true) ;
      $allowed = $per / $limit ;

      if ( ! isset($this->last_api_request) )
          $this->last_api_request = array() ;

      if (  ! isset( $this->elapsed_time ) || ! is_array( $this->elapsed_time ) )
           $this->elapsed_time = array() ;

      if ( ! isset($this->last_api_request[$action]) )
        $this->elapsed_time[$action] = 0 ;
      else
        $this->elapsed_time[$action] = ($now - $this->last_api_request[$action]) + $this->elapsed_time[$action] ;

      $seconds = number_format($this->elapsed_time[$action],2) * 100 ;

      if ( ! isset($this->recover) )
        $this->recover = array() ;

      if ( ! isset($this->recover[$action]) )
        $this->recover[$action] = 0 ;

      $this->recover[$action] += $seconds ;

      if ( $this->recover[$action] > $seconds + $recovery_time )
      {
        if ($this->_debug)
            printf("Date : %s - second is : %s recovery is : %s allow a new action\n", date('h:m:s'), $seconds,  $this->recover[$action]);
        $recover_now = true ;
        $this->recover[$action] =+ $recovery_time ;
      }
      else $recover_now = false  ;

      if ( intval($seconds) > $allowed && $recover_now == false )
      {
        if ($this->_debug)
            print("Sleeping $allowed seconds\n") ;
        sleep($allowed) ;
        $this->elapsed_time[$action] = 0 ;
      }
      else
      {
        if ($recover_now)
        {
            if ($this->_debug)
                print("This is a recovered request !\n") ;
        }
        else
         sleep($allowed) ;
      }
      $this->last_api_request[$action] = microtime(true) ;
    }

    function _callWSs($WSTR, $params, $feedContent = NULL/*$handle = NULL*//*, $contentMD5 = NULL*/)
    {
        if ($this->_debug) printf ("$this->_cr _callWSs() finction starts here $this->_cr");
        $contentMD5 = NULL;
        $handle = NULL;
        if (!($feedContent === NULL))
        {
            if ($this->_debug) printf ("$this->_cr We have feed content. It seems, that this operation is to submit feed. Calculating MD5 for this feed... $this->_cr");
            $contentMD5 = $ContentMd5 = base64_encode(md5($feedContent, true));
            if ($this->_debug) printf ("$this->_cr Now we start to work we handle to upload data to the server $this->_cr");
            $handle = @fopen('php://temp', 'rw+');
            fwrite($handle, $feedContent);
            rewind ($handle);
        }

        $method = "POST";

        $host = "mws.amazonservices.".$this->region;
        $uri = NULL;
        if (!($WSTR === 'Feeds' || $WSTR === 'Orders'))
        {
            if ($this->_debug)
                printf("$this->_cr $this->_att Error. Icorrect WebService $this->_cr");
            return false;
        }
        switch ( $params['Action'] )
        {
          case 'ListMatchingProducts' :
            $this->_antithrottling(20, 60, 5, 'ListMatchingProducts') ;
            break ;

          case 'ListOrders ' :
            $this->_antithrottling(6, 60, 60, 'ListOrders') ;
            break ;
          case 'ListOrdersByNextToken' :
            $this->_antithrottling(6, 60, 60, 'ListOrdersByNextToken') ;
            break ;

          case 'GetOrder' :
            $this->_antithrottling(6, 60, 2, 'GetOrder') ;
            break ;

          case 'ListOrderItems' :
            $this->_antithrottling(30, 60, 6, 'ListOrderItems') ;
            break ;

          case 'ListOrderItemsByNextToken ' :
            $this->_antithrottling(30, 60, 6, 'ListOrderItemsByNextToken') ;
            break ;

          case 'SubmitFeed' :
            $this->_antithrottling(15, 60, 5, 'SubmitFeed') ;
            break ;

          default:
            if ($this->_debug)
                printf("$this->_cr. Unknown action for antithrottling: %s $this->_cr", $params['Action']);

            $this->_antithrottling(10, 60, 5, $params['Action']) ;
            break ;

        }


        if ($WSTR == 'Feeds')
            $uri = '/';
        if ($WSTR == 'Orders')
            $uri = '/Orders/';


        // additional parameters
        $params["AWSAccessKeyId"] = $this->awsak;

        // GMT timestamp
        $params["Timestamp"] = gmdate("Y-m-d\TH:i:s\Z");

        // set up API version
        if ($WSTR == 'Feeds')
            $params["Version"] = "2009-01-01";
        else
            $params["Version"] = "2011-01-01";

        // sort the parameters
        ksort($params);

        // create the canonicalized query
        $canonicalized_query = array();

        foreach ($params as $param=>$value)
        {
            $param = str_replace("%7E", "~", rawurlencode($param));
            $value = str_replace("%7E", "~", rawurlencode($value));
            $canonicalized_query[] = $param."=".$value;
        }

        $canonicalized_query = implode("&", $canonicalized_query);

        // create the string to sign
        $string_to_sign = $method."\n".$host."\n".$uri."\n".$canonicalized_query;


        // calculate HMAC with SHA256 and base64-encoding
        $signature = base64_encode(hash_hmac("sha256", $string_to_sign, $this->sk, True));

        // encode the signature for the request
         $signature = str_replace("%7E", "~", rawurlencode($signature));


        //open connection
        $ch = curl_init();

        //working with headers
        $header = NULL;
        if ($WSTR === 'Feeds')
        {
            $header = array (
            'Expect: ',
            'Accept: ',
            'Transfer-Encoding: chunked',
            'Content-Type: application/x-www-form-urlencoded; charset=utf-8',
            'Content-MD5: ' . $contentMD5 //base64_encode(md5_file($config['FeedFileName'], true))
            );
        }

        $curlOptions = array (
            CURLOPT_POST => true,
            CURLOPT_USERAGENT => '<Your Application Name>/<Your Version or Build Number> (Language=PHP/' . phpversion() . ')',
            CURLOPT_RETURNTRANSFER => true,
            );

        if ($WSTR === 'Feeds')
        {
            $curlOptions[CURLOPT_HTTPHEADER] = $header;
            $curlOptions[CURLOPT_INFILE] = $handle;
            $curlOptions[CURLOPT_URL] = "https://".$host.$uri."?".$canonicalized_query."&Signature=".$signature;
        }
        else
        {
            $curlOptions[CURLOPT_URL] = "https://".$host.$uri;
            $curlOptions[CURLOPT_POSTFIELDS] = $canonicalized_query."&Signature=".$signature;
        }
        if ($this->_debug)
        {
            echo("$this->_cr Request is: ".$curlOptions[CURLOPT_URL]."$this->_cr");
        }
        $curlOptions[CURLOPT_SSL_VERIFYPEER] = false;
        $curlOptions[CURLOPT_VERBOSE] = true;


        $curlHandle = curl_init();
        curl_setopt_array($curlHandle, $curlOptions);

        $result = curl_exec($curlHandle);

        if ($this->_debug)
        {
            echo "Params: $this->_cr" ;
            echo nl2br(print_r($params, true)) ;
            echo "CURL Data: $this->_cr" ;
            echo nl2br(print_r($result, true)) ;
            echo $this->_cr ;
            echo nl2br(print_r(curl_getinfo($this->curlHandle), true));  // get error info
            echo "cURL error number:" .curl_errno($this->curlHandle) . $this->_cr   ; // print error info
            echo "cURL error:" . curl_error($this->curlHandle) . $this->_cr   ;
        }

        if ($WSTR === 'Feeds')
            fclose($handle);
        curl_close($curlHandle);


        if ($result === false)
        {
            if ($this->_debug) printf("$this->_cr $this->_att Error!! \$result === fasle");
            return false;
        }

        $pxml = new SimpleXMLElement($result);

        if ($pxml === false)
        {
            if ($this->_debug) printf("ERROR! no xml (\$pxml === false)");
            return false; // no xml
        }

        if ($pxml->getName() === 'ErrorResponse')
        {
            if ($this->_debug)
            {
                $r = $pxml->saveXML();
                printf("$this->_cr WebService returns error response. Function _callWSs() returns false. We have got following error response: $this->_cr
                   $r $this->_cr");
                echo nl2br(print_r($r,true));
            }
            return false;
        }

        if ($this->_debug)
        {
            $r = $pxml->saveXML();
            printf ("$this->_cr Request completed successfully. Function returns simpleXml element. Response is $this->_cr
                   $r $this->_cr");
        }

        return $pxml;
    }



     /**
     * Get all currently unshipped orders, that were placed by customer before specified date
     * @param <string> $createdAfterDate - Date in format "yyy-mm-dd" (including this date)
     * @param <string> $createdBeforeDate - [optional] Date in format "yyy-mm-dd" (excluding this date)
     * @return PlacedOrder[] Massive of instances of the PlecedOrder class,
     *                         that represents all unshipped orders
     */
    //Status can be All, Unshipped, Shipped, Canceled, PartiallyShipped, Pending (Order placed, but payment not authorized, not ready for shipment)
    //Unshipped orders include also PartiallyShipped Orders, becouse this two statuses must be used together in Orders API
    public function GetUnshippedOrdersList($createdAfterDate, $createdBeforeDate = null, $Status = 'All')
    {
        if ($this->_debug == true) printf("$this->_cr GetUnshippedOrdersList call. $this->_cr");

        $params = array();
        $params['Action'] = 'ListOrders';
        $params['CreatedAfter'] = $createdAfterDate;
        if ($createdBeforeDate != null)
            $params['CreatedBefore'] = $createdBeforeDate;
        $params['SellerId'] = $this->mid;
        $params['SignatureVersion'] = '2';
        $params['SignatureMethod'] = 'HmacSHA256';
        $params['MarketplaceId.Id.1'] = $this->mpid;
        if ($Status == 'Unshipped' || $Status == 'PartiallyShipped')
        {
            $params['OrderStatus.Status.1'] = "Unshipped";
            $params['OrderStatus.Status.2'] = "PartiallyShipped";
        }
        else
        {
            if ($Status != 'All')
            {
                $params['OrderStatus.Status.1'] = $Status;
            }
        }

        if ($this->_debug == true) printf("$this->_cr GetUnshippedOrdersList function. Start request $this->_cr");

        $data = $this->_callWSs('Orders', $params);

        if ($this->_debug)
        {
            $d = $data->saveXML();
            printf( "$this->_cr $d <$this->_cr");
        }

        if ( isset($data->ListOrdersResult->NextToken) )
          $nextToken = $data->ListOrdersResult->NextToken ;
        else
          $nextToken = null ;

        if ( isset($data->ListOrdersResult) )
        {
         $data = $data->ListOrdersResult->Orders;
        }

         if ($data == null) return false; // no orders available
         $Orders = Array();

         if ($this->_debug == true) printf("$this->_cr GetUnshippedOrdersList function(). Start creating orders class instances. $this->_cr");
         for($i=0; ; $i++)
         {

             if ($data->Order[$i] == null)
             {
                 if ($i == 0) return false; // no orders available
                 break; //orders ended
             }

             $Orders[$i] = new PlacedOrder($data->Order[$i], NULL, $this->_debug);
         }
         while ( $nextToken )
            $nextToken = $this->GetOrdersByNextToken($nextToken, $Orders) ;

         return $Orders;
    }
    public function GetOrdersByNextToken($token, &$Orders)
    {
        if ($this->_debug == true) printf("$this->_cr GetOrdersByNextToken call. $this->_cr");

        $params = array();
        $params['Action'] = 'ListOrdersByNextToken';
        $params['NextToken'] = $token;
        $params['SellerId'] = $this->mid;
        $params['SignatureVersion'] = '2';
        $params['SignatureMethod'] = 'HmacSHA256';
        $params['MarketplaceId.Id.1'] = $this->mpid;

        if ($this->_debug == true) printf("$this->_cr GetOrdersByNextToken function. Start request - Token: %s $this->_cr", $token);

        $data = $this->_callWSs('Orders', $params);

        if ($this->_debug)
        {
            $d = $data->asXML() ;
            printf( "$this->_cr $d <$this->_cr");
        }

        if ( isset($data->ListOrdersByNextTokenResult->NextToken) )
          $nextToken = $data->ListOrdersByNextTokenResult->NextToken ;
        else
          $nextToken = null ;

        if ( isset($data->ListOrdersByNextTokenResult) )
        {
         $data = $data->ListOrdersByNextTokenResult->Orders;
        }

        if ($data == null) return false; // no orders available

         if ($this->_debug == true) printf("$this->_cr GetOrdersByNextToken function(). Start creating orders class instances. $this->_cr");

         for($i=sizeof($Orders), $j=0; ; $i++,$j++)
         {
             if ($data->Order[$j] == null)
             {
                 if ($j == 0) return false; // no orders available
                 break; //orders ended
             }

             $Orders[$i] = new PlacedOrder($data->Order[$j], NULL, $this->_debug);
         }
         return($nextToken) ;
    }

    /**
     *Confirm shipment many orders at once.
     *
     * !!!!Please Note, that this operation have to send time information to the WebService
     * !!!!Time represents moment, when order were shipped
     * !!!!This functions send time, that are on one hour before current system date
     * !!!!If system time is incorrect and function sends date from the future,
     * !!!!Error will be occured and operation will be not completed correctly.
     *
     * After this operation customer will be charged, and seller will be credited.
     * @param <type> $ordersIDs - massive from OrderIDs
     * @return <int> - Feed SubmissionID
     */
    public function confirmShipmentOrdersByIDs ($ordersIDs)
    {
        if ($this->_debug == true) printf("$this->_cr confirmShipmentOrders call. $this->_cr");
        $Document = new DOMDocument();
        $Messages = array();

        if ($this->_debug == true) printf("$this->_cr confirmShipmentOrders function. Create messages here $this->_cr");
        for ($i=0; $i<count($ordersIDs); $i++)
        {
            if ($this->_debug == true)
            {
                $m = $i+1;
                printf("$this->_cr confirmShipmentOrders function. Create message $m orderID: $ordersIDs[$i] $this->_cr");
            }
            $Messages[$i] = $this->createOrderFulfillmentMessage ($Document, $ordersIDs[$i], $i+1);
        }

        $feedDOM = $this->CreateFeed($Document, "OrderFulfillment", $Messages);
        $feed = $feedDOM->saveXML();

        if ($this->_debug == true) printf("$this->_cr confirmShipmentOrders function. Now we send following query to WebService:  $this->_cr $feed $this->_cr");

        $data =  $this->processFeed("_POST_ORDER_FULFILLMENT_DATA_", $feed);
        if ($data == false && $this->_debug == true)
        {
            printf("$this->_cr confirmShipmentOrders function finished with an error becouse of the prblem with query sending.. $this->_cr");
        }
        else
        {
            if ($this->_debug == true) printf("$this->_cr confirmShipmentOrders function finished successfuly $this->_cr");
        }
        return $data;
    }

    /**
     *
     * !!!!Please Note, that this operation have to send time information to the WebService
     * !!!!Time represents moment, when order were shipped
     * !!!!This functions send time, that are on one and a half hour before current system date
     * !!!!If system time is incorrect and function sends date from the future,
     * !!!!Error will be occured and operation will be not completed correctly.
     *
     * @param <type> $Orders
     * @return <int> SumbissionId or false if unsuccessful
     */
    public function confirmOrderBase ($amazonOrderId)
    {
        return $this->confirmOrder($amazonOrderId, NULL, NULL, NULL);
    }

    public function confirmOrder ($amazonOrderId, $carrierName, $shippingMethod, $shipperTrackingNumber)
    {

        if ($this->_debug == true) printf("$this->_cr confirmOrder call. $this->_cr");
        $Document = new DOMDocument();
        $Messages = array();

        if ($this->_debug == true) printf("$this->_cr confirmOrder function. Create messages here $this->_cr");

        $Messages[0] = $this->createOrderFulfillmentMessage($Document, $amazonOrderId, $carrierName, $shippingMethod, $shipperTrackingNumber, 1);


        $feedDOM = $this->CreateFeed($Document, "OrderFulfillment", $Messages);
        $feed = $feedDOM->saveXML();

        if ($this->_debug == true) printf("$this->_cr confirmOrder function. Now we send following query to WebService:  $this->_cr $feed $this->_cr");

        $data =  $this->processFeed("_POST_ORDER_FULFILLMENT_DATA_", $feed);
        if ($data == false && $this->_debug == true)
        {
            printf("$this->_cr confirmShipmentOrders function finished with an error becouse of the prblem with query sending.. $this->_cr");
        }
        else
        {
            if ($this->_debug == true) printf("$this->_cr confirmShipmentOrders function finished successfuly $this->_cr");
        }
        return $data;

    }

    //use this function for one order cancelation
    public function cancelOrder($Order)
    {
        $Orders = array();
        $Orders[0] = $Order;
        return $this->cancelOrders($Orders);
    }

    public function cancelOrderByID ($OrderID)
    {
        $OrderIDs = array();
        $OrderIDs[0] = $OrderID;
        return $this->cancelOrdersByIDs($OrderIDs);
    }


    /**
     *Orders Cancelation
     * @param <type> $OrderIDs
     * @return <type> - Feed Submission ID
     */
    public function cancelOrdersByIDs($OrderIDs)
    {
        if ($this->_debug == true) printf("$this->_cr cancelOrders() call. Creating Messages. $this->_cr");
        $Document = new DOMDocument();
        for ($i=0; $i<count($OrderIDs); $i++)
        {
            if ($this->_debug == true)
            {
                $m = $i+1;
                printf("$this->_cr cancelOrders() call. Creating Message $m for OrderID $OrderIDs[$i]. $this->_cr");
            }
            $mess = $this->createOrderAcknowledgementMessage($Document, $OrderIDs[$i], $i+1);
        }

        $Messages = array();
        $Messages[0] = $mess;
        $feedDOM = $this->CreateFeed($Document, "OrderAcknowledgement", $Messages);
        $feed = $feedDOM->saveXML();

         if ($this->_debug == true) printf("$this->_cr cancelOrders() function. Now function creates the following feed: $this->_cr $feed $this->_cr");

        $data =  $this->processFeed("_POST_ORDER_ACKNOWLEDGEMENT_DATA_", $feed);

        if ($data == false && $this->_debug == true)
        {
            printf("$this->_cr cancelOrders() function finished with an error becouse of the prblem with query sending.. $this->_cr");
        }
        else
        {
            if ($this->_debug == true) printf("$this->_cr cancelOrders() function finished successfuly $this->_cr");
        }
        return $data;
    }

    public function cancelOrders($Orders)
    {
        if ($this->_debug == true) printf("$this->_cr cancelOrders() call. Creating Messages. $this->_cr");
        $Document = new DOMDocument();
        for ($i=0; $i<count($Orders); $i++)
        {
            if ($this->_debug == true)
            {
                $m = $i+1;
                $oid = $Orders[$i]->AmazonOrderId;
                printf("$this->_cr cancelOrders() call. Creating Message $m for OrderID $oid. $this->_cr");
            }
            $mess = $this->createOrderAcknowledgementMessage($Document, $Orders[$i]->AmazonOrderId, $i+1);
        }

        $Messages = array();
        $Messages[0] = $mess;
        $feedDOM = $this->CreateFeed($Document, "OrderAcknowledgement", $Messages);
        $feed = $feedDOM->saveXML();

         if ($this->_debug == true) printf("$this->_cr cancelOrders() function. Now function creates the following feed: $this->_cr $feed $this->_cr");

        $data =  $this->processFeed("_POST_ORDER_ACKNOWLEDGEMENT_DATA_", $feed);

        if ($data == false && $this->_debug == true)
        {
            printf("$this->_cr cancelOrders() function finished with an error becouse of the prblem with query sending.. $this->_cr");
        }
        else
        {
            if ($this->_debug == true) printf("$this->_cr cancelOrders() function finished successfuly $this->_cr");
        }
        return $data;
    }

    /**(private)
     *Get ordered items (products) from the concrete order
     * @param <string> $AmazonOrderId
     * @return <string>Xml presented in the string
     */
    private function getOrderItemsXml($AmazonOrderId)
    {
        $params = array();
        $params['Action'] = 'ListOrderItems' ;
        $params['AmazonOrderId'] = $AmazonOrderId;
        $params['SellerId'] = $this->mid;
        $params['SignatureVersion'] = '2';
        $params['SignatureMethod'] = 'HmacSHA256';

        $response = $this->_callWSs('Orders', $params);

        if ($this->_debug)
        {
            $d = NULL;
            if (!($response === false))
                $d = $response->saveXML();
            else
                $d = false;
            printf("$this->_cr getOrderItemsXml() function. WebService response is: $this->_cr
                    $d $this->_cr");
        }
        
        return $response;
    }

    private function CreateFeed (DOMDocument $Document, $MessageType, $Messages)
    {
        if ($this->_debug) printf("$this->_cr CreateFeed() call $this->_cr");
        $FeedXmlDocument = $Document;
        $FeedXmlRootElement = $FeedXmlDocument->createElement("AmazonEnvelope");
        $FeedXmlRootElement->setAttribute("xsi:noNamespaceSchemaLocation", "amzn-envelope.xsd");
        $FeedXmlRootElement->setAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
        $FeedXmlDocument->appendChild($FeedXmlRootElement);
        $header = $FeedXmlDocument->createElement("Header");
        $DocumentVersion = $FeedXmlDocument->createElement("DocumentVersion");
        $header->appendChild($DocumentVersion);
        $DocumentVersionText = $FeedXmlDocument->createTextNode("1.01");
        $DocumentVersion->appendChild($DocumentVersionText);
        $FeedXmlRootElement->appendChild($header);
        $MerchantIdentifier = $FeedXmlDocument->createElement("MerchantIdentifier");
        $header->appendChild($MerchantIdentifier);
        $MerchantIdentifierText = $FeedXmlDocument->createTextNode($this->mid);
        $MerchantIdentifier->appendChild($MerchantIdentifierText);
        $MessageTypeX = $FeedXmlDocument->createElement("MessageType");
        $FeedXmlRootElement->appendChild($MessageTypeX);
        $MessageTypeText = $FeedXmlDocument->createTextNode($MessageType);
        $MessageTypeX->appendChild($MessageTypeText);

        //adding messages
        for ($i=0; $i<count($Messages); $i++)
          $FeedXmlRootElement->appendChild ($Messages[$i]);

        return $FeedXmlDocument;
    }


    private function processFeed($feedType, $feedContent)
    {
        if ($this->_debug)
        {
            printf("$this->_cr processFeed() function started.  $this->_cr
                Now we send following request to the WebService: $this->_cr
                \$feedType : $feedType $this->_cr
                \$feedContent:    $this->_cr
                   $feedContent  $this->_cr");
        }
        
        $feedHandle = @fopen('php://temp', 'rw+');
        fwrite($feedHandle, $feedContent);
        rewind ($feedHandle);

        $parameters = array (
            'Action' => 'SubmitFeed',
            'Marketplace' => $this->mpid,
            'Merchant' => $this->mid,
            'FeedType' => $feedType,
            'SignatureVersion' => 2,
            'SignatureMethod' => 'HmacSHA256',

        );


        $response = $this->_callWSs("Feeds", $parameters, $feedContent);
        //$response = $this->mws_signed_request("com", $parameters, $this->awsak, $this->sk);

        if ($response === false)
        {
            if ($this->_debug) printf ("response is false");
            return false;
        }
        return true;

    } 


    private function createOrderFulfillmentMessage(DOMDocument $Document, $AmazonOrderIDI, $CarrierNameI, $ShippingMethodI, $ShipperTrackingNumberI, $messageID)
    {
        $message = $Document->createElement("Message");
        $messageIDX = $Document->createElement("MessageID");
        $message->appendChild($messageIDX);
        $messageIDText = $Document->createTextNode($messageID);
        $messageIDX->appendChild($messageIDText);
        $OrderFulfillment = $Document->createElement("OrderFulfillment");
        $message->appendChild($OrderFulfillment);
        $AmazonOrderID = $Document->createElement("AmazonOrderID");
        $OrderFulfillment->appendChild($AmazonOrderID);
        $AmazonOrderIDText = $Document->createTextNode($AmazonOrderIDI);
        $AmazonOrderID->appendChild($AmazonOrderIDText);
        $FulfillmentDate = $Document->createElement("FulfillmentDate");
        $OrderFulfillment->appendChild($FulfillmentDate);
        $t = time() - 5400;
        date_default_timezone_set("Europe/Helsinki");
        $date = date("c", $t);
        $FulfillmentDateText = $Document->createTextNode($date);
        $FulfillmentDate->appendChild($FulfillmentDateText);

        //FulfillmentData
        if (!($CarrierNameI === null && $ShippingMethodI === null && $ShipperTrackingNumberI === null) )
        {
            $FulfillmentData = $Document->createElement("FulfillmentData");
            $OrderFulfillment->appendChild($FulfillmentData);
            if (!($CarrierNameI === null))
            {
                $CarrierName = $Document->createElement("CarrierName");
                $FulfillmentData->appendChild($CarrierName);
                $CarrierNameText = $Document->createTextNode($CarrierNameI);
                $CarrierName->appendChild($CarrierNameText);
            }
            if (!($ShippingMethodI === null))
            {
                $ShippingMethod = $Document->createElement("ShippingMethod");
                $FulfillmentData->appendChild($ShippingMethod);
                $ShippingMethodText = $Document->createTextNode($ShippingMethodI);
                $ShippingMethod->appendChild($ShippingMethodText);
            }
            if(!($ShipperTrackingNumberI === null))
            {
                $ShipperTrackingNumber = $Document->createElement("ShipperTrackingNumber");
                $FulfillmentData->appendChild($ShipperTrackingNumber);
                $ShipperTrackingNumberText = $Document->createTextNode($ShipperTrackingNumberI);
                $ShipperTrackingNumber->appendChild($ShipperTrackingNumberText);
            }
        }
        return $message;
    }

    private function createOrderAcknowledgementMessage(DOMDocument $Document, $OrderID, $messageID)
    {
        $message = $Document->createElement("Message");
        $messageIDX = $Document->createElement("MessageID");
        $message->appendChild($messageIDX);
        $messageIDText = $Document->createTextNode($messageID);
        $messageIDX->appendChild($messageIDText);
        $OrderAcknowledgement = $Document->createElement("OrderAcknowledgement");
        $message->appendChild($OrderAcknowledgement);
        $AmazonOrderID = $Document->createElement("AmazonOrderID");
        $OrderAcknowledgement->appendChild($AmazonOrderID);
        $AmazonOrderIDText = $Document->createTextNode($OrderID);
        $AmazonOrderID->appendChild($AmazonOrderIDText);
        $StatusCode = $Document->createElement("StatusCode");
        $OrderAcknowledgement->appendChild($StatusCode);
        $StatusCodeText = $Document->createTextNode("Failure");
        $StatusCode->appendChild($StatusCodeText);
        return $message;
    }

    private function checkSKU($SKU)
    {
        if ($SKU!=null) return true;
        return false;
    }

    private function checkProductIDType($ProductIDType)
    {
        if ($this->_debug) printf("$this->_cr  checkProductIDType call \$ProductIDType = $ProductIDType $this->_cr");
        if ($ProductIDType == "ISBN" || $ProductIDType == "UPC" || $ProductIDType == "EAN"
               || $ProductIDType == "ASIN" || $ProductIDType == "GTIN")
        {
            if ($this->_debug) printf("$this->_cr  checkProductIDType function is finished successfully. $this->_cr");
            return true;
        }
        if ($this->_debug) printf("$this->_cr  checkProductIDType function is finished with $this->_att an error. You sent incorrect input argument.  \$ProductIDType = $ProductIDType . Please verify it $this->_cr");
        return false;
    }


    private function checkConditionType($ConditionType)
    {
        if ($this->_debug) printf("$this->_cr  checkConditionType call \$ConditionType = $ConditionType $this->_cr");
         if ($ConditionType == "New" ||$ConditionType == "UsedLikeNew" || $ConditionType == "UsedVeryGood" ||
                $ConditionType == "UsedGood" || $ConditionType == "UsedAcceptable" ||
                $ConditionType == "CollectibleLikeNew" || $ConditionType == "CollectibleVeryGood" ||
                $ConditionType == "CollectibleGood" || $ConditionType == "CollectibleAcceptable" ||
                $ConditionType == "Refurbished" || $ConditionType == "Club")
         {
             if ($this->_debug) printf("$this->_cr checkConditionType function is finished successfully. $this->_cr");
             return true;
         }
         if ($this->_debug) printf("$this->_cr checkConditionType function is finished with $this->_att an error. You sent incorrect input argument.  \$ConditionType = $ConditionType . Please verify this $this->_cr");
         return false;
    }

    private function checkConditionNote($ConditionNote)
    {
        if ($this->_debug) printf("$this->_cr checkConditionNote call.$this->_cr");
        if(strlen($ConditionNote) < 2000)
        {
            if ($this->_debug) printf("$this->_cr checkConditionNote function is finished successfully. $this->_cr");
            return true;
        }
        if ($this->_debug) printf("$this->_cr checkConditionNote function is finished $this->_att with an error. Input argument: \$ConditionNote = $ConditionNote $this->_cr");
        return false;
    }

    private function createProductMessage (DOMDocument $Document, $SKU, $ProductIDType, $ProductIDCode, $ConditionType, $ConditionNote, $MessageID, $updatingType = "Update")
    {
        if ($this->_debug) printf("$this->_cr createProductMessage call \$SKU = $SKU \$ProductIDType = $ProductIDType \$ConditionType = $ConditionType \$MessageID = $MessageID \$updatingType = $updatingType $this->_cr");
        $Message = $Document->createElement("Message");
        $MessageIDX = $Document->createElement("MessageID");
        $Message->appendChild($MessageIDX);
        $MessageIDText = $Document->createTextNode($MessageID);
        $MessageIDX->appendChild($MessageIDText);
        $OperationType = $Document->createElement("OperationType");
        $Message->appendChild($OperationType);
        $OperationTypeText = $Document->createTextNode($updatingType);
        $OperationType->appendChild($OperationTypeText);
        $Product = $Document->createElement("Product");
        $Message->appendChild($Product);
        $SKUX = $Document->createElement("SKU");
        $Product->appendChild($SKUX);
        $SKUText = $Document->createTextNode($SKU);
        $SKUX->appendChild($SKUText);
        if ($ProductIDType!=null)
        {
            $StandardProductID = $Document->createElement("StandardProductID");
            $Product->appendChild($StandardProductID);
            $Type = $Document->createElement("Type");
            $StandardProductID->appendChild($Type);
            $TypeText = $Document->createTextNode($ProductIDType);
            $Type->appendChild($TypeText);
            $Value = $Document->createElement("Value");
            $StandardProductID->appendChild($Value);
            $ValueText = $Document->createTextNode($ProductIDCode);
            $Value->appendChild($ValueText);
        }
        if ($ConditionType!=null)
        {
            $ConditionX = $Document->createElement("Condition");
            $Product->appendChild($ConditionX);
            $ConditionTypeX = $Document->createElement("ConditionType");
            $ConditionX->appendChild($ConditionTypeX);
            $ConditionTypeText = $Document->createTextNode($ConditionType);
            $ConditionTypeX->appendChild($ConditionTypeText);
            if ($ConditionNote!=null)
            {
                $ConditionNoteX = $Document->createElement("ConditionNote");
                $ConditionX->appendChild($ConditionNoteX);
                $ConditionNoteText = $Document->createTextNode($ConditionNote);
                $ConditionNoteX->appendChild($ConditionNoteText);
            }
        }
        return $Message;
    }

    private function createQuantityMessage (DOMDocument $Document, $SKU, $quantity, $MessageID)
    {
        if ($this->_debug) printf("$this->_cr createQuantityMessage call \$SKU = $SKU \$quantity = $quantity \$MessageID = $MessageID $this->_cr");
        $Message = $Document->createElement("Message");
        $MessageIDX = $Document->createElement("MessageID");
        $Message->appendChild($MessageIDX);
        $MessageIDText = $Document->createTextNode($MessageID);
        $MessageIDX->appendChild($MessageIDText);
        $OperationType = $Document->createElement("OperationType");
        $Message->appendChild($OperationType);
        $OperationTypeText = $Document->createTextNode("Update");
        $OperationType->appendChild($OperationTypeText);

        $Inventory = $Document->createElement("Inventory");
        $Message->appendChild($Inventory);
        $SKUX = $Document->createElement("SKU");
        $Inventory->appendChild($SKUX);
        $SKUText = $Document->createTextNode($SKU);
        $SKUX->appendChild($SKUText);
        $QuantityX = $Document->createElement("Quantity");
        $Inventory->appendChild($QuantityX);
        $QuantityText = $Document->createTextNode($quantity);
        $QuantityX->appendChild($QuantityText);
        return $Message;
    }

    private function checkQuantity($Quantity)
    {
        if ($this->_debug) printf("$this->_cr checkQuantity call $this->_cr");
        if ($Quantity === null) return false;
        if ($Quantity == 0 || $Quantity == "0") return true;
        if (!is_numeric($Quantity))
        {
            if ($this->_debug) printf("$this->_cr checkQuantity function. \$Quantity must be numeric You sent incorrect argument \$Quantity = $Quantity . Please verify this and try again. Function is finished with an error. $this->_cr");
            return false;

        }
        $quan = intval($Quantity);

        
        if($quan > 0)
        {
            if ($this->_debug) printf("$this->_cr checkQuantity function is completed successfully $this->_cr");
            return true;
        }
        if ($this->_debug) printf("$this->_cr checkQuantity function is completed with $this->_att an Error. It is incorrect input argument Quantity = $Quantity . Must be not negative integer. $this->_cr");
        return false;
    }

    private function createPriceMessage(DOMDocument $Document, $SKU, $Price, $MessageID)
    {
        if ($this->_debug) printf("$this->_cr createPriceMessage call. \$SKU = $SKU \$Price = $Price \$MessageID = $MessageID Current currency: $this->Currency $this->_cr");
        $Message = $Document->createElement("Message");
        $MessageIDX = $Document->createElement("MessageID");
        $Message->appendChild($MessageIDX);
        $MessageIDText = $Document->createTextNode($MessageID);
        $MessageIDX->appendChild($MessageIDText);
        $PriceX = $Document->createElement("Price");
        $Message->appendChild($PriceX);
        $SKUX = $Document->createElement("SKU");
        $PriceX->appendChild($SKUX);
        $SKUText=$Document->createTextNode($SKU);
        $SKUX->appendChild($SKUText);
        $StandardPrice = $Document->createElement("StandardPrice");
        $StandardPrice->setAttribute("currency", $this->Currency /*"USD"*/);
        $PriceX->appendChild($StandardPrice);
        $StandardPriceText = $Document->createTextNode($Price);
        $StandardPrice->appendChild($StandardPriceText);
        return $Message;
    }

    private function checkPrice($price)
    {
        if ($this->_debug) printf("$this->_cr checkPrice call. \$price=$price $this->_cr");

        if (strpos ($price, ',') != false)
        {
            $price = str_replace(",", ".", $price);
        }
        if (is_numeric($price))
            if ($price>=0)
            {
                if ($this->_debug) printf("$this->_cr checkPrice() function is completed successfully. $this->_cr");
                //return true;
                return $price;
            }
        if ($this->_debug) printf("$this->_cr checkPrice() function is completed $this->_att with an error. You sent incorrect input argument \$price = $price $this->_cr");
        return false;
    }



    private function createDelMessage(DOMDocument $Document, $MessageID, $SKU)
    {
        if ($this->_debug) printf("$this->_cr createDelMessage call \$SKU = $SKU \$MessageID = $MessageID $this->_cr");
        $xml = $Document;
        $message = $xml->createElement("Message");
        $MessageIDX = $xml->createElement("MessageID");
        $message->appendChild($MessageIDX);
        $MessageIDText = $xml->createTextNode($MessageID);
        $MessageIDX->appendChild($MessageIDText);
        $OperationType = $xml->createElement("OperationType");
        $message->appendChild($OperationType);
        $OperationTypeText = $xml->createTextNode("Delete");
        $OperationType->appendChild($OperationTypeText);
        $Product = $xml->createElement("Product");
        $message->appendChild($Product);
        $SKUX = $xml->createElement("SKU");
        $Product->appendChild($SKUX);
        $SKUText = $xml->createTextNode($SKU);
        $SKUX->appendChild($SKUText);

        return $message;
    }
}

//PlacedOrder class. 
//Items of this class can be generated from GetOrdersList() function of the Service class.
class PlacedOrder
{

    public $AmazonOrderId; //String, This value can be used for order shipment or for order cancelation
    public $OrderStatus;
    public $PurchaseDate; //String, The date when the customer placed the order.
    public $OrderTotalCurrency;
    public $OrderTotalAmount;
    public $ShipServiceLevel; //String.
    public $NumberOfItemsUnshipped;
    public $Address; // Type: AddressInTheOrder. Instance Of the AddressInTheOrder class. Address where we send our order
    public $Items; // Type: Array of the OrderedItem class instances. Ordered products, array of the OrderedItem class instances.
    public $_debug;

    public function __construct(SimpleXMLElement $order, $Items, $debug = false)
    {
        if ($debug == true) $this->_debug = true;
        else $this->_debug = false;


        $this->AmazonOrderId = (string)$order->AmazonOrderId;
        $this->OrderStatus = (string)$order->OrderStatus;
        $this->PurchaseDate = (string)$order->PurchaseDate;
        $this->OrderTotalCurrency = (string)$order->OrderTotal->CurrencyCode;
        $this->OrderTotalAmount = (string)$order->OrderTotal->Amount;
        $this->ShipServiceLevel = (string)$order->ShipServiceLevel;
        $this->NumberOfItemsUnshipped = (string)$order->NumberOfItemsUnshipped;
        //if ($order->ShippingAddress != NULL)
            $this->Address = new AddressInTheOrder($order->ShippingAddress);
        //else
        //    $this->Address = null;

        //Set Ordered items (products)
        if ($Items != null)
        {
            $this->Items = array();
            for ($i=0; ; $i++)
            {
            if ($Items->OrderItem[$i] != null)
                $this->Items[$i] = new OrderedItem($Items->OrderItem[$i]);
            else
                break;
            }
        }
        else
            $this->Items = NULL;

        //just for a test

        if ($this->_debug) $this->printing();

    }

    public function printing()
    {
        Echo "Order:<br>";
        Echo "AmazonOrderId: $this->AmazonOrderId, PurchaseDate: $this->PurchaseDate, ShipServiceLevel: $this->ShipServiceLevel, NumberOfItemsUnshipped: $this->NumberOfItemsUnshipped <br>";
        //shipping address printing
        $this->Address->printing();
        for ($i=0; $i<count($this->Items); $i++)
            $this->Items[$i]->printing();
    }
}

class AddressInTheOrder
{
    public $Name;
    public $AddressLine1;
    public $AddressLine2;
    public $City;
    public $StateOrRegion;
    public $PostalCode;
    public $CountryCode;
    public $Phone;

    public function  __construct(SimpleXMLElement $Address) {
        $this->Name = (string)$Address->Name;
        $this->AddressLine1 = (string)$Address->AddressLine1;
        $this->AddressLine2 = (string)$Address->AddressLine2;
        $this->City = (string)$Address->City;
        $this->StateOrRegion = (string)$Address->StateOrRegion;
        $this->PostalCode = (string)$Address->PostalCode;
        $this->CountryCode = (string)$Address->CountryCode;
        $this->Phone = (string)$Address->Phone;
    }

    //just for a test
    public function printing()
    {
        echo "Address:<br>";
        echo ("Name: $this->Name, AddressLine1: $this->AddressLine1, AddressLine2: $this->AddressLine2,
                City: $this->City, StateOrRegion: $this->StateOrRegion, PostalCode: $this->PostalCode,
                CountryCode: $this->CountryCode, Phone: $this->Phone ");
        echo "<br>";
    }
}

class OrderedItem
{
    public $ASIN; //The Amazon Standard Identification Number (ASIN) of the item.
    public $SKU;
    public $Title; //Title of the Item
    public $QuantityOrdered; //Number of products of this type we need to ship
    public $ItemPriceCurrency;
    public $ItemPriceAmount;
    public $ShippingPriceCurrency;
    public $ShippingPriceAmount;

    public $TaxesInformation;

    public function  __construct(SimpleXMLElement $Item) {
        $this->ASIN = (string)$Item->ASIN;
        $this->SKU = (string)$Item->SellerSKU;
        $this->Title = (string)$Item->Title;
        $this->QuantityOrdered = (string)$Item->QuantityOrdered;
        $this->ItemPriceCurrency = (string)$Item->ItemPrice->CurrencyCode;
        $this->ItemPriceAmount = (string)$Item->ItemPrice->Amount;
        $this->ShippingPriceCurrency = (string)$Item->ShippingPrice->CurrencyCode;
        $this->ShippingPriceAmount = (string)$Item->ShippingPrice->Amount;

        $this->TaxesInformation = new InfoTaxesItems($Item->ItemTax->CurrencyCode, $Item->ItemTax->Amount,
                $Item->ShippingTax->CurrencyCode, $Item->ShippingTax->Amount,
                $Item->GiftWrapTax->CurrencyCode, $Item->GiftWrapTax->Amount, false);
    }

    public function printing()
    {
        echo ("Item in the order:<br>");
        echo ("ASIN: $this->ASIN, SKU: $this->SKU, Title:
                $this->Title, QuantityOrdered: $this->QuantityOrdered, ItemPriceCurrency: $this->ItemPriceCurrency, ItemPriceAmount: $this->ItemPriceAmount, ShippingPriceCurrency: $this->ShippingPriceCurrency, ShippingPriceAmount: $this->ShippingPriceAmount .");
        echo ("<br>Tax information for this item:");
        $this->TaxesInformation->printing();
        echo ("Item output ends here.<br>");
    }
}

class InfoTaxesItems
{
    public $ItemTaxCurrencyCode;
    public $ItemTaxAmount;
    public $ShippingTaxCurrencyCode;
    public $ShippingTaxAmount;
    public $GiftWrapTaxCurrencyCode;
    public $GiftWrapTaxAmount;

    public $_debug;
    public $_cr;

    public function  __construct($itcc, $ita, $stcc, $sta, $gwtcc, $gwta, $debug = false) {
        if ($debug === true) $this->_debug = true;
        else $this->_debug = false;

        $this->_cr = "<br>";

        if ($this->_debug) printf ("$this->_cr __construct starts to create instance of the Taxes class. $this->_cr");

        $this->ItemTaxCurrencyCode = (string)$itcc;
        $this->ItemTaxAmount = (string)$ita;
        $this->ShippingTaxCurrencyCode = (string)$stcc;
        $this->ShippingTaxAmount = (string)$sta;
        $this->GiftWrapTaxCurrencyCode = (string)$gwtcc;
        $this->GiftWrapTaxAmount = (string)$gwta;

        if ($this->_debug)
        {
            printf("$this->_cr Created object: $this->_cr");
            $this->printing();
            printf("$this->_cr Construct function finishes here $this->_cr");
        }
    }

    public function printing()
    {
        printf ("$this->_cr printing() function output starts here. It writes information, that contain object (NULL if not presentd): $this->_cr
                ItemTaxCurrencyCode: $this->ItemTaxCurrencyCode $this->_cr
                ItemTaxAmount $this->ItemTaxAmount $this->_cr
                ShippingTaxCurrencyCode: $this->ShippingTaxCurrencyCode $this->_cr
                ShippingTaxAmount: $this->ShippingTaxAmount $this->_cr
                GiftWrapTaxCurrencyCode $this->GiftWrapTaxCurrencyCode $this->_cr
                GiftWrapTaxAmount: $this->GiftWrapTaxAmount $this->_cr
                printing() function output finishes here. $this->_cr");
    }
}
?>