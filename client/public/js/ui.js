(function() {
    'use strict';

    window.ns = window.ns || {};

    window.ns.toggleVisible = function toggleVisible(htmlElement){
      htmlElement.toggleClass('visible');
    }

    $('.create-candidates')
        .on('click', function showCandidate(event) {
            event.preventDefault();
            window.ns.toggleVisible($('.create-a-candidate'));
        });
    $('.list-of-candidates')
        .on('click', function seeCandidates(event) {
            event.preventDefault();
            console.log('it works');
            window.ns.toggleVisible($('.candidates'));
            var candidateInfo = {};
            candidateInfo.firstName = $('#first-name').val();
            candidateInfo.lastName = $('#last-name').val();
            candidateInfo.image_url = $('#image-url').val();
            candidateInfo.intelligence = $('#intelligence').val();
            candidateInfo.charisma = $('#charisma').val();
            candidateInfo.willpower = $('#willpower').val();
            console.log('hello');
            window.ns.postCandidates(candidateInfo);
            // window.ns.
        });
    $('.show-campaigns')
        .on('click', function showCampaign(event) {
            event.preventDefault();
            window.ns.toggleVisible($('.all-campaigns'));
        });

    // $('.candidate-battle')
    //     $(this).append('<li><img src="' + image_url + '>' )

    console.log('UI file Connected');
}());
