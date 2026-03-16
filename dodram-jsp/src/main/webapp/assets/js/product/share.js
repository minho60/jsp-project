$(document).ready(function() {
    $('.title button').on('click', function() {
        $('.sns').fadeToggle(200);
    });

    $('.sns_top i').on('click', function() {
        $('.sns').fadeOut(200);
    });

    $('.sns_bottom button').on('click', function() {
        const urlInput = $('.sns_bottom input');
        urlInput.select();
        document.execCommand('copy');
        alert('URL이 복사되었습니다.');
    });
});