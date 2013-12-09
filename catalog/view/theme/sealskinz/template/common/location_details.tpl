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
        <div class="container">

            <div id="content">
                <h1><?php echo $heading_title; ?></h1>
                <div class="middle">
                    <div>
                        <table class="prods" width="100%">
<?php if ($no_location) { ?>
                                <tr>
                                    <td colspan="2">
                                        <div class="warning"><?php echo $txtWrong_loc_id; ?></div>
                                    </td>
                                </tr>
                                <?php
                            } else {
                                ?>
                                <tr>
                                    <td width="60%">
                                        <div><img src="<?php echo $Location['thumb']; ?>" /> </div>
                                            <?php if ($images) { ?>
                                            <div class="image-additional">
                                                <?php foreach ($images as $image) { ?>
                                                    <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="fancybox" rel="fancybox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
                                            <?php } ?>
                                            </div>
    <?php } ?>
                                    </td>
                                    <td width="40%" valign="top">
                                        <table class="prod">
    <?php if (!empty($Location['Address'])) { ?>
                                                <tr>
                                                    <td style="width:50px;vertical-align:top;font-weight:bold;"><?php echo $store_loc_address ?></td>
                                                    <td><?php echo $Location['Address']; ?></td>
                                                </tr>
                                            <?php } ?>

    <?php if (!empty($Location['Website'])) { ?>
                                                <tr>
                                                    <td style="width:50px;vertical-align:top;font-weight:bold;"><?php echo $store_loc_website ?></td>
                                                    <td><a href="http://<?php echo $Location['Website']; ?>" TARGET="_blank"><?php echo $Location['Website']; ?></a></td>
                                                </tr>
                                            <?php } ?>

    <?php if (!empty($Location['SpecialOffers'])) { ?>
                                                <tr>
                                                    <td style="width:50px;vertical-align:top;font-weight:bold;"><?php echo $store_loc_offers ?></td>
                                                    <td><?php echo $Location['SpecialOffers']; ?></td>
                                                </tr>
                                            <?php } ?>

    <?php if (!empty($Location['Timing'])) { ?>
                                                <tr>
                                                    <td style="width:50px;vertical-align:top;font-weight:bold;"><?php echo $store_loc_timing ?></td>
                                                    <td><?php echo $Location['Timing']; ?></td>
                                                </tr>
                                            <?php } ?>

    <?php if (!empty($Location['Phone'])) { ?>
                                                <tr>
                                                    <td style="width:50px;vertical-align:top;font-weight:bold;"><?php echo $store_loc_phone ?></td>
                                                    <td><?php echo $Location['Phone']; ?></td>
                                                </tr>
                                            <?php } ?>

    <?php if (!empty($Location['Email'])) { ?>
                                                <tr>
                                                    <td style="width:50px;vertical-align:top;font-weight:bold;"><?php echo $store_loc_email ?></td>
                                                    <td><a href="mailto:<?php echo $Location['Email']; ?>"><?php echo $Location['Email']; ?></a></td>
                                                </tr>
    <?php } ?>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top"><?php echo $Location['Details']; ?>
                                        <div id="mapDirections"></div>
                                    </td>
                                    <td valign="top"> 
                                        <?php
                                        echo $gmapHeaderJS;
                                        echo $gmapJS;
                                        echo $gmaponLoad;
                                        echo $gmapHtml;
                                        ?>
                                    </td>
                                </tr>
<?php } ?>
                        </table>
                    </div>
                </div>
                <script language="javascript">
                    function getAdd(pLink) {
                        //alert( encodeURI($("#stAddress").val()));
                        window.location =  encodeURI(pLink + "&stAddress=" + $("#stAddress").val());
                    }
                </script>
                <script type="text/javascript"><!--
                    $('.fancybox').fancybox({cyclic: true});
                    //--></script> 
<?php echo $content_bottom; ?>
            </div>
        </div>
    </div>
    </div>
<?php echo $footer; ?>