<?php echo $header; ?><?php echo $content_top; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
        <?php $count = count($breadcrumbs) - 1; ?>
        <?php for ($i = 0; $i < $count; $i++) { ?>
            <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
        <?php } ?>
        <?php echo '<b>' . $breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
        <div class="back"><a href="<?php echo $breadcrumbs[$count - 1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
    <?php } ?>
</div>


    <div class="events"><?php echo $column_left; ?><?php echo $column_right; ?>
        <div id="content"> 
            <h1><?php echo strtoupper($heading_title); ?></h1>
        <?php
        if (count($available_events) > 0) {
            foreach ($available_events as $v) {

                $q_no_sub = "select null from " . DB_PREFIX . "event_subscribers where event_id='" . $v['event_id'] . "'";
                $query_no_sub = $this->db->query($q_no_sub);
                $results_no_sub = $query_no_sub->rows;
                $no_sub = count($query_no_sub->rows);

                if ($v['image']) {
                    $thumb = $this->model_tool_image->resize($v['image'], 163, 169);
                } else {
                    $thumb = '';
                }
                ?>
                <div class="manufacturer-list">

                    <div class="manufacturer-heading"><a href="<?php echo $this->url->link('information/event', 'event_id=' . $v['event_id']); ?>"><?php echo $v['title']; ?></a></div>
                    <?php if ($thumb) { ?><div class="image" style="float:left; margin:3px;"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div><?php } ?>
                    <div style="float:right;"><img src="catalog/view/theme/default/image/latest.png" />&nbsp;<?php echo date('M d, Y', strtotime($v['event_date'])); ?></div>
                    <div class="manufacturer-content">
                        <?php echo substr(strip_tags(html_entity_decode($v['description'])), 0, 200) . "..."; ?>
                    </div>
                    <?php if ($v['allow_subscribe'] == 'y' && ($no_sub < $v['no_of_sub'] || $v['no_of_sub'] <= 0)) { ?><a href="<?php echo HTTP_SERVER; ?>index.php?route=information/event/subscribe&event_id=<?php echo $v['event_id']; ?>" class="button fancybox1"><span><?php echo $button_sub; ?></span></a><?php } ?>
                    
                </div>

                <?php
            }
        } else {
            echo $text_error;
        }
        ?>
        <div class="buttons">
            <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
        </div>
        <?php echo $content_bottom; ?>
        </div>
    </div>

<script type="text/javascript">
    $('.fancybox1').fancybox({'type'	: 'iframe',
        'width'				: '55%',
        'height'			: '62%',
        cyclic			: false
    });

    /*$("#various5").fancybox({
                'width'				: '75%',
                'height'			: '75%',
        'autoScale'     	: false,
        'transitionIn'		: 'none',
                'transitionOut'		: 'none',
                'type'				: 'iframe'
        });*/
</script>  
<?php echo $footer; ?>