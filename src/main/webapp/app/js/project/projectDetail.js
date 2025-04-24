$(function (){
    $('#pro_eva').on('click', function(){
        if($('#pro_name').val() === '' || $('#explain').val() === ''){
            alert('빠진 부분이 있으니 확인해주세요.');
        }
    });
})