<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadline">
    <div class="container">
      <div class="row"> 
          <div class="span12">
              <div id="container-in">
                <div class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                    <?php } ?>
                </div>
              </div>
            </div>
      </div>
    </div>
  </div>
<div id="content-back">
    <div class="green-bar">
        <div id="container-in" class="content-in">
            <div class="row"><div class="margin-30"> 
            <!--h1><?php /* echo $heading_title; */?></h1-->
            <div class="middle">
                <div>
                    <table class="prods" width="100%">
                         
                          <?php if ( sizeof($Locations) > 0 ) {  ?>
                            <tr>
                                  <td colspan="2">
                              <?php
                                  echo $gmapHeaderJS;
                                  echo $gmapJS;
                                  echo $gmaponLoad;
                                  echo $gmapHtml;
                               ?>
                              </td>
                           </tr>
                           <tr>
                             <td colspan="2">
                                  <div class="wrap-slocation">
                                  <form id='locForm' name='locForm' action="<?php echo $actionURL; ?>" method="get">
                                     <?php echo $store_loc_txt_add; ?>
                                     <input type="hidden" name="route" value="common/store_locations" />
                                     <input type="hidden" id="lat" name="lat" disabled="disabled" value="" />
                                     <input type="hidden" id="lon" name="lon" disabled="disabled" value="" />
                                     <input type="text" name="address" id="address" size="80" value="<?php echo $address; ?>" />&nbsp;
                                     <?php echo $store_loc_radius; ?>
                                     <select id="distance" name="distance" >
                                        <option value="50" <?php echo ($distance=='50')?'selected':'';  ?> >50 Miles</option>
                                        <option value="100" <?php echo ($distance=='100')?'selected':'';  ?> >100 Miles</option>
                                        <option value="150" <?php echo ($distance=='150')?'selected':'';   ?> >150 Miles</option>
                                        <option value="200" <?php echo ($distance=='200')?'selected':'';  ?> >200 Miles</option>
                                        <option value="500" <?php echo ($distance=='500')?'selected':'';  ?> >500 Miles</option>
                                     </select>
                                       <input type="submit" value="<?php echo $store_loc_find_store; ?>" />
                                  </form>
                                  </div>
                              </td>
                          </tr>
                           
                  </table>
                  <div id="listing">  
                    <?php foreach($Locations as $sLocation) { ?>
                           <ul>
                               <li>
                                    <span class="sName"><a href="<?php echo $sLocation['href']; ?>" ><b><?php echo $sLocation['Name'] ?></b></a></span>
                                    <span class="sAddress">
                                       <?php $loc_address = explode(",", $sLocation['Address']); ?>
                                           <?php foreach ($loc_address as $loc) { ?>
                                        <?php echo $loc ?><br />
                                       <?php } ?>
                                        </span>
                                    <span class="sInfo"><?php echo substr(html_entity_decode($sLocation['Details']), 0, 80) ?></span>
                                    <br  />                    
                                    <span class="rMore"><a href="<?php echo $sLocation['href'] ?>" >read more...</a></span>
                               </li>
                           </ul>
                    <?php } ?>
                   </div> 
                         <table class="margin-7">
                              <tr>
                                  <td colspan="2">
                         <?php for($i=0;$i<$noOfPages;$i++) { ?>
                                          <span class="content"><a href="<?php echo $pageLink; echo '&pno='; echo $i+1; ?>" title="Page No <?php echo $i+1; ?>"><?php echo $i+1; ?></a></span>
                                      <?php } ?>
                                  </td>
                             </tr>
                        <?php } 
                          else {
                        ?>
                       <tr>
                          <td colspan="2" style="text-align:center">
                              <div style="font-weight:bold;padding-top:10px;"><?php echo $store_loc_no_store; ?></div>
                          </td>
                     
                      <?php } ?>
                     </table>
                </div>
            </div>
  <script language="javascript">
  	
	function getAdd(pLink) {
		//alert( encodeURI($("#stAddress").val()));
		window.location =  encodeURI(pLink + "&stAddress=" + $("#stAddress").val());
	}
	
	function detectLocation() {
		//if($('#lat').val() == '' && $('#lon').val() == '') {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(detectionSuccess, noFound, {maximumAge:60000, timeout:5000});
			}
		//}
	}
	
	function detectionSuccess(position) {
		
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		$('#lat').attr('disabled', false);
		$('#lon').attr('disabled', false);
		$('#lat').attr('value', lat);
		$('#lon').attr('value', lng);
		$('#locForm').submit();
		
	}
	
	function noFound() {
		alert('unable to detect your location');
	}
	
	<?php echo $detectLoc; ?>
	
  </script>
   <?php echo $content_bottom; ?>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
   <?php echo $footer; ?>