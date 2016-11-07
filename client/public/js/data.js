(function() {
        'use strict';

        window.ns = window.ns || {};

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
            .on('submit', function getCandidate(event) {
                event.preventDefault();
                $.ajax({
                        url: '/candidates',
                        method: 'GET',
                        dataType: 'json',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    })
                    .done(function handleYes(data) {
                        console.log('success', data);
                    })
                    .fail(function handleNo(xhr) {
                        console.log('failure', xhr)
                    })
            });

        // GET method for candidateID
        $( //'.')
            .on('submit', function candidateId(event) {
                event.preventDefault();
                $.ajax({
                        url: 'candidates/:id',
                        method: 'GET',
                        dataType: 'json',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    })
                    .done(function candidateIdPass(data) {
                        console.log('success', data)
                    })
                    .fail(function candidateIdFail(xhr) {
                        console.log('failure', xhr);
                    })
            });

            // Get Candidate Wins ajax

            $( //'.')
                .on('submit', function candidateIdWins(event) {
                    event.preventDefault();
                    $.ajax({
                        url: 'candidates/:id/wins',
                        method: 'GET',
                        data: 'json',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                        .done(function candidateIdWinsPass(data) {
                            console.log('pass', data)
                        })
                        .fail(function candidateIdWinsFail(xhr) {
                            console.log('failure', xhr)
                        })
                    })
                });



                $('.create-campaign')
                .on('submit', function createCampaign(event) {
                    event.preventDefault();
                    $.ajax({
                            url: '/campaigns',
                            method: 'POST',
                            dataType: 'json',
                            // data: JSON.stringify{
                            //   candidate.id:
                            // },
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