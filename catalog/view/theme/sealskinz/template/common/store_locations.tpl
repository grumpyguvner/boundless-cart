<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php
    }
    if (isset($attention) && $attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">
        <div id="storeContainer" class="container">
            <div id="content">
            <!--h1><?php /* echo $heading_title; */ ?></h1--> 
                <div id="storeMap" class="google-maps"></div>
                <div id="locForm">
                    <form class="form-inline" action="index.php" method="get">

                        <?php echo $store_loc_txt_add; ?>&nbsp;
                        <input type="hidden" name="route" value="common/store_locations" />
                        <input type="hidden" id="lat" name="lat" disabled="disabled" value="" />
                        <input type="hidden" id="lon" name="lon" disabled="disabled" value="" />
                        <input type="text" name="address" id="address" size="80" value="<?php echo $address; ?>" />&nbsp;
                        <?php echo $store_loc_radius; ?>&nbsp;
                        <select id="distance" name="distance" >
                            <option value="5" <?php echo ($distance == '5') ? 'selected' : ''; ?> >5 <?php echo $store_loc_text_miles; ?></option>
                            <option value="10" <?php echo ($distance == '10') ? 'selected' : ''; ?> >10 <?php echo $store_loc_text_miles; ?></option>
                            <option value="25" <?php echo ($distance == '25') ? 'selected' : ''; ?> >25 <?php echo $store_loc_text_miles; ?></option>
                            <option value="50" <?php echo ($distance == '50') ? 'selected' : ''; ?> >50 <?php echo $store_loc_text_miles; ?></option>
                            <option value="100" <?php echo ($distance == '100') ? 'selected' : ''; ?> >100 <?php echo $store_loc_text_miles; ?></option>
                            <option value="150" <?php echo ($distance == '150') ? 'selected' : ''; ?> >150 <?php echo $store_loc_text_miles; ?></option>
                            <option value="200" <?php echo ($distance == '200') ? 'selected' : ''; ?> >200 <?php echo $store_loc_text_miles; ?></option>
                            <option value="500" <?php echo ($distance == '500') ? 'selected' : ''; ?> >500 <?php echo $store_loc_text_miles; ?></option>
                        </select>
                        <button type="submit" class="btn"><?php echo $store_loc_find_store; ?></button>
                    </form>
                </div>
                <script language="javascript">
                    var get_pins = true;
                    function findPostcode(address) {
                        geocoder.geocode( {
                            'address': address
                        }, function(results, status) {
                            if (status == google.maps.GeocoderStatus.OK) {
                                $('#lat').attr('disabled', false);
                                $('#lon').attr('disabled', false);
                                $('#lat').attr('value', results[0].geometry.location.lat());
                                $('#lon').attr('value', results[0].geometry.location.lng());
                            } else {
                                geocoder = '';
                            }
                            $('#locForm form').trigger('submit');
                        });
                    }
                                        
                    function detectLocation() {
                        get_pins = false;
                        if($('#address').attr('value') == '') {
                            if (navigator.geolocation) {
                                navigator.geolocation.getCurrentPosition(detectionSuccess, noFound, {maximumAge:60000, timeout:5000});
                            }
                        }
                    }
                                	
                    function detectionSuccess(position) {
                        var lat = position.coords.latitude;
                        var lng = position.coords.longitude;
                        $('#lat').attr('disabled', false);
                        $('#lon').attr('disabled', false);
                        $('#lat').attr('value', lat);
                        $('#lon').attr('value', lng);
                        $('#locForm form').trigger('submit');
                    }
                        
                    $('#locForm form select').change(function () {
                        $('#locForm form').trigger('submit');
                    });
                            
                    $('#locForm form').submit(function  () {
                        $('#lat').attr('disabled', false);
                        $('#lon').attr('disabled', false);
                        if (typeof geocoder != 'undefined' && geocoder != '')
                        {
                            if (!$('#lat').val() && !$('#lat').val() && $('#address').val())
                            {
                                findPostcode($('#address').val());
                                return false;
                            }
                        }
                    });
                                	
                    function noFound() {
                        get_pins = true;
                        place_pins_on_map();
                    }
                                               
                    <?php echo $detectLoc; ?>


                    $('#locForm').show();
                </script>

                <?php if (sizeof($Locations) > 0) { ?>   
                    <div class="stores">  
                        <?php foreach ($Locations as $sLocation) {
                            ?><div id="store<?php echo $sLocation['ID'] ?>" class="store">
                                <p class="sName"><?php echo $sLocation['Name'] ?></p>
                                <p class="sAddress">
                                    <?php $loc_address = explode(",", $sLocation['Address']); ?>
                                    <?php foreach ($loc_address as $loc) { ?>
                                        <?php echo $loc ?><br />
                                    <?php } ?>
                                </p>
                                <p>
                                    <?php if (!empty($sLocation['Phone'])) { ?>
                                        <?php echo $sLocation['Phone']; ?><br>
                                    <?php } ?>
                                    <?php if (!empty($sLocation['Email'])) { ?>
                                        <a href="mailto:<?php echo $sLocation['Email']; ?>"><?php echo $sLocation['Email']; ?></a><br>
                                    <?php } ?>
                                    <?php if (!empty($sLocation['Website'])) { ?>
                                        <a href="http://<?php echo $sLocation['Website']; ?>" target="_blank"><?php echo $sLocation['Website']; ?></a><br>
                                    <?php } ?></p>
                            </div><?php }
                                ?>
                    </div>
                    <div class="pagination"><?php echo $pagination; ?></div>
                    <?php
                } else {
                    ?>
                    <div class="no_stores"><?php echo $store_loc_no_store; ?></div>
                    <?php
                }
                ?>
                <?php echo $content_bottom; ?>
            </div>
        </div>
    </div>
</div>
<?php
echo $footer;
?>
<script>
<?php
if (isset($map_start_address) && $map_start_address) {
    ?>
            var map_address = '<?php echo $map_start_address; ?>';
    <?php
} else {
    ?>
            var map_lat = '<?php echo $map_start_cords['lat']; ?>';
            var map_lon = '<?php echo $map_start_cords['lon']; ?>';
    <?php
}
?>
    var getMarkers = '<?php echo html_entity_decode($this->data['ajax_url']); ?>';
    var text_view_on_map = 'View on map';
    $("#storeMap").append('<div id="map" class="google-maps" />');
</script>
<script type="text/javascript" src="catalog/view/javascript/store_locations.js"></script>
