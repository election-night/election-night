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
            $('.candidates').toggleClass('visible');
        });
    $('.show-campaigns')
        .on('click', function showCampaign(event) {
            event.preventDefault();
            console.log('it works');
            $('.all-campaigns').toggleClass('visible');
        });


    console.log('UI file Connected');
}());
