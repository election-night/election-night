(function() {
    'use strict';

    window.ns = window.ns || {};

    // .ajax() method to link to button submit to create campaign

      $('.createCampaign')
       .on('submit', function createCampaign(event) {
          event.preventDefault();
          $.ajax({
            url: '/campaigns',
            method: 'POST' ,
            dataType: 'json',
            data: JSON.stringify({

            }),
            headers: {
              
            }

          })
        })
        .done(function handleSuccess(data){
          console.log('It worked', data);
        })
        .fail(function handleFailure(xhr){
          console.log('It didn"t work', xhr);
        })





    console.log('connected');
}());
