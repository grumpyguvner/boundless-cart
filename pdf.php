<?php
/**
 * HTML2PDF Librairy - example
 *
 * HTML => PDF convertor
 * distributed under the LGPL License
 *
 * @author      Laurent MINGUET <webmaster@html2pdf.fr>
 *
 * isset($_GET['vuehtml']) is not mandatory
 * it allow to display the result in the HTML format
 */

require('system/helper/html2pdf/html2pdf.class.php');

    // get the HTML
    ob_start();
    echo $_REQUEST['content'];
    $content = ob_get_clean();

    // convert in PDF
    try
    {
        $html2pdf = new HTML2PDF('P', 'A4', 'fr');
//      $html2pdf->setModeDebug();
        $html2pdf->setDefaultFont('Arial');
        $html2pdf->writeHTML($content, isset($_GET['vuehtml']));
        $html2pdf->Output($_REQUEST['filename']);
    }
    catch(HTML2PDF_exception $e) {
        echo $e;
        exit;
    }