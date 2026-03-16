function checkPassword(qaNum, action) {
    // 비밀번호를 입력받기 위한 프롬프트
    const password = prompt("비밀번호를 입력하세요");

    if (password == null) return; // 비밀번호 입력 취소 시 종료

    // 비밀번호를 서버로 전달하여 인증
    $.post(ctx + "/qa/checkPassword", {
        qaNum: qaNum,
        guestPassword: password
    }, function(result) {
        if (result.trim() === "ok") {
            // 비밀번호가 맞으면 수정/삭제 작업 진행
            if (action === "edit") {
                // 수정 페이지로 이동
                location.href = ctx + "/qa/edit?id=" + qaNum;
            }

            if (action === "delete") {
                // 삭제 확인 후 진행
                if (confirm("정말 삭제하시겠습니까?")) {
                    $.post(ctx + "/qa/delete", { qaNum: qaNum }, function(deleteResult) {
                        if (deleteResult.trim() === "ok") {
                            alert("삭제되었습니다.");
                            location.href = ctx + "/qa/list"; // 목록 페이지로 리디렉션
                        } else {
                            alert("삭제에 실패했습니다.");
                        }
                    }).fail(function() {
                        // 삭제 요청 실패 시 알림
                        alert("삭제 요청에 실패했습니다.");
                    });
                }
            }

        } else {
            // 비밀번호가 틀리면 알림
            alert("비밀번호가 틀렸습니다.");
        }
    }).		fail(function(xhr, status, error) {
		        console.error("AJAX 요청 실패:", status, error); // AJAX 요청 실패 시 콘솔에 출력
    });
}