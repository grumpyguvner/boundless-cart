<div id="footer">
    <div id="textfooter1"><b>Cadenhead's Whisky Shop &amp; Tasting Room, 26 Chiltern Street, London, W1U 7QF. Tel: 020 7935 6999</b></div>
    <div id="textfooter2"><b>Design &amp; Built by Boundless Commerce</b></div>
<?php   ?>
</div>
<div id="footerlast">
    <div class="footer-right"><p><?php foreach ($informations as $information) { ?><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a> &nbsp;&nbsp;<?php } ?><br /><br />This site is intended to be used and accessed only by individuals of legal drinking age within the UK.</p></div><a href="http://www.drinkaware.co.uk"><img class="drinkawareimg" src="image/whisky/data/drinkaware.png" alt="Drink Aware"></a>
</div>
</div>
<?php echo $welcome_popup; ?>
</body></html>