 $(document).ready(function() {

     // load CSS
    //
    $('head').append("<link>");
      fcss = $("head").children(":last");
      fcss.attr({
        rel:  "stylesheet",
        type: "text/css",
        href: $('#amz-css').val() + 'lookup.css'
      });

    $('.lookup').click(function() {
      button = $(this);

      currentTab = $('#tabs').find('a.selected').attr('href') ;

      if ( ! $(currentTab).find('input[name="value"]').val() )
      {
         alert('Value must be set !') ;
         return(false);
      }

      //
      create = $('#content').find('.create') ;
      categories = $('#content').find('.categories') ;
      selector = $(currentTab).find('.type') ;
      value = $(currentTab).find('.input-value').val() ;

      // Switch automaticaly to ASIN
      //
      if ( value[0].match('[A-Za-z]') )
      {
        selector.attr('selected', false) ;
        selector.find('option:last-child').attr('selected', 'selected') ;
      }

      datas  = $(currentTab).find('input').serialize() ;
      datas += '&' + $(currentTab).find('select').serialize() ;

      $.ajax({
            type: 'POST',
            url: $('#amz-lookup').val() + '&seed=' + $.now() + '&callback=?',
            data: datas,
            dataType:'json',
            beforeSend:
              function(data) {
                  $('#amz-result').html('<span class="loader"></span>') ;
                 },
            success: function(data) {

                  if ( data.error )
                  {
                    $('#amz-result').html('<br /><br /><br /><br />') ;
                    $('#amz-result').append('<div class="warning">' + data.error + '</div>') ;
                  }
                  else
                  {
                    categories.show();
                    create.show();

                    $('#amz-result').html(data.html) ;

                    $('.create').unbind('click');
                    $('.create').click(function() {
                        category = $(this).parent().parent().find('select[name=categories]') ;

                        if ( ! parseInt(category.val()) )
                        {
                          alert( $('#amz-choose-cat').val() ) ;
                          return(false) ;
                        }

                        CreateProduct(data.data, category.serialize(), $(currentTab).find('input[name=language]').serialize()) ;
                    });
                  }
                },
            error: function(data) {
                    $('#amz-result').html('<br /><br /><br /><br />') ;
                    $('#amz-result').append('<div class="warning">' + data.error + '</div>') ;
                }
        });
    });
    function CreateProduct(json, category, language)
    {
      console.log(language);
      $.ajax({
            type: 'POST',
            url: $('#amz-create').val() + '&seed=' + $.now() +  '&' + language + '&' + category + '&callback=?',
            data: json,
            dataType:'json',
            beforeSend:
              function(data) {
                  $('#amz-result').html('<span class="loader"></span>') ;
                 },
            success: function(data) {
                 $('#amz-result').html('<br /><br /><br /><br />') ;
                 $('#amz-result').append('<div class="success">' + data.message + '</div>') ;
                 $('#amz-result').append('<br /><br />') ;
                 $('#amz-result').append(data.edit_message) ;
                 $('#amz-result').append('<br /><br />') ;
                 $('#amz-result').append(data.some_data) ;

            },
            error: function(data) {
                 console.log(data) ;
            }
      });

    }

});