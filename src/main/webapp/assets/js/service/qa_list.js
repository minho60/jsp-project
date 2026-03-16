

$(document).ready(function(){

    $(".date-btn").click(function(){

        let days = $(this).data("day");

        let today = new Date();
        let endDate = today.toISOString().substring(0,10);

        let start = new Date();
        start.setDate(start.getDate() - days);

        let startDate = start.toISOString().substring(0,10);

        $("#startDate").val(startDate);
        $("#endDate").val(endDate);

    });

});





function checkPassword(qaNum){

    const password = prompt("비밀번호를 입력하세요");

    if(password == null) return;

    $.post(ctx + "/qa/checkPassword", {
        qaNum: qaNum,
        guestPassword: password
    }, function(result){

        if(result.trim() === "ok"){
            location.href = ctx + "/qa/view?id=" + qaNum;
        }else{
            alert("비밀번호가 틀렸습니다.");
        }

    });

}

