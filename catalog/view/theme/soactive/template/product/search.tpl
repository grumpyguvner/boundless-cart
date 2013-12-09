<?php echo $header; ?>
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
    <div id="mainContainer"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
            <?php echo $content_top; ?>

            <div class="product-filter">
            <!--div class="display"><b><?php /* echo $text_display; */ ?></b> <?php /* echo $text_list; */ ?> <b>/</b> <a onclick="display('grid');"><?php /* echo $text_grid; */ ?></a></div-->
            <div class="productResult"><?php echo $pagination2; ?></div>
            <div class="pagination"><?php echo $pagination; ?></div>&nbsp&nbsp
            <div class="numberProducts">
                    <?php foreach ($limits as $hlimit) { ?>
                        <?php if ($hlimit['value'] == '100' && $limit != '100') { ?>
                        <a href="<?php echo $hlimit['href']; ?>"><?php echo $text_hundred_per_page; ?></a>
                        <?php } else if ($hlimit['value'] == '40' && $limit == '100') { ?>
                        <a href="<?php echo $hlimit['href']; ?>"><?php echo $text_fourty_per_page; ?></a>
                        <?php } ?>
                    <?php } ?>
            </div>
            <div class="sort"><span><?php echo $text_sort; ?></span>
                <select onchange="location = this.value;">
                    <?php foreach ($sorts as $sort_first) { ?>
                        <?php if ($sort_first['value'] == $sort . '-' . $order) { ?>
                            <option value="<?php echo $sort_first['href']; ?>" selected="selected"><?php echo $sort_first['text']; ?></option>
                        <?php } else { ?>
                            <option value="<?php echo $sort_first['href']; ?>"><?php echo $sort_first['text']; ?></option>
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
                                        <?php if ($product['sale'] && $this->config->get('config_sale_item') && $this->config->get('config_sale_item')==1) { ?> 
                                            <img class="saleProduct" src="catalog/view/theme/soactive/image/sale-icon.png" alt="Sale Product">
                                        <?php } ?> 
                                    <?php } ?>
                                </div>
                                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                <?php if ($product['price']) { ?>
                                    <div class="priceItem">
                                        <?php if (!$product['special']) { ?>
                                            <span><?php echo $text_pay ?> </span><span class="price"><?php echo $product['price']; ?></span>
                                        <?php } else { ?>
                                            <span class="save"><?php echo $text_save ?>  <?php echo $product['saving_percent'] . '%' ?></span>
                                            <span class="price-old"><?php echo $product['price']; ?></span> <?php echo $text_pay ?> <span class="price-new"><?php echo $product['special']; ?></span>
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
                                <?php if ($hlimit['value'] == '100' && $limit != '100') { ?>
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
            <?php echo $content_bottom; ?>
     </div>
    </div>
    
<?php echo $footer; ?>
