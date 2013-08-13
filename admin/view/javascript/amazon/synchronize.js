 $(document).ready(function() {

     // load CSS
    //
    $('head').append("<link>");
      fcss = $("head").children(":last");
      fcss.attr({
        rel:  "stylesheet",
        type: "text/css",
        href: $('#amz-css').val() + 'synchronize.css'
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

    // Tabs actions
    //
    $('a[href^=amazon-').click(function() {
        toggleActionButton() ;

       $('.result-table').hide() ;

    });
    // Button Synchronize/Lookup
    //
    $('#valid').click(function() {
      currentTab = $('#tabs').find('a.selected').attr('href') ;


      $.ajax({
            type: 'POST',
            url: $('#amz-synchronize').val() + '&callback=?',
            data: $(currentTab).find('input, select').serialize(),
            dataType:'json',
            beforeSend:
              function(data) {
                  $('#amz-result').append('<span class="loader"></span>') ;
                 },
            success: function(data) {
                  $('#amz-result').html('') ;
                  if ( data.error )
                        $('#amz-result').html('<div class="warning">'+data.some+'</div>') ;
                  else
                    if ( ! ($('.lookup:visible').attr('checked') == 'checked') )
                        $('#amz-result').html('<div class="success">' + $('#entry_synchronized').val() + '</div>') ;

                  DisplayData(data) ;
                },
            error: function(data) {
                  $('#amz-result').html('<div class="warning">'+data.responseText+'</div>') ;
                }
        });
        return(false);
    });

    function DisplayData(data)
    {
       $('#created-table tbody tr :not(eq(0))').remove();
       $('#updated-table tbody tr :not(eq(0))').remove();
       $('#deleted-table tbody tr :not(eq(0))').remove();
       $('#ignored-table tbody tr :not(eq(0))').remove();

       $('.result-table').show() ;

       //
       // Created Items
       //
       $('#created-table thead td b').html( data.count.created ) ;

       if ( data.count.created )
       {
         $.each(data.items.created, function(i,item){
              html =
              '<tr>'
                    +'<td>SKU</td>'
                    +'<td>'+item.SKU+'</td>'
                    +'<td>'+item.ProductIDType+'</td>'
      				+'<td>'+item.ProductIDCode+'</td>'
      				+'<td class="right">'+item.Quantity+'</td>'
      				+'<td class="right">'+item.Price+'</td>'
              +'</tr>' ;

              $('#created-table tr:last').after(html);
         });
       }

       //
       // Updated Items
       //
       $('#updated-table thead td b').html( data.count.updated ) ;

       if ( data.count.updated )
       {
           $.each(data.items.updated, function(i,item){
                html =
                '<tr>'
                        +'<td>SKU</td>'
                        +'<td>'+item.SKU+'</td>'
                        +'<td>'+item.ProductIDType+'</td>'
        				+'<td>'+item.ProductIDCode+'</td>'
        				+'<td class="right">'+item.Quantity+'</td>'
        				+'<td class="right">'+item.Price+'</td>'
                +'</tr>' ;

                $('#updated-table tr:last').after(html);

           });
        }

       //
       // Deleted Items
       //
       $('#deleted-table thead td b').html( data.count.deleted ) ;

       if ( data.count.deleted )
       {
           $.each(data.items.deleted, function(i,item){
                html =
                '<tr>'
                        +'<td>SKU</td>'
                        +'<td>'+item.SKU+'</td>'
                        +'<td>'+item.ProductIDType+'</td>'
        				+'<td>'+item.ProductIDCode+'</td>'
        				+'<td class="right">'+item.Quantity+'</td>'
        				+'<td class="right">'+item.Price+'</td>'
                +'</tr>' ;

                $('#updated-table tr:last').after(html);
           });
        }

       //
       // Ignored Items
       //
       $('#ignored-table thead td b').html( data.count.ignored ) ;

       if ( data.count.ignored )
       {
           $.each(data.items.ignored, function(i,item){
                html =
                '<tr>'
                        +'<td>SKU</td>'
                        +'<td>'+item.SKU+'</td>'
                        +'<td>'+item.ProductIDType+'</td>'
        				+'<td>'+item.ProductIDCode+'</td>'
        				+'<td class="right">'+item.Quantity+'</td>'
        				+'<td class="right">'+item.Price+'</td>'
                +'</tr>' ;

                $('#ignored-table tr:last').after(html);
           });
        }

       /// for debug purpose
       if ( data.debug )
        $('#some_html').html(data.some) ;
    }
});


