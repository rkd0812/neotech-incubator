package com.okestro.app.admin.menu.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.admin.menu.MenuSvc;
import com.okestro.app.admin.menu.MenuVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("menuSvc")
public class MenuSvcImpl extends EgovAccessServiceImpl implements MenuSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public int registMenu(MenuVo menuVo) {
        return dao.insert("menu.registMenu", menuVo);
    }

    @Override
    public int retrieveMenuListCnt(MenuVo menuVo) {
        return dao.selectOne("menu.retrieveMenuListCnt", menuVo);
    }

    @Override
    public List<MenuVo> retrieveMenuList(MenuVo menuVo) {
        return dao.selectList("menu.retrieveMenuList", menuVo);
    }

    @Override
    public MenuVo retrieveMenuDetail(String menuId) {
        return dao.selectOne("menu.retrieveMenuDetail", menuId);
    }

    @Override
    public int updateMenu(MenuVo menuVo) {
        return dao.update("menu.updateMenu", menuVo);
    }

    @Override
    public int deleteMenu(String menuId) {
        return dao.delete("menu.deleteMenu", menuId);
    }

    @Override
    public String getMenuIndex() {
        return dao.selectOne("menu.getmenuIndex");
    }

    @Override
    public int getMenuLevel(String menuId) {
        return dao.selectOne("menu.getmenuLevel", menuId);
    }
}
