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
    $('.show-candidates')
        .on('click', function seeCandidates(event) {
            event.preventDefault();
            console.log('it works');
            window.ns.toggleVisible($('.candidates'));
        });
    $('.show-campaigns')
        .on('click', function showCampaign(event) {
            event.preventDefault();
            window.ns.toggleVisible($('.all-campaigns'));
        });

    $('.create-campaign')
        .on('click', function showCampaignBattle(event) {
            event.preventDefault();
            console.log('it works');
            window.ns.toggleVisible($('.create-a-campaign'));
        });


    console.log('UI file Connected');
}());
