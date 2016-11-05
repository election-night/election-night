(function() {
    'use strict';

    window.ns = window.ns || {};

    function postCandidates(candidateInfo) {
        var firstname = candidateInfo.firstName
        var lastname = candidateInfo.lastName
        var avatar = candidateInfo.image_url
        var intelligence = candidateInfo.intelligence
        var charisma = candidateInfo.charisma
        var willpower = candidateInfo.willpower
        console.log(candidateInfo);

        window.ns.postCandidates = postCandidates;

        $('.candidate')
            .on('submit', function createCandidate(event) {
                event.preventDefault();
                $.ajax({
                    url: '/candidates',
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
            });


    };


    $('.candidate')
        .on('submit', function recieveCandidate(event) {
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

    $('.candidate')
        .on('submit', function updateCandidate(event) {
            event.preventDefault();
            $.ajax({
                url: '/candidates/:id/first_name',
                method: 'PATCH',
                dataType: 'json',
                data: JSON.stringify({
                    first_name: candidateInfo.firstName,
                }),
                headers: {
                    'Content-Type': 'application/json'
                }
            })
        })

    $('.create-campaign')
        .on('submit', function createCampaign(event) {
            event.preventDefault();
            $.ajax({
                    url: '/campaign',
                    method: 'POST',
                    dataType: 'json',
                    //data: JSON.stringify({
                    // "candidate1":
                    // "candidate2":
                    //    })
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