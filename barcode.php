<?php
// Including all required classes
require('system/helper/barcodegen/class/BCGFont.php');
require('system/helper/barcodegen/class/BCGColor.php');
require('system/helper/barcodegen/class/BCGDrawing.php'); 

$font = new BCGFont('system/helper/barcodegen/class/font/Arial.ttf', 10);
// The arguments are R, G, B for color.
$color_black = new BCGColor(0, 0, 0);
$color_white = new BCGColor(255, 255, 255); 

// Including the barcode technology

// Loading Font
switch ($_GET['typ']) {
    case "ean":
        include('system/helper/barcodegen/class/BCGean13.barcode.php'); 
        $code = new BCGean13();
        
        $_GET['ref'] = str_pad('2' . $_GET['ref'], 12, "0", STR_PAD_LEFT);
        
        $code->setFont($font); // Font (or 0)
        break;

    default:
        include('system/helper/barcodegen/class/BCGcode39.barcode.php'); 
        $code = new BCGcode39();
        
        $code->setFont(0); // Font (or 0)
        break;
}

$code->setScale(2); // Resolution
$code->setThickness(10); // Thickness
$code->setForegroundColor($color_black); // Color of bars
$code->setBackgroundColor($color_white); // Color of spaces

$code->parse($_GET['ref']); // Text

/* Here is the list of the arguments
1 - Filename (empty : display on screen)
2 - Background color */
$drawing = new BCGDrawing('', $color_white);
$drawing->setBarcode($code);
$drawing->draw();

// Header that says it is an image (remove it if you save the barcode to a file)
header('Content-Type: image/png');

// Draw (or save) the image into PNG format.
$drawing->finish(BCGDrawing::IMG_FORMAT_PNG);
?>