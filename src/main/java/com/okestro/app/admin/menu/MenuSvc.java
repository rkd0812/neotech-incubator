package com.okestro.app.admin.menu;

import java.util.List;

public interface MenuSvc {

    // 메뉴 등록
    public int registMenu(MenuVo menuVo);
    // 메뉴 목록조회
    public List<MenuVo> retrieveMenuList(MenuVo menuVo);
    // 메뉴 상세조회
    public MenuVo retrieveMenuDetail(String menuId);
    // 메뉴 수정
    public int updateMenu(MenuVo menuVo);
    // 메뉴 삭제
    public int deleteMenu(String menuId);
    // 메뉴 인덱스
    String getMenuIndex();
    // 메뉴 레벨
    int getMenuLevel(String menuId);
}
