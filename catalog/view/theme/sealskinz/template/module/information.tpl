<?php 
$category = false;
foreach ($informations as $key => $information) {
    if (strtolower($category) !== strtolower($information['category']))
    {
        if ($key > 0)
        {
            echo '</ul></div></div>';
        }
        echo '<div class="box"><div class="box-heading">' . $information['category'] . '</div><div class="box-infocontent"><ul>';
    }
    echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';
    
    if ($key+1 == count($informations)) echo '</ul></div></div>';
    
    $category = $information['category'];
}
?>
<!--div class="<?php echo $seo ?>"></div-->
