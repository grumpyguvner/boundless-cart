<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error) { ?>
  <div class="warning"><?php echo $error; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/amazon/amazon.gif" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">

      <table cellspacing=5 cellpadding=5>
        <tbody>

        <tr>
        <?php
            foreach ($extensions as $extension) { ?>
            <td style="text-align:center;">
              <a href="<?php echo $extension['href']; ?>"><img src="view/image/amazon/<?php echo $extension['image']; ?>" alt="<?php echo $extension['name']; ?>" /></a>
            </td>
          <?php } ?>
        </tr>

        <tr>
            <?php foreach ($extensions as $extension) { ?>
            <td class="left">
                <a href="<?php echo $extension['href']; ?>"><?php echo $extension['name']; ?></a></td>

        <?php } ?>
        </tr>

        </tbody>
      </table>

    </div>
  </div>
</div>
<?php echo $footer; ?>