 $(document).ready(function() {

     // load CSS
    //
    $('head').append("<link>");
      fcss = $("head").children(":last");
      fcss.attr({
        rel:  "stylesheet",
        type: "text/css",
        href: $('#amz-css').val() + 'categories.css'
      });

    //
    // Mappage Manufacturer <> Suppliers
    //
    $('#move-right').click(function() {
        return !$('#available-categories option:selected').remove().appendTo('#selected-categories');
    });
    $('#move-left').click(function() {
        return !$('#selected-categories option:selected').remove().appendTo('#available-categories');
    });


    $('.save').click(function() {

       $('#available-categories').each(function() {
        $(this).children().attr('selected', 'selected') ;
       });
       $('#selected-categories').each(function() {
        $(this).children().attr('selected', 'selected') ;
       });

      $.ajax({
            type: 'POST',
            url: $('#amz-validation').val(),
            data: $('#form').serialize(),
            beforeSend:
              function(data) {
                  $('.validation').append('<span class="loader"></span>') ;
                 },
            success: function(data) {
                  $('.validation').html(data).slideDown() ;
                }
        });
        return(false);
    });

});