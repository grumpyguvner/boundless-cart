<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="width: 100%; height: 100%; max-height: <?php echo $height; ?>px;">
        <ol class="carousel-indicators">
          <li data-target="#carousel-example-generic" data-slide-to="0" class=""></li>
          <li data-target="#carousel-example-generic" data-slide-to="1" class=""></li>
          <li data-target="#carousel-example-generic" data-slide-to="2" class=""></li>
        </ol>
        <div class="carousel-inner">
            <?php
            $counter = 0;
            foreach ($banners as $banner) {
                $counter++;
                if ($counter==1) {
                if ($banner['link']) {
            ?>
            <div class="active item">
                <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" src="data:image"></a>
            </div>
            <?php } else { ?>
            <div class="active item">
                <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" src="data:image">
            </div>
            <?php } ?>
            <?php } else {
            if ($banner['link']) {
            ?>
            <div class="item">
                <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" src="data:image"></a>
            </div>
            <?php } else { ?>
            <div class="item">
                <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" src="data:image/png">
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
        </div>
        <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
        </a>
</div>