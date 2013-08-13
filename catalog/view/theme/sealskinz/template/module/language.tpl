<?php if (count($languages) > 1) { ?>
<a href="#" class="top_parent" onclick="return false;">
<?php foreach ($languages as $language) { ?>
    <?php if ($language['code']==$language_code) { ?>
        <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" />
    <?php } ?>
<?php } ?>
</a>
<ul>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <?php foreach ($languages as $language) { ?>
            <li style="background-color: black; width: 86px;">
<!--                <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $(this).parent().parent().submit();" /> -->
                    <a href="<?php echo $language['code']; ?>/">
                        <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" />
                    </a>
            </li>
        <?php } ?>
        <input type="hidden" name="language_code" value="" />
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
    </form>
</ul>
<?php } ?>
