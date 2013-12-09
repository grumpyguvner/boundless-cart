<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />
<form method="post" enctype="multipart/form-data" name="subscribe" id="subscribe">
    <h2><?php echo $heading_title; ?></h2>
	<?php echo $text_message;?>
    <div class="content">
    <?php echo $entry_fname; ?><br />
    <input type="text" name="fname" value="" />
    <br />
	<?php echo $entry_lname; ?><br />
    <input type="text" name="lname" value="" />
    <br />
	<?php echo $entry_phone; ?><br />
    <input type="text" name="phone" value="" />
    <br />
    <?php echo $entry_email; ?><br />
    <input type="text" name="email" value="" />
    <br />
    <?php echo $entry_comments; ?><br />
    <textarea name="comments" cols="40" rows="10" style="width: 99%;"></textarea>
    <br />
    </div>
    <div class="buttons">
      <div><a onclick="return check();" class="button"><span><?php echo $button_submit; ?></span></a></div>
    </div>
</form>
<script type="text/javascript">
function check(){
	var x = document.subscribe;
	x.fname.style.borderColor = '';
	x.lname.style.borderColor = '';
	x.phone.style.borderColor = '';
	x.email.style.borderColor = '';
	x.comments.style.borderColor = '';
	
	if(x.fname.value == ''){
		x.fname.style.borderColor = 'red';
		x.fname.focus();
		return false;
	}
	if(x.lname.value == ''){
		x.lname.style.borderColor = 'red';
		x.lname.focus();
		return false;
	}
	if(x.phone.value == ''){
		x.phone.style.borderColor = 'red';
		x.phone.focus();
		return false;
	}
	if(x.email.value == ''){
		x.email.style.borderColor = 'red';
		x.email.focus();
		return false;
	}
	if(!checkemail(x.email.value)){
		x.email.style.borderColor = 'red';
		x.email.focus();
		return false;
	}
	
	if(x.comments.value == ''){
		x.comments.style.borderColor = 'red';
		x.comments.focus();
		return false;
	}
	document.getElementById('subscribe').submit();
	//$('#subscribe').submit();
}
function checkemail(str){
	var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
	if (filter.test(str))
		testresults=true
	else{
		testresults=false
	}
	return (testresults)
}
</script>