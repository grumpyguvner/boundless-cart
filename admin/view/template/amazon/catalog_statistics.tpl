<table class="statistiques">
<thead>
    <th><?php echo $entry_description; ?></th>
    <th><?php echo $entry_value_qty; ?></th>
    <th><?php echo $entry_percent; ?></th>
    <th><?php echo $entry_download; ?></th>
</thead>
<tbody>
  <tr>
    <td><?php echo $entry_products; ?></td>
    <td class="right"><?php echo $result_value; ?></td>
    <td class="right"><?php echo isset($result_percent) ? $result_percent : '' ; ?></td>
    <td></td>
  </tr>
  <tr>
    <td><?php echo $entry_products_without_sku; ?></td>
    <td class="right"><?php echo $products_without_sku; ?></td>
    <td class="right"><?php echo $products_without_sku_percent; ?></td>
    <td class="center">
        <?php   if ( $products_without_sku_action ) echo '<img src="view/image/amazon/export.gif" rel="' . $products_without_sku_action . '" class="download" alt="Download" />' ;
                else echo '<span class="download" />' ?>
    </td>
  </tr>
  <tr>
    <td><?php echo $entry_products_without_sku_upc; ?></td>
    <td class="right"><?php echo $products_without_sku_upc; ?></td>
    <td class="right"><?php echo $products_without_sku_upc_percent; ?></td>
    <td class="center">
        <?php   if ( $products_without_sku_upc_action ) echo '<img src="view/image/amazon/export.gif" rel="' . $products_without_sku_upc_action . '" class="download" alt="Download" />' ;
                else echo '<span class="download" />' ?>
    </td>
  </tr>
  <tr>
    <td><?php echo $entry_products_duplicate_sku; ?></td>
    <td class="right"><?php echo $products_duplicate_sku; ?></td>
    <td class="right"><?php echo $products_duplicate_sku_percent; ?></td>
    <td class="center">
        <?php   if ( $products_duplicate_sku_action ) echo '<img src="view/image/amazon/export.gif" rel="' . $products_duplicate_sku_action . '" class="download" alt="Download" />' ;
                else echo '<span class="download" />' ?>
    </td>
  </tr>

</tbody>
</table>
