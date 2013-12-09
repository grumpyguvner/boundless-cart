<?php echo $header; ?>
<?php
if ($login_required)
{
    echo '<script>$.colorbox({href:"' . $login_modal . '",opacity: 0.5,overlayClose: false, escKey :false, closeButton: false});</script>';
}
?>
<?php echo $content_top; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo '<b>' .$breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
        <div class="back"><a href="<?php echo $breadcrumbs[$count-1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
    <?php } ?>
  </div>

<?php if ($thumb || $date_end || $description) { ?>
<div class="category-info">
        <?php if ($thumb || $date_end) { ?>
        <div class="categoryImage">
            <?php
            if ($date_end)
            {
                ?>
            <div class="countdown"></div>
<script type="text/javascript" src="catalog/view/javascript/jquery/countdown/jquery.countdown.js"></script>
<script type="text/javascript">
    $(function() {
      var endDate = "<?php echo date("M j, Y, G:i:s", strtotime($date_end)); ?>";

      $('.countdown').countdown({
        date: endDate,
        render: function(data) {
          $(this.el).html("<div>" + this.leadingZeros(data.days, 2) + " :<div class='countdownText'>Days</div></div><div>" + this.leadingZeros(data.hours, 2) + " :<div class='countdownText'>Hr</div></div><div>" + this.leadingZeros(data.min, 2) + " : <div class='countdownText'>Min</div></div><div>" + this.leadingZeros(data.sec, 2) + "<div class='countdownText'>Sec</div></div>");
        }
      });

    });
  </script>
            <?php
            } else {
            ?>
            <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" />
            <?php
            } 
            ?>
        </div>    
        <?php } ?>
        <?php if ($description) { ?>
            <div class="cDescription">
                <?php echo $description; ?>
            </div>
        <?php } ?>
    </div>
<?php } ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
    <?php if ($products) { ?>
        <div class="product-filter">
            <!--div class="display"><b><?php /* echo $text_display; */ ?></b> <?php /* echo $text_list; */ ?> <b>/</b> <a onclick="display('grid');"><?php /* echo $text_grid; */ ?></a></div-->
            <div class="productResult"><?php echo $pagination2; ?></div>
            <div class="pagination"><?php echo $pagination; ?></div>&nbsp&nbsp
            <div class="numberProducts">
                <?php foreach ($limits as $hlimit) { ?>
                    <?php if ($hlimit['value'] == '100' && $limit != '100' && $total >= '40') { ?>
                    <a href="<?php echo $hlimit['href']; ?>"><?php echo $text_hundred_per_page; ?></a>
                    <?php } else if ($hlimit['value'] == '40' && $limit == '100') { ?>
                    <a href="<?php echo $hlimit['href']; ?>"><?php echo $text_fourty_per_page; ?></a>
                    <?php } ?>
                <?php } ?>
            </div>
            <div class="sort"><span><?php echo $text_sort; ?></span>
                <select onchange="location = this.value;">
                    <?php foreach ($sorts as $sort_first) {
                    if (stristr($sort_first['text'], 'Model') === false)
                    {
                        ?>
                        <?php if ($sort_first['value'] == $sort . '-' . $order) { ?>
                            <option value="<?php echo $sort_first['href']; ?>" selected="selected"><?php echo $sort_first['text']; ?></option>
                        <?php } else { ?>
                            <option value="<?php echo $sort_first['href']; ?>"><?php echo $sort_first['text']; ?></option>
                        <?php } ?>
                    <?php } ?>
                    <?php } ?>
                </select>
            </div>
        </div>
            <?php if ($products) { ?>
                    <div class="product-grid">
                        <?php foreach ($products as $product) {
                            ?><div class="productItem">
                                <div class="image"><?php if ($product['thumb']) { ?>
                                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                        <?php if ($product['new']) { ?> 
                                            <img class="newProduct" src="catalog/view/theme/soactive/image/new-icon.png" alt="New Product">
                                        <?php } ?>
                                        <?php if ($product['sale']) { ?> 
                                            <img class="saleProduct" src="catalog/view/theme/soactive/image/sale-icon.png" alt="Sale Product">
                                        <?php } ?>    
                                    <?php } ?>
                                </div>
                                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                <?php if ($product['price']) { ?>
                                    <div class="priceItem">
                                        <?php if (!$product['special']) { ?>
                                             <span><?php echo $text_pay; ?> </span><span class="price"><?php echo $product['price']; ?></span>
                                        <?php } else { ?>
                                            <span class="save"><?php echo $text_save; ?> <?php echo $product['saving_percent'] . '%' ?></span>
                                            <span class="price-old"><?php echo $text_rrp; ?> <?php echo $product['price']; ?></span> <?php echo $text_pay; ?> <span class="price-new"><?php echo $product['special']; ?></span>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            </div><?php }
                                ?>
                    </div>
    
                    <div class="product-filter">
                        <div class="productResult"><?php echo $pagination2; ?></div>
                        <div class="pagination"><?php echo $pagination; ?></div>&nbsp&nbsp
                        <div class="numberProducts">
                            <?php foreach ($limits as $hlimit) { ?>
                                <?php if ($hlimit['value'] == '100' && $limit != '100' && $total >= '40') { ?>
                                <a href="<?php echo $hlimit['href']; ?>"><?php echo $text_hundred_per_page; ?></a>
                                <?php } else if ($hlimit['value'] == '40' && $limit == '100') { ?>
                                <a href="<?php echo $hlimit['href']; ?>"><?php echo $text_fourty_per_page; ?></a>
                                <?php } ?>
                            <?php } ?>
                        </div>
                        <div class="sort"><span><?php echo $text_sort; ?></span>
                            <select onchange="location = this.value;">
                                <?php foreach ($sorts as $sort_after) { ?>
                                    <?php if ($sort_after['value'] == $sort . '-' . $order) { ?>
                                        <option value="<?php echo $sort_after['href']; ?>" selected="selected"><?php echo $sort_after['text']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $sort_after['href']; ?>"><?php echo $sort_after['text']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                <?php } else { ?>
                    <div class="content"><?php echo $text_empty; ?></div>
                <?php } ?>
    <?php } ?>
    <?php if (!$categories && !$products) { ?>
        <div class="content"><?php echo $text_empty; ?></div>
        <div class="buttons">
            <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
        </div>
    <?php } ?>
    <?php if (!$products) { ?>
        <div class="content"><?php echo $text_empty; ?></div>
    <?php } ?>
    <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>