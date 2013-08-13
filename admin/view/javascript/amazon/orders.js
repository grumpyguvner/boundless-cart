/* NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL SMC
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL SMC is strictly forbidden.
 * In order to obtain a license, please contact us: olivier@common-services.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe SMC
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL SMC est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter la SARL SMC a l'adresse: olivier@common-services.com
 * ...........................................................................
 * @package    Amazon Market Place
 * @copyright  Copyright (c) 2011-2011 S.A.R.L SMC (http://www.common-services.com)
 * @copyright  Copyright (c) 2011-2011 Olivier B.
 * @author     Olivier B.
 * @license    Commercial license
 * Support by mail  :  olivier@common-services.com
 * Support on forum :  delete
 * Skype : delete13_fr
 * Phone : +33.970465505
 */

 $(document).ready(function() {

    orders = null ;
    details = new Array() ;
    count = 0 ;

    // load CSS
    //
    $('head').append("<link>");
      fcss = $("head").children(":last");
      fcss.attr({
        rel:  "stylesheet",
        type: "text/css",
        href: $('#amz-css').val() + 'orders.css'
      });


	$('.import-from').each(function() {
       $(this).datepicker({dateFormat: 'yy-mm-dd'});
    });

	$('.import-to').each(function() {
       $(this).datepicker({dateFormat: 'yy-mm-dd'});
    });


    // Button Action
    //
    function toggleActionButton()
    {
        if ( $('.lookup:visible').attr('checked') == 'checked' )
            $('.action:visible').html( $('#entry_lookup').val() ) ;
        else
            $('.action:visible').html( $('#entry_submit').val() ) ;
    }
    toggleActionButton() ;

    $('.lookup').click(function() {
        toggleActionButton() ;
        return(true);
    });

    $('.action:visible').html( $('#entry_lookup').val() )

    // Tabs actions
    //
    $('.amazon-tab').click(function() {
        toggleActionButton() ;

       orders = null ;
       details = new Array() ;
       count = 0 ;

       $('.product-table tbody tr :not(eq(0))').remove();

       $('#order-table tbody tr :not(eq(0))').remove();
       $('#order-table').hide() ;

       $('#retrieve').addClass('opacity') ;
       $('#import').addClass('opacity') ;

       $('#amz-result').html('') ;
    });

    // Order Checkbox
    //
    $('#order-table tbody tr').live('click',function(event) {
        checkbox = $(this).find('.order-item') ;

        if (event.target.type !== 'checkbox')
            $(checkbox, this).trigger('click');
    });

    // Ordered Product Checkbox
    //
    $('.imported-item').live('click',function(event) {
        checkbox = $(this).find('.product-item') ;

        if (event.target.type !== 'checkbox')
            $(checkbox, this).trigger('click');
    });


    // Select All checkboxes
    //
    $('#select-all').live('click', function() {
          $('.order-item').each(function() {
            if( $(this).attr('checked') )
                  $(this).attr('checked', false) ;
            else
                if ( ! $(this).attr('disabled') )
                  $(this).attr('checked', 'checked') ;
          });
    });

    // Button Synchronize/Lookup
    //
    $('#valid').click(function() {
      currentTab = $('#tabs').find('a.selected').attr('href') ;

      $.ajax({
            type: 'POST',
            url: $('#amz-orders').val() + '&seed=' + $.now() + '&callback=?',
            data: $(currentTab).find('input, select').serialize(),
            dataType:'json',
            beforeSend:
              function(data) {
                  $('#amz-result').append('<span class="loader"></span>') ;
                 },
            success: function(data) {
                  $("#amz-result").html('<div class="success">'+data.output+'</div>')
                  if ( ! data.orders )  return ;
                  $('#retrieve').removeClass('opacity') ;
                  DisplayData(data) ;
                },
            error: function(data) {
                  $('#amz-result').html('<div class="warning">'+data.responseText+'</div>') ;
                }
        });
        return(false);
    });

//    $('#valid').click() ;

    function DisplayData(data)
    {
       orders = data ;
       details = new Array() ;

       $('#order-table tbody tr :not(eq(0))').remove();
       $('#order-table thead td b').html(data.count) ;

       if (data.count)
       {

        $('#order-table').show() ;
        i=0 ;

         $.each(data.orders, function(i,order){
              date = new Date(order.PurchaseDate) ;
             checked='';
              if ( ! order.OrderId )
              {
                    delete_o = '<td></td>' ;
                    checkbox = '<td><input type="checkbox" ' + checked + ' value="'+order.AmazonOrderId+'" class="order-item" name="orders[]" /></td>' ;
              }
              else
              {
                    checkbox = '<td><input type="checkbox" disabled="disabled" /></td>' ;
                    delete_o = '<td class="delete-order" rel="'+order.OrderId+'" align="center"><img src="view/image/amazon/delete.png" alt="delete" /></td>' ;
              }


              html =
              '<tr rel="o-'+order.AmazonOrderId+'">'
                    +checkbox
                    +'<td>'+order.AmazonOrderId+'</td>'
                    +delete_o
                    +'<td>'+order.Address.Name+'</td>'
                    +'<td>'+order.ShipServiceLevel+'</td>'
      				+'<td class="right">'+date.toLocaleDateString()+'</td>'
      				+'<td class="right">'+order.NumberOfItemsUnshipped+'</td>'
      				+'<td class="right">'+order.OrderTotalAmount+'</td>'
      				+'<td class="right">'+order.OrderTotalCurrency+'</td>'
      				+'<td class="right">'+order.OrderStatus+'</td>'
                    +'</tr>'
                    +'<tr class="item"><td>&nbsp;</td><td colspan="9" rel="'+order.AmazonOrderId+'"></td></tr>'
                   ;

              $('#order-table tr:last').after(html);
         });
       }
    }


    // Retrieve Orders Details
    //
     $('#retrieve').click(function() {

        if ( ! orders ) return false ;

        currentTab = $('#tabs').find('a.selected').attr('href') ;

        $.each($('.order-item'), function() {

          if ( ! $(this).attr('checked') )  return ;

          order_id = $(this).val() ;
          var target = null ;

          target = $('td[rel='+order_id+']') ;
          target.parent().show() ;

          $.ajax({
                type: 'POST',
                url: $('#amz-retrieve').val() + '&seed=' + $.now() + '&callback=?',
                data: 'order_id=' + order_id + '&' + $(currentTab).find('input, select').serialize(),
                dataType:'json',
                beforeSend:
                  function(data) {
                        target.append('<span class="loader"></span>') ;
                     },
                success: function(data) {
                      if ( data.error )
                      {
                        $.each(data.errors, function(i,error){
                          target.html('<div class="warning">'+error+'</div>') ;
                        });
                      }

                      $("#amz-result").html('<div class="success">'+data.output+'</div>')
                      $('#import').removeClass('opacity') ;
                      $('#product-table').clone().appendTo(target.html('')).show() ;
                      OrderDetails(data, target) ;
                    },
                error: function(data) {
                      target.html('<div class="warning">'+data.responseText+'</div>') ;
                    }
            });
        });
      });

      function OrderDetails(data, target)
      {
        var itemTable = null;

        target.find('table').attr('id', 'p-' + data.orders.AmazonOrderId) ;

        itemTable = '#p-' + data.orders.AmazonOrderId ;

        details[count] = new Object() ;
        details[count].AmazonOrderId = data.orders.AmazonOrderId ;
        details[count].NumberOfItemsUnshipped = data.orders.NumberOfItemsUnshipped ;
        details[count].OrderStatus = data.orders.OrderStatus ;
        details[count].OrderTotalAmount = data.orders.OrderTotalAmount ;
        details[count].OrderTotalCurrency = data.orders.OrderTotalCurrency ;
        details[count].PurchaseDate = data.orders.PurchaseDate ;
        details[count].ShipServiceLevel = data.orders.ShipServiceLevel ;
        details[count].Address = data.orders.Address ;
        details[count].Items = new Object() ;

        $.each(data.orders.Items, function(i,item){

              details[count].Items[i] = item ;
              details[count].Items[i].TaxesInformation = $.makeArray(item.TaxesInformation) ;
              details[count].Items[i].AmazonOrderId = data.orders.AmazonOrderId ;

              html =
              '<tr class="imported-item">'
                    +'<td><input type="checkbox" checked="checked" value="'+data.orders.AmazonOrderId + '_' + item.ASIN+'" class="product-item" name="products[]" /></td>'
                    +'<td class="status" align="center"></td>'
                    +'<td>'+item.ASIN+'</td>'
                    +'<td>'+item.SKU+'</td>'
                    +'<td>'+item.QuantityOrdered+'</td>'
                    +'<td>'+item.Title+'</td>'
                    +'<td class="right">'+item.ShippingPriceAmount+'</td>'
      				+'<td>'+item.ShippingPriceCurrency+'</td>'
      				+'<td class="right">'+item.ItemPriceAmount+'</td>'
      				+'<td>'+item.ItemPriceCurrency+'</td>'
                    +'</tr>'
                   ;

              $(itemTable + ' tr:last').after(html);
              $(itemTable + ' .status').html('') ;
              
              switch( parseInt(item.Status) )
              {
                case 1 :
                   statusImg = $('.entry_add_stock_error:eq(0)').clone().appendTo(itemTable + ' .status') ;
                   break ;
                case 2 :
                   statusImg = $('.entry_add_not_exists:eq(0)').clone().appendTo(itemTable + ' .status') ;
                   break ;
                case 3 :
                   statusImg = $('.entry_add_imported:eq(0)').clone().appendTo(itemTable + ' .status') ;
                   break ;
                default :
                   statusImg = $('.entry_add_unkwnown_error:eq(0)').clone().appendTo(itemTable + ' .status') ;
                   break ;
              }
         });

         count++ ;
      }


      // Import Order
      //
      $('#import').click(function() {

          if ( ! count )    return(false) ;

          currentTab = $('#tabs').find('a.selected').attr('href') ;

          $('#amz-error').html('') ;
          $('#amz-result').html('') ;

          $.ajax({
                type: 'POST',
                url: $('#amz-import').val() + '&seed=' + $.now() + '&callback=?',
                data: $(currentTab).find('input').serialize() + '&' + $('#form').find('input[type=checkbox]').serialize() + '&data=' + encodeURIComponent(JSON.stringify(details)),
                dataType:'json',
                beforeSend:
                  function(data) {
                        $('#amz-result').append('<span class="loader"></span>') ;
                     },
                success: function(data) {
                      if ( data.error )
                      {
                        $.each(data.errors, function(i,error){
                          $('#amz-error').append(error+'<br />') ;
                        });
                        $('#amz-error').show() ;

                      }
                      if ( ! data.count )
                      {
                          $('#amz-result').html('');
                          return(false) ;
                      }

                      // Invalidate checkboxes
                      //
                      $.each($('.order-item'), function() {
                        if ( ! $(this).attr('checked') )  return ;

                        $(this).attr('disabled', 'disabled') ;
                        $(this).val('') ;
                      });

                      if ( data.output.length )
                      {
                        $('#amz-result').html('<div class="success">'+data.output+'</div>') ;
                        $(currentTab).find('.last-import').html(data.date_import) ;
                      }
                      else
                        $('#amz-result').html('');
                    },
                error: function(data) {
                      $('#amz-result').html('<div class="warning">'+data.responseText+'</div>') ;
                    }
            });

      });

      // Delete Order
      //
      $('.delete-order').live('click', function() {
         var amazonOrderId = $(this).parent().attr('rel')  ;

         ok = confirm( $('#entry_delete_order').val() ) ;

         if ( ! ok )    return(false) ;

          $.ajax({
                type: 'POST',
                url: $('#amz-delete').val() + '&seed=' + $.now() + '&callback=?',
                data: 'order_id=' + $(this).attr('rel'),
                beforeSend:
                  function(data) {
                        $('#amz-result').append('<span class="loader"></span>') ;
                     },
                success: function(data) {
                      $('#amz-result').html('<div class="success">'+data+'</div>') ;
                      $('tr[rel=' + amazonOrderId + ']').remove() ;
                    },
                error: function(data) {
                      $('#amz-result').html('<div class="warning">'+data.responseText+'</div>') ;
                    }
            });
      });


});


