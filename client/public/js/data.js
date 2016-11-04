(function() {
    'use strict';

    window.ns = window.ns || {};

    $('.create-candidates')
      .on('click', function showCandidate(event){
        event.preventDefault();
        console.log('it works');
        console.log($('.create-a-candidate') );
        $('.create-a-candidate').toggleClass('visible');

      })


    $('.candidate')
        .on('submit', function createCandidate(event) {
            event.preventDefault();
            $.ajax({
                    url: '/candidates',
                    method: 'GET',
                    dataType: 'json',
                    data: JSON.stringify({
                      // 'first name':,
                      // 'last name':,
                      // 'image_url':,
                      // 'intelligence':,
                      // 'charisma':,
                      // 'willpower':
                    }),
                    headers: {
                      'Content-Type': 'application/json'
                    }
                })
                .done(function handleSuccess(data) {
                    console.log('It worked', data);
                })
                // Include statements shown to the user that the data did not go through
                // else there was a 500 server error
                .fail(function handleFailure(xhr) {
                    console.log('It didn"t work', xhr);
                });


        });

      $('.create-campaign')
        .on('submit', function createCampaign(event){
          event.preventDefault();
          $.ajax({
            url:'/campaigns',
            method: 'POST',
            dataType: 'json',
            // data: JSON.stringify{
            //   'candidates':
            //   'start_date':
            // },
            headers: {
              'Content-Type':'application/json'
            }
          })
          .done(function campaignSuccess(data){
            console.log('It Worked', data);
          })
          .fail(function campaignFailure(xhr){
            console.log('it failed', xhr);
          })

        });




    console.log('Data file Connected');

}());
