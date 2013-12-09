<?php
if (!empty($banners)) {
    ?>
    <div class="carousel slide" id="myCarousel">

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
            <div class="container"></div>
        </div>
    </div>

    <?php
    if (count($banners) > 1) {
        ?>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#myCarousel .carouselBasebarContainer .container').prepend('<ol class="carousel-indicators"><?php echo $indicators ?></ol>');
                $('#myCarousel').append('<a data-slide="prev" href="#myCarousel" class="left carousel-control"><span>‹‹</span></a><a data-slide="next" href="#myCarousel" class="right carousel-control"><span>››</span></a>').carousel();
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
            var marginIndicators = ($('#myCarousel').innerWidth() - $('.carousel-indicators').innerWidth())/2;
            
            if(size > settings.max){
                size = settings.max;
            }

            if(size < settings.min){
                size = settings.min;
            }

            $('#myCarousel .bannerWrapper').css("font-size", size + "px");
                
            if ($('#myCarousel .bannerWrapper').length > 1) {
                $('.carouselBasebarContainer .container').css("margin-left", marginIndicators).css("height", $('.carouselBasebarContainer').innerHeight() + "px").css("line-height", $('.carouselBasebarContainer').innerHeight() + "px");
            }
                        
            $('#myCarousel .bannerWrapper .container').height($('#myCarousel .spacer').innerHeight() - $('.carouselBasebarContainer').innerHeight()).css('line-height',($('#myCarousel .spacer').innerHeight()- $('.carouselBasebarContainer').innerHeight()) + "px");
                
        }).trigger('resize');
        
        $(window).load(function () {
            $(window).trigger('resize');
        });
                
         $(document).ready(function() {
                
                $('#myCarousel').hover(
                    function () {
                        $('.carousel-control.left').stop().animate({'left':'0'},400);
                        $('.carousel-control.right').stop().animate({'right':'0'},400);

                    },
                    function () {
                        $('.carousel-control.left').stop().animate({'left':'-29px'},400);
                        $('.carousel-control.right').stop().animate({'right':'-29px'},400);
                    }
                );  
                         
        });
        
    </script>
<?php } ?>
