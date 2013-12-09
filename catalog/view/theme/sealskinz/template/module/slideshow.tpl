<?php
if (!empty($banners)) {
    ?>
    <div class="carousel slide" id="myCarousel">
        <img src="/catalog/view/theme/sealskinz/image/carouselSpacer.png" alt="" class="spacer" />
        <div class="carousel-inner">
            <?php
            $indicators = '';
            foreach ($banners as $key => $banner) {
                
                $class = (preg_match('%.*class="(banner[^"]*)".*%', $banner['description'])) ? preg_replace('%.*class="(banner[^"]*)".*%s', ' \\1', $banner['description']) : false;
                
                ?>
                <div class="bannerWrapper item<?php if ($key == 0) echo ' active'; ?>">
                    <?php if ($banner['link']) echo '<a href="' . $banner['link'] . '">'; ?><img class="bannerImage" src="<?php echo $banner['image']; ?>" width="<?php echo $banner['width']; ?>" height="<?php echo $banner['height']; ?>" /><?php if ($banner['link']) echo '</a>'; ?>
                    <?php if ($banner['description']) { ?>
                        <div class="outerContainer">
                            <div class="container<?php if ($class) echo $class; ?>" style="height:<?php echo $banner['height']; ?>px;line-height:<?php echo $banner['height']; ?>px">
                                <div class="innerContainer">
                                <?php echo $banner['description']; ?>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                </div>
                <?php
                $indicators .= '<li data-target="#myCarousel" data-slide-to="' . $key . '" class="' . ($key == 0 ? ' active' : '') . '"></li>';
            }
            ?>
        </div>
        <div class="carouselBasebarContainer">
            <div class="container">
                <div class="imgGreat">
                    <img src="catalog/view/theme/sealskinz/image/great-british-company.png" alt="Designed by a great British company" />
                </div>
            </div>
        </div>
    </div>
    <?php
    if (count($banners) > 1) {
        ?>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#myCarousel .carouselBasebarContainer .container').prepend('<ol class="carousel-indicators"><?php echo $indicators ?></ol>');
                $('#myCarousel').append('<a data-slide="prev" href="#myCarousel" class="left carousel-control">‹</a><a data-slide="next" href="#myCarousel" class="right carousel-control">›</a>').carousel();
            });
        </script>
    <?php } ?>
    <script type="text/javascript">
        $('.bannerWrapper').each (function () {
            if ($(this).find('a[href]:first').length) {
                $(this).css('cursor', 'pointer').click(function () {
                    window.location = $(this).find('a[href]:first').attr('href');
                    return false;
                });
                $(this).find('*').css('cursor', 'pointer');
            }
        });
        
        $(window).resize(function () {
            var settings = {
                "max" : 27,
                "min" : 11,
                "step": 50
            };

            var size = $('#myCarousel').innerWidth() / settings.step;

            if(size > settings.max){
                size = settings.max;
            }

            if(size < settings.min){
                size = settings.min;
            }

            $('#myCarousel .bannerWrapper').css("font-size", size + "px");
            
            if ($('#myCarousel .bannerWrapper').length > 1) {
                $('.carouselBasebarContainer .container').css("height", $('.carouselBasebarContainer').innerHeight() + "px").css("line-height", $('.carouselBasebarContainer').innerHeight() + "px");
            }
                    
            $('#myCarousel .bannerWrapper .container').height($('#myCarousel .spacer').innerHeight() - $('.carouselBasebarContainer').innerHeight()).css('line-height',($('#myCarousel .spacer').innerHeight()- $('.carouselBasebarContainer').innerHeight()) + "px");
            
        }).trigger('resize');
                
        $(window).load(function () {
            $(window).trigger('resize');
        });
                
    </script>
<?php } ?>
