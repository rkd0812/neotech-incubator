$(function (){
    $('#search_btn').on('click', function(){
        if($('#startdate').val() === '' && $('#enddate').val() === '' &&
            $('#search-txt').val() === '' && $('#search_btn').val() === ''){
            alert('기간, 검색어, 상태 중 하나라도 입력해주세요.');
        }
    });
})