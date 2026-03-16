$(document).ready(function(){
    $('.tab-btn').click(function(){
        const tab = $(this).data('tab');
        $('.tab-btn').removeClass('active');
        $(this).addClass('active');

        if(tab === 'all'){
            $('.event-card').show();
        } else {
            $('.event-card').hide();
            $('.event-card[data-tab="'+tab+'"]').show();
        }

        if($('.event-card:visible').length === 0){
            if($('#eventList .empty').length === 0){
                $('#eventList').append('<li class="empty">해당 이벤트가 없습니다.</li>');
            }
        } else {
            $('#eventList .empty').remove();
        }
    });
});
