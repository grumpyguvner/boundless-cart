<div class="row">
<div class="span12">
    
    <div class="carousel slide" id="myCarousel">
                <div class="carousel-inner">
                  <?php foreach ($banners as $banner) { ?>
                        <?php if ($banner['link']) { ?>
                          <div class="item">
                        <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
                          </div>
                            <?php } else { ?>
                          <div class="item">
                        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
                        </div>
                            <?php } ?>
                        <?php } ?>
                </div>
                <a data-slide="prev" href="#myCarousel" class="left carousel-control">‹</a>
                <a data-slide="next" href="#myCarousel" class="right carousel-control">›</a>
              </div>
    
    
    <script type="text/javascript">
        $(document).ready(function() {
                    $('.carousel').carousel();
        });
    </script>

</div>
    </div>