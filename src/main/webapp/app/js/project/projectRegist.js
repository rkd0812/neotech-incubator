$(function() {
    updateCharCount();

    $('#projectDetail').on('input', function() {
        updateCharCount();
    });

    // // 파일 선택했을 때 처리
    // $('#uploadFile').on('change', function() {
    //     handleFileSelect();
    // });

    function updateCharCount() {
        var length = $('#projectDetail').val().length;
        $('#charCount').text(length);

        if (length > 1000) {
            $('#charCount').css('color', 'red');
        } else {
            $('#charCount').css('color', 'black');
        }
    }

    // // 파일 선택 처리
    // function handleFileSelect() {
    //     var fileInput = $('#uploadFile')[0];
    //     var file = fileInput.files[0];
    //
    //     if (file) {
    //         // 파일 크기 체크 (50MB)
    //         var maxSize = 50 * 1024 * 1024;
    //         if (file.size > maxSize) {
    //             alert('파일 크기는 50MB 이하만 가능합니다.');
    //             $('#uploadFile').val('');
    //             $('#fileInfo').text('파일을 선택해주세요. (최대 50MB, pdf/jpg/jpeg/png/doc/docx/zip/txt 가능)');
    //             return;
    //         }
    //
    //         // 파일 확장자 체크
    //         var fileName = file.name;
    //         var extension = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
    //         var allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx', 'zip', 'txt'];
    //
    //         if (allowedExtensions.indexOf(extension) === -1) {
    //             alert('허용되지 않는 파일 형식입니다.\n(pdf, jpg, jpeg, png, doc, docx, zip, txt만 가능)');
    //             $('#uploadFile').val('');
    //             $('#fileInfo').text('파일을 선택해주세요. (최대 50MB, pdf/jpg/jpeg/png/doc/docx/zip/txt 가능)');
    //             return;
    //         }
    //
    //         // 파일 정보 표시
    //         var fileSize = getFileSizeText(file.size);
    //         $('#fileInfo').html('<strong>' + fileName + '</strong> (' + fileSize + ')');
    //
    //     } else {
    //         $('#fileInfo').text('파일을 선택해주세요. (최대 50MB, pdf/jpg/jpeg/png/doc/docx/zip/txt 가능)');
    //     }
    // }

    // // 파일 크기를 읽기 쉬운 형태로 변환
    // function getFileSizeText(bytes) {
    //     if (bytes < 1024) {
    //         return bytes + ' B';
    //     } else if (bytes < 1024 * 1024) {
    //         return (bytes / 1024).toFixed(1) + ' KB';
    //     } else {
    //         return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
    //     }
    // }


    // 목록 버튼
    $('#listBtn').on('click', function() {
        if (confirm('작성 중인 내용이 사라집니다. 정말 목록으로 이동하시겠습니까?')) {
            location.href = '/project/projectList.do';
        }
    });

    // 등록
    $('#projectForm').on('submit', function(e) {
        if (!checkForm()) {
            e.preventDefault(); // 폼 제출 중단
            return false;
        }
        // 검증 통과하면 자동으로 폼 제출됨
        return true;
    });


    // function receiveSelectedMembers(members) {
    //     if (members.length > 0) {
    //         console.log('받은 members 데이터:', members);
    //         //이메일, 이름 배열로 받기
    //         var emails = [];
    //         var names= [];
    //
    //         for (var i = 0; i <members.length; i++) {
    //             emails.push(members[i].email);
    //             names.push(members[i].name);
    //         }
    //
    //         $('#teamMemberEmails').val(emails.join(','));
    //         $('#teamMemberNames').val(names.join(','));
    //
    //         var displayText = '+ ' + names.join(', ');
    //         $('#selectedMembers').text(displayText);
    //
    //         alert(names.join(', ') + ' 팀원이 추가되었습니다.');
    //     }
    // }


    function checkForm() {
        var projectName = $('#projectName').val().trim();

        if (!projectName) {
            alert('프로젝트명을 입력해주세요.');
            $('#projectName').focus();
            return false;
        }

        if (projectName.length > 100) {
            alert('프로젝트명은 100자 이내로 입력해주세요.');
            $('#projectName').focus();
            return false;
        }

        var detail = $('#projectDetail').val();
        if (detail.length > 1000) {
            alert('프로젝트 설명은 1000자 이내로 입력해주세요.');
            $('#projectDetail').focus();
            return false;
        }

        // 파일 관련 체크
        var url = $('#url').val().trim();
        if (url.length > 200) {
            alert('URL은 200자 이내로 입력해주세요.');
            $('#url').focus();
            return false;
        }

        // // 파일 관련 최종 체크
        // var fileInput = $('#uploadFile')[0];
        // if (fileInput.files.length > 0) {
        //     var file = fileInput.files[0];
        //     var maxSize = 50 * 1024 * 1024;
        //
        //     if (file.size > maxSize) {
        //         alert('파일 크기는 50MB 이하만 가능합니다.');
        //         return false;
        //     }
        // }
        return true;
    }

});

// 팝업창 열기 함수
function openPopup() {
    var popupWidth = 1000;
    var popupHeight = 600;

    // 현재 브라우저 창의 위치와 크기를 기준으로 계산
    var left = window.screenX + (window.outerWidth / 2) - (popupWidth / 2);
    var top = window.screenY + (window.outerHeight / 2) - (popupHeight / 2);

    var option = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',scrollbars=yes,resizable=yes';

    window.open('/project/popup/teamMemberSelect.do', 'teamPopup', option);
}

// 팝업에서 선택된 멤버를 받는 함수
function receiveSelectedMembers(members) {
    if (members.length > 0) {

        // 선택된 팀원 이름들만 추출
        var emails = [];
        var names = [];

        for (var i = 0; i < members.length; i++) {
            emails.push(members[i].email);
            names.push(members[i].name);
        }

        // hidden input에 데이터 저장
        $('#teamMemberEmails').val(emails.join(','));
        $('#teamMemberNames').val(names.join(','));

        // 화면에 선택된 팀원 표시
        var displayText = '+ ' + names.join(', ');
        $('#selectedMembers').text(displayText);
    }
}