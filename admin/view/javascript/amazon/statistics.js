 $(document).ready(function() {

     // load CSS
    //
    $('head').append("<link>");
      fcss = $("head").children(":last");
      fcss.attr({
        rel:  "stylesheet",
        type: "text/css",
        href: $('#amz-css').val() + 'statistics.css'
      });

    $('#valid').click(function() {
      $.ajax({
            type: 'POST',
            url: $('#amz-statistics').val(),
            data: $('#form').serialize(),
            beforeSend:
              function(data) {
                  $('#amz-result').append('<span class="loader"></span>') ;
                 },
            success: function(data) {
                  $('#amz-result').html(data) ;
                  StatisticsInit() ;
                }
        });
    });

    function StatisticsInit()
    {
      $('.download').click(function()
      {
        action = $(this).attr('rel') ;

        $.ajax({
              type: 'POST',
              url: $('#amz-statisticsd').val(),
              data: $('#form').serialize() + '&action=' + action,
              success: function(data) {
                    $(location).attr({'href':'data:application/vnd.ms-excel;base64,' + data}) ;
                  }
         });
      });
    }

});