// $(function() {
//     updateCharCount();
//
//     $('#projectDetail').on('input', function() {
//         updateCharCount();
//     });
//
//     // 파일 선택했을 때 처리
//     $('#uploadFile').on('change', function() {
//         handleFileSelect();
//     });
//
//     function updateCharCount() {
//         var length = $('#projectDetail').val().length;
//         $('#charCount').text(length);
//
//         if (length > 1000) {
//             $('#charCount').css('color', 'red');
//         } else {
//             $('#charCount').css('color', 'black');
//         }
//     }
//
//     $('#fileInput').on('change', function() {
//         handleFileSelect();
//     });
//
//     // 파일 선택 처리
//     function handleFileSelect() {
//         var fileInput = $('#fileInput')[0];
//         var file = fileInput.files[0];
//
//         if (file) {
//             // 파일 크기 체크 (50MB)
//             var maxSize = 50 * 1024 * 1024;
//             if (file.size > maxSize) {
//                 alert('파일 크기는 50MB 이하만 가능합니다.');
//                 $('#fileInput').val('');
//                 $('#fileInfo').text('파일을 선택해주세요. (최대 50MB)');
//                 return;
//             }
//
//             // 파일을 Base64로 인코딩
//             var reader = new FileReader();
//             reader.onload = function(e) {
//                 var base64Data = e.target.result.split(',')[1]; // data:image/png;base64, 부분 제거
//                 $('#fileData').val(base64Data);
//                 $('#fileName').val(file.name);
//
//                 var fileSize = getFileSizeText(file.size);
//                 $('#fileInfo').html('<strong>' + file.name + '</strong> (' + fileSize + ') - 업로드 준비완료');
//             };
//             reader.readAsDataURL(file);
//
//         } else {
//             $('#fileData').val('');
//             $('#fileName').val('');
//             $('#fileInfo').text('파일을 선택해주세요. (최대 50MB)');
//         }
//     }
//
//     function getFileSizeText(bytes) {
//         if (bytes < 1024) {
//             return bytes + ' B';
//         } else if (bytes < 1024 * 1024) {
//             return (bytes / 1024).toFixed(1) + ' KB';
//         } else {
//             return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
//         }
//     }
//
//
//     // 목록 버튼
//     $('#listBtn').on('click', function() {
//         if (confirm('작성 중인 내용이 사라집니다. 정말 목록으로 이동하시겠습니까?')) {
//             location.href = '/project/projectList.do';
//         }
//     });
//
//     // 등록
//     $('#projectForm').on('submit', function(e) {
//         if (!checkForm()) {
//             e.preventDefault(); // 폼 제출 중단
//             return false;
//         }
//         // 검증 통과하면 자동으로 폼 제출됨
//         return true;
//     });
//
//
//     // function receiveSelectedMembers(members) {
//     //     if (members.length > 0) {
//
//     //         //이메일, 이름 배열로 받기
//     //         var emails = [];
//     //         var names= [];
//     //
//     //         for (var i = 0; i <members.length; i++) {
//     //             emails.push(members[i].email);
//     //             names.push(members[i].name);
//     //         }
//     //
//     //         $('#teamMemberEmails').val(emails.join(','));
//     //         $('#teamMemberNames').val(names.join(','));
//     //
//     //         var displayText = '+ ' + names.join(', ');
//     //         $('#selectedMembers').text(displayText);
//     //
//     //         alert(names.join(', ') + ' 팀원이 추가되었습니다.');
//     //     }
//     // }
//
//
//     function checkForm() {
//         var projectName = $('#projectName').val().trim();
//
//         if (!projectName) {
//             alert('프로젝트명을 입력해주세요.');
//             $('#projectName').focus();
//             return false;
//         }
//
//         if (projectName.length > 100) {
//             alert('프로젝트명은 100자 이내로 입력해주세요.');
//             $('#projectName').focus();
//             return false;
//         }
//
//         var detail = $('#projectDetail').val();
//         if (detail.length > 1000) {
//             alert('프로젝트 설명은 1000자 이내로 입력해주세요.');
//             $('#projectDetail').focus();
//             return false;
//         }
//
//         // 파일 관련 체크
//         var url = $('#url').val().trim();
//         if (url.length > 200) {
//             alert('URL은 200자 이내로 입력해주세요.');
//             $('#url').focus();
//             return false;
//         }
//
//         // 파일 관련 최종 체크
//         var fileInput = $('#uploadFile')[0];
//         if (fileInput.files.length > 0) {
//             var file = fileInput.files[0];
//             var maxSize = 50 * 1024 * 1024;
//
//             if (file.size > maxSize) {
//                 alert('파일 크기는 50MB 이하만 가능합니다.');
//                 return false;
//             }
//         }
//         return true;
//     }
//
// });
//
// var selectedTeamMembers = [];
//
// function openPopup() {
//     var popupWidth = 1000;
//     var popupHeight = 600;
//
//     var left = window.screenX + (window.outerWidth / 2) - (popupWidth / 2);
//     var top = window.screenY + (window.outerHeight / 2) - (popupHeight / 2);
//
//     var option = 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top + ',scrollbars=yes,resizable=yes';
//
//     var selectedEmails = selectedTeamMembers.map(function(member) {
//         return member.email;
//     }).join(',');
//
//     var url = '/project/popup/teamMemberSelect.do';
//     if (selectedEmails) {
//         url += '?selectedEmails=' + encodeURIComponent(selectedEmails);
//     }
//
//     window.open(url, 'teamPopup', option);
// }
//
// // 팝업에서 선택된 멤버
// function receiveSelectedMembers(members) {
//     selectedTeamMembers = [];
//
//     if (members.length > 0) {
//         members.forEach(function(member) {
//             selectedTeamMembers.push({
//                 name: member.name,
//                 email: member.email
//             });
//         });
//     }
//     updateTeamMemberDisplay();
// }
//
// // 팀원 목록 화면 업데이트 함수
// function updateTeamMemberDisplay() {
//     var html = '';
//
//     if (selectedTeamMembers.length === 0) {
//         html = '<div style="color: #666; margin-top: 10px;">선택된 팀원이 없습니다.</div>';
//     } else {
//         selectedTeamMembers.forEach(function(member, index) {
//             html += '<div style="margin-top: 8px; padding: 8px; background-color: #f5f5f5; border-radius: 3px; width: 650px; display: flex; justify-content: space-between; align-items: center;">';
//             html += '<span>팀원: ' + member.name + '</span>';
//             html += '<button type="button" onclick="removeTeamMember(' + index + ')" style="padding: 2px 8px; background-color: #dc3545; color: white; border: none; border-radius: 3px; cursor: pointer; font-size: 12px;">삭제</button>';
//             html += '</div>';
//         });
//     }
//
//     $('#selectedMembers').html(html);
//
//     // hidden input 업데이트
//     var emails = selectedTeamMembers.map(function(member) {
//         return member.email;
//     }).join(',');
//
//     var names = selectedTeamMembers.map(function(member) {
//         return member.name;
//     }).join(',');
//
//     $('#teamMemberEmails').val(emails);
//     $('#teamMemberNames').val(names);
// }
//
// // 모든 팀원 삭제 함수 (필요시 사용)
// function clearAllTeamMembers() {
//     if (selectedTeamMembers.length > 0 && confirm('모든 팀원을 삭제하시겠습니까?')) {
//         selectedTeamMembers = [];
//         updateTeamMemberDisplay();
//         alert('모든 팀원이 삭제되었습니다.');
//     }
// }


$(function() {
    updateCharCount();

    $('#projectDetail').on('input', function() {
        updateCharCount();
    });

    // 새로운 Base64 방식 파일 처리
    $('#fileInput').on('change', function() {
        handleFileSelect();
    });

    function updateCharCount() {
        var length = $('#projectDetail').val().length;
        $('#charCount').text(length);

        if (length > 1000) {
            $('#charCount').css('color', 'red');
        } else {
            $('#charCount').css('color', 'black');
        }
    }

    // Base64 파일 선택 처리
    function handleFileSelect() {
        var fileInput = $('#fileInput')[0];
        var file = fileInput.files[0];

        if (file) {
            // 파일 크기 체크 (50MB)
            var maxSize = 50 * 1024 * 1024;
            if (file.size > maxSize) {
                alert('파일 크기는 50MB 이하만 가능합니다.');
                $('#fileInput').val('');
                $('#fileInfo').text('파일을 선택해주세요. (최대 50MB)');
                return;
            }

            // 파일을 Base64로 인코딩
            var reader = new FileReader();
            reader.onload = function(e) {
                var base64Data = e.target.result.split(',')[1];
                $('#fileData').val(base64Data);
                $('#fileName').val(file.name);

                var fileSize = getFileSizeText(file.size);
                $('#fileInfo').html('<strong>' + file.name + '</strong> (' + fileSize + ') - 업로드 준비완료');
            };
            reader.readAsDataURL(file);

        } else {
            $('#fileData').val('');
            $('#fileName').val('');
            $('#fileInfo').text('파일을 선택해주세요. (최대 50MB)');
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

    // 목록 버튼
    $('#listBtn').on('click', function() {
        if (confirm('작성 중인 내용이 사라집니다. 정말 목록으로 이동하시겠습니까?')) {
            location.href = '/project/projectList.do';
        }
    });

    // 등록
    $('#projectForm').on('submit', function(e) {
        if (!checkForm()) {
            e.preventDefault();
            return false;
        }
        return true;
    });

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

        var url = $('#url').val().trim();
        if (url.length > 200) {
            alert('URL은 200자 이내로 입력해주세요.');
            $('#url').focus();
            return false;
        }

        return true;
    }
});

// 팀원 관련 함수들은 그대로 유지
var selectedTeamMembers = [];

function openPopup() {
    var popupWidth = 1000;
    var popupHeight = 600;

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

    var emails = selectedTeamMembers.map(function(member) {
        return member.email;
    }).join(',');

    var names = selectedTeamMembers.map(function(member) {
        return member.name;
    }).join(',');

    $('#teamMemberEmails').val(emails);
    $('#teamMemberNames').val(names);
}

function clearAllTeamMembers() {
    if (selectedTeamMembers.length > 0 && confirm('모든 팀원을 삭제하시겠습니까?')) {
        selectedTeamMembers = [];
        updateTeamMemberDisplay();
        alert('모든 팀원이 삭제되었습니다.');
    }
}