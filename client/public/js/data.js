(function() {
    'use strict';

    window.ns = window.ns || {};


    $('.candidate')
        .on('submit', function candidateInfo(event) {
            event.preventDefault();
            var candidateInfo = {};
            candidateInfo.firstName = $('#first-name').val();
            candidateInfo.lastName = $('#last-name').val();
            candidateInfo.image_url = $('#image-url').val();
            candidateInfo.intelligence = $('#intelligence').val();
            candidateInfo.charisma = $('#charisma').val();
            candidateInfo.willpower = $('#willpower').val();
            console.log(candidateInfo());
        });


    $('.candidate')
        .on('submit', function createCandidate(event) {
            event.preventDefault();
            $.ajax({
                    url: '/candidates',
                    method: 'GET',
                    dataType: 'json',
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
        .on('submit', function createCampaign(event) {
            event.preventDefault();
            $.ajax({
                    url: '/campaign',
                    method: 'POST',
                    dataType: 'json',
                    data: JSON.stringify({
                        first_name: candidateInfo.firstName,
                        last_name: candidateInfo.lastName,
                        image_url: candidateInfo.image_url,
                        intelligence: candidateInfo.intelligence,
                        charisma: candidateInfo.charisma,
                        willpower: candidateInfo.willpower
                    }),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .done(function campaignSuccess(data) {
                    console.log('It Worked', data);
                })
                .fail(function campaignFailure(xhr) {
                    console.log('it failed', xhr);
                })

        });




    console.log('Data file Connected');

}());