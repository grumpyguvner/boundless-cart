<?php echo $header; ?>

<div id="content">

	<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1 class="icon-cogs"><i></i> <?php echo $heading_title; ?></h1>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
			<?php if ($error) { ?>
			<div class="warning alert alert-error"><?php echo $error; ?></div>
			<?php } ?>

    </div>

    <div class="content">

			<?php if ($extensions) { ?>
			<table class="list table table-striped table-hover">
				<thead>
					<tr>
						<th class="column-name"><?php echo $column_name; ?></th>
						<th class="column-action"><?php echo $column_action; ?></th>
					</tr>
				</thead>
				<tbody>
          <?php foreach ($extensions as $extension) { ?>
          <tr>
            <td class="column-name"><?php echo $extension['name']; ?></td>
            <td class="column-action">
							<?php echo p3html::tb_action_buttons($extension); ?>
						</td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>