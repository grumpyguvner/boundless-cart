<div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
        <?php if ($information['sort_order'] == '3') { ?>
        <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
      <?php } else if ($information['sort_order'] == '4') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '5') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '6') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '7') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '8') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      <?php } ?>
      <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
      
    </ul>
  </div>
</div>
<div class="contact-image"></div>

