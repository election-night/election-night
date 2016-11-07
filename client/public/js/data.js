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
                            url: '/candidates/:id/wins',
                            method: 'GET',
                            dataType: 'json',
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

      // get candidates campaigns involved ajax

        $( //.'')
            .on('submit', function candidateCampaigns(event) {
                event.preventDefault();
                $.ajax({
                    url: '/candidates/:id/campaigns',
                    method: 'GET',
                    dataType: 'json',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                    .done(function candidateCampaignPass(data) {
                        console.log('success', data);
                    })
                    .fail(function candidateCampaignFail(xhr) {
                        console.log('failure', xhr)
                    })
                })
          });

          // PATCH METHOD FOR FIRST NAME
       $( //'.')
          .on('submit', function patchFirstName(event) {
              event.preventDefault();
              $.ajax({
                      url: '/canidates/:id/first_name',
                      method: 'PATCH',
                      dataType: 'json',
                      data: JSON.stringify({
                          // first_name:
                      }),
                      headers: {
                          'Content-Type': 'application/json'
                      }
                  })
                  .done(function patchFirstNamePass(data) {
                      console.log('success', data)
                  })
                  .fail(function patchFirstNameFail(xhr) {
                      console.log('failure', xhr)
                  })
          })

        // PATCH METHOD FOR LAST NAME

        $( //'.')
            .on('submit', function patchLastName(event) {
                event.preventDefault();
                $.ajax({
                        url: '/candidates/:id/last_name',
                        method: 'PATCH',
                        dataType: 'json',
                        data: JSON.stringify({
                            //last_name:
                          })
                        })
                        .done(function patchLastNamePass(data) {
                          console.log('success', data)
                        })
                        .fail(function patchLastNameFail(xhr) {
                            console.log('failure', xhr)
                  })
            });

          // PATCH METHOD FOR image_url

        $( //'.')
            .on('submit', function patchImageUrl(event) {
                event.preventDefault();
                $.ajax({
                        url: '/candidates/:id/image_url',
                        method: 'PATCH',
                        dataType: 'json',
                        data: JSON.stringify({
                          //image_url:
                        }),
                        headers: {
                            'Content-Type': 'application/json'

                    })
                    .done(function patchImageUrlPass(data) {
                        console.log('success', data);
                    })
                    .fail(function patchImageUrlFail(xhr) {
                        console.log('failure', xhr);
                    })
            });

          // PATCH METHOD FOR characteristics

        $(//'.')
              .on('submit', function candidateCharacteristics(event){
                event.preventDefault();
                $.ajax({
                  url: '/candidates/:id/characteristics',
                  method: 'PATCH',
                  dataType: 'json',
                  data: JSON.stringify({
                    // intelligence:
                    // charisma:
                    // willpower:
                  }),
                  headers: {
                    'Content-Type': 'application/json'
                  }
                })
                .done(function characteristicsPass(data){
                  console.log('success', data);
                })
                .fail(function characteristicsFail(xhr){
                  console.log('failure', xhr);
                })
              });

        // DELETE METHOD TO REMOVE CANDIDATE

        $(//'.')
              .on('submit', function deleteCandidate(event){
                $.ajax({
                  url: '/candidates/:id',
                  method: 'DELETE',
                  dataType: 'json',
                  headers: {
                    'Content-Type':'application/json'
                  }

                })
                .done(function DeletecandidatePass(data){
                  console.log('success', data);
                })
                .fail(function DeletecandidateFail(xhr){
                  console.log('failure', xhr);
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

        $(//'.')
              .on('submit', function getCampaignInfo(event){
                event.preventDefault();
                $.ajax({
                  url: '/candidates/:id/total_points',
                  method: 'GET',
                  dataType: 'json',
                  headers: {
                    'Content-Type':'application/json'
                  }
                })
                .done(function getCampaignInfoPass(data) {
                    console.log('It Worked', data);
                })
                .fail(function getCampaignInfoFail(xhr) {
                    console.log('it failed', xhr);
                })
              });



  console.log('Data file Connected');

}());
