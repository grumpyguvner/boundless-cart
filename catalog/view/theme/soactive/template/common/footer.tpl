</div>
<div class="separatorLine"></div>
<div class="container">
<div id="footer">
    <?php foreach ($blocks as $block) { ?>
        <div class="column"><?php echo $block['description']; ?></div>
    <?php } ?>
      
        </div>
    <div id="powered"><?php echo $powered; ?></div>
</div>
</div>
<?php echo $welcome_popup; ?>
</body></html>
<script type="text/javascript">
    $('.submit img').click(function () {
        $(this).parents('form').trigger('submit');
        return false;
    });
</script>