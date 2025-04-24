$(function() {

    // 사용자 검색 폼    
    const searchBtn = $('#searchBtn');
    
    searchBtn.on('click', function() {

        const userDetailForm = $('#userDetailForm');
        
        userDetailForm.action = "/user/list.do";
        userDetailForm.submit();
        
        
        
    })



})
