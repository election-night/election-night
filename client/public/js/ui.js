(function() {
    'use strict';

    window.ns = window.ns || {};

    window.ns.toggleVisible = function toggleVisible(htmlElement) {
        htmlElement.toggleClass('visible');
    };

    window.ns.candidateInfo = {};
    candidateInfo.firstName = $('#first-name').val();
    candidateInfo.lastName = $('#last-name').val();
    candidateInfo.image_url = $('#image-url').val();
    candidateInfo.intelligence = $('#intelligence').val();
    candidateInfo.charisma = $('#charisma').val();
    candidateInfo.willpower = $('#willpower').val();
    console.log('hello');

    $('.create-candidates')
        .on('click', function showCandidate(event) {
            event.preventDefault();
            window.ns.toggleVisible($('.create-a-candidate'));

        });
    $('.list-of-candidates')
        .on('click', function seeCandidates(event) {
            event.preventDefault();
            console.log('it works');
            window.ns.toggleVisible($('.list-of-candidates'));
            window.ns.candidateInfo
            // window.ns.
        });
    $('.show-campaigns')
        .on('click', function showCampaign(event) {
            event.preventDefault();
            window.ns.toggleVisible($('.all-campaigns'));
        });

    // $('.candidate-battle')
    //     $(this).append('<li><img src="' + image_url + '>' )
    $('.create-campaign')
        .on('click', function showCampaignBattle(event) {
            event.preventDefault();
            console.log('it works');
            window.ns.toggleVisible($('.create-a-campaign'));
        });

    $('.campaign-button')
        .on('click', function showWinner(event) {
            event.preventDefault();
            console.log('it works');
            window.ns.toggleVisible($('.winner'));
        });

    console.log('UI file Connected');
}());
