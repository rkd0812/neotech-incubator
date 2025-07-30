$(function () {

    loadExistingTeamMembers();

    $('#updateBtn').on('click', function () {
        if (confirm('프로젝트를 수정하시겠습니까?')) {
            submitForm();
        }
    });

    // 취소 버튼 클릭
    $('#cancleBtn').on('click', function () {
        var projectId = $('#projectId').val();
        location.href = '/project/projectDetail.do?projectId=' + projectId;
    });

    // 삭제 버튼 클릭
    $('#deleteBtn').on('click', function () {
        if (confirm('정말로 이 프로젝트를 삭제하시겠습니까?')) {
            $('#deleteForm').submit();
        }
    });

    $('#fileInput').on('change', function() {
        handleFileSelect();
    });

    function handleFileSelect() {
        var fileInput = $('#fileInput')[0];
        var file = fileInput.files[0];

        if (file) {
            var maxSize = 50 * 1024 * 1024;
            if (file.size > maxSize) {
                alert('파일 크기는 50MB 이하만 가능합니다.');
                $('#fileInput').val('');
                $('#fileInfo').text('파일을 선택해주세요. (최대 50MB)');
                $('#removeNewFileBtn').hide();
                return;
            }

            $('#deleteFile').val('false');
            var fileSize = getFileSizeText(file.size);
            $('#fileInfo').html('<strong>' + file.name + '</strong> (' + fileSize + ') - 업로드 준비완료');
            $('#removeNewFileBtn').show();
        } else {
            $('#fileInfo').text('파일을 선택해주세요. (최대 50MB)');
            $('#removeNewFileBtn').hide();
        }
    }

    function getFileSizeText(bytes) {
        if (bytes < 1024) {
            return bytes + ' B';
        } else if (bytes < 1024 * 1024) {
            return (bytes / 1024).toFixed(1) + ' KB';
        } else {
            return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
        }
    }

    // 폼 제출 함수
    function submitForm() {
        var form = $('#projectForm');

        form.submit();
    }
});

// 현재 파일 삭제 함수
function deleteCurrentFile() {
    $('#deleteFile').val('true');
    $('#fileInput').val('');
    $('#removeNewFileBtn').hide();

    // 현재 파일 표시 영역 숨기기
    $('#currentFileDisplay').hide();
    $('#fileInfo').text('파일을 선택해주세요. (최대 50MB)');
}
var selectedTeamMembers = [];

function loadExistingTeamMembers() {
    // JSP에서 전달받은 데이터 확인
    if (typeof existingTeamMemberNames !== 'undefined' && existingTeamMemberNames.trim() !== '') {
        var names = existingTeamMemberNames.split(',');
        var emails = existingTeamMemberEmails.split(',');

        // 팀원 정보를 배열에 저장
        selectedTeamMembers = [];
        for (var i = 0; i < names.length; i++) {
            if (names[i].trim() !== '' && emails[i].trim() !== '') {
                selectedTeamMembers.push({
                    name: names[i].trim(),
                    email: emails[i].trim()
                });
            }
        }
    }

    // 화면 업데이트
    updateTeamMemberDisplay();
}



// 팀원 목록 화면 업데이트 함수
function updateTeamMemberDisplay() {
    var html = '';

    if (selectedTeamMembers.length === 0) {
        html = '<div style="color: #666; margin-top: 10px;">선택된 팀원이 없습니다.</div>';
    } else {
        selectedTeamMembers.forEach(function(member, index) {
            html += '<div style="margin-top: 8px; padding: 8px; background-color: #f5f5f5; border-radius: 3px; width: 650px; display: flex; justify-content: space-between; align-items: center;">';
            html += '<span>팀원: ' + member.name + '</span>';
            html += '<button type="button" onclick="removeTeamMember(' + index + ')" style="padding: 2px 8px; background-color: #dc3545; color: white; border: none; border-radius: 3px; cursor: pointer; font-size: 12px;">삭제</button>';
            html += '</div>';
        });
    }

    $('#selectedMembers').html(html);

    // hidden input 업데이트
    var emails = selectedTeamMembers.map(function(member) {
        return member.email;
    }).join(',');

    var names = selectedTeamMembers.map(function(member) {
        return member.name;
    }).join(',');

    $('#teamMemberEmails').val(emails);
    $('#teamMemberNames').val(names);
}

// 팝업창 열기 함수
function openPopup() {
    var popupWidth = 1000;
    var popupHeight = 600;

    // 현재 브라우저 창의 위치와 크기를 기준으로 계산
    var left = window.screenX + (window.outerWidth / 2) - (popupWidth / 2);
    var top = window.screenY + (window.outerHeight / 2) - (popupHeight / 2);

    var option = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',scrollbars=yes,resizable=yes';

    var selectedEmails = selectedTeamMembers.map(function(member) {
        return member.email;
    }).join(',');

    var url = '/project/popup/teamMemberSelect.do';
    if (selectedEmails) {
        url += '?selectedEmails=' + encodeURIComponent(selectedEmails);
    }

    window.open(url, 'teamPopup', option);
}

// 팝업에서 선택된 멤버
function receiveSelectedMembers(members) {
    selectedTeamMembers = [];

    if (members.length > 0) {
        members.forEach(function(member) {
            selectedTeamMembers.push({
                name: member.name,
                email: member.email
            });
        });
    }
    updateTeamMemberDisplay();
}

// 팀원 삭제 함수
function removeTeamMember(index) {
    var removedMember = selectedTeamMembers[index];
    selectedTeamMembers.splice(index, 1);
    updateTeamMemberDisplay();
    alert(removedMember.name + ' 팀원이 삭제되었습니다.');
}

// 모든 팀원 삭제 함수
function clearAllTeamMembers() {
    if (selectedTeamMembers.length > 0 && confirm('모든 팀원을 삭제하시겠습니까?')) {
        selectedTeamMembers = [];
        updateTeamMemberDisplay();
        alert('모든 팀원이 삭제되었습니다.');
    }
}

function removeSelectedFile() {
    $('#fileInput').val('');
    $('#fileInfo').text('파일을 선택하면 기존 파일이 교체됩니다. (최대 50MB)');
    $('#removeNewFileBtn').hide();
    $('#deleteFile').val('false');
}