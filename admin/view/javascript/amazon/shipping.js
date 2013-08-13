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
        href: $('#amz-css').val() + 'shipping.css'
      });


	$('.import-from').each(function() {
       $(this).datepicker({dateFormat: 'yy-mm-dd'});
    });

	$('.import-to').each(function() {
       $(this).datepicker({dateFormat: 'yy-mm-dd'});
    });
    // Tabs actions
    //
    $('.amazon-tab').click(function() {
      // toggleActionButton() ;

       orders = null ;
       details = new Array() ;
       count = 0 ;

       $('#order-table tbody tr :not(eq(0))').remove();
       $('#order-table').hide() ;

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
    $('#import').click(function() {
      currentTab = $('#tabs').find('a.selected').attr('href') ;

      $.ajax({
            type: 'POST',
            url: $('#amz-shipping').val() + '&seed=' + $.now() + '&callback=?',
            data: $(currentTab).find('input, select').serialize(),
            dataType:'json',
            beforeSend:
              function(data) {
                  $('#amz-result').append('<span class="loader"></span>') ;
                 },
            success: function(data) {
                  $("#amz-result").html('<div class="success">'+data.output+'</div>') ;

                  if ( ! data.orders )  return ;

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

       currentTab = $('#tabs').find('a.selected').attr('href') ;

       if (data.count)
       {

        $('#order-table').show() ;
        i=0 ;

         $.each(data.orders, function(i,order){
              date = new Date(order.PurchaseDate) ;

              if ( ! order.OrderId )
              {
                    // Order is not imported in the shop
                    //
                    return ;
              }
              else
              {
                    checkbox = '<td><input type="checkbox" value="'+order.AmazonOrderId+'" class="order-item" name="order_id" /></td>' ;
              }

              newStatus = 'New Status' ;
              existingStatusId = '' ;

              html =
              '<tr rel="o-'+order.AmazonOrderId+'">'
                    +checkbox
                    +'<td>'+order.AmazonOrderId+'</td>'
                    +'<td>'+order.Address.Name+'</td>'
                    +'<td>'+order.ShipServiceLevel+'</td>'
      				+'<td class="right">'+date.toLocaleDateString()+'</td>'
      				+'<td class="right">'+order.OrderStatus+'</td>'
      		   //		+'<td class="right">' + newStatus + '</td>' // for future use
      				+'<td class="right"><input type="text" class="shipping-name" name="shipping_name" value="' + $(currentTab).find('input[name="shipping-defaut"]').val() + '" /></td>'
      				+'<td class="right"><input type="text" class="shipping-id" name="shipping_id" value="' + existingStatusId + '" /></td>'
                    +'</tr>'
                   ;

              $('#order-table tr:last').after(html);
              $('#update').fadeIn() ;
         });
       }
    }


    // Retrieve Orders Details
    //
     $('#update').click(function() {

        if ( ! orders ) return false ;

        var currentTab = $('#tabs').find('a.selected').attr('href') ;
        target = $("#amz-result") ;
        target.html('') ;

        var i = 0 ;
        $.each($('.order-item'), function() {

          if ( !  ($(this).attr('checked') == 'checked')  )  return ;
          if (  $(this).attr('disabled') == 'disabled'  )    return ;

          var order_id = $(this).val() ;
          var datas = $(this).parent().parent().find('input, select').serialize() ;
          var checkbox = $(this) ;

          $.ajax({
                type: 'POST',
                url: $('#amz-update').val() + '&seed=' + $.now() + '&callback=?',
                data: $(currentTab).find('input, select').serialize() + '&' + datas,
                dataType:'json',
                beforeSend:
                  function(data) {
                            target.append('<span class="loader" id="loader-'+order_id+'"><br /></span>') ;
                     },
                success: function(data) {
                      $('#loader-'+order_id).remove() ;
                      if ( data.error )
                      {
                        $.each(data.errors, function(i,error){
                          target.append('<div class="warning">'+error+'</div>') ;
                        });
                      }
                      else
                      {
                        $('tr[rel="o-' + order_id + '"]').addClass('imported') ;
                        checkbox.attr('disabled', 'disabled') ;
                        target.append('<div class="success">'+data.output+'</div>')
                      }
                    },
                error: function(data) {
                      target.append('<div class="warning">'+data.responseText+'</div>') ;
                    }
            });
            i++ ;
        });
      });




});


