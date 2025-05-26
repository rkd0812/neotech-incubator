package com.okestro.app.admin.menu;

import java.util.List;

public interface MenuSvc {

    // 메뉴 등록
    int registMenu(MenuVo menuVo);
    // 메뉴 목록 개수 조회
    int retrieveMenuListCnt(MenuVo menuVo);
    // 메뉴 목록조회
    List<MenuVo> retrieveMenuList(MenuVo menuVo);
    // 메뉴 상세조회
    MenuVo retrieveMenuDetail(String menuId);
    // 메뉴 수정
    int updateMenu(MenuVo menuVo);
    // 메뉴 삭제
    int deleteMenu(String menuId);
    // 메뉴 인덱스
    String getMenuIndex();
    // 메뉴 레벨
    int getMenuLevel(String menuId);
}
