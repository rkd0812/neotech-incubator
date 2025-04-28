package com.okestro.app.menu.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.menu.MenuSvc;
import com.okestro.app.menu.MenuVo;
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
        return dao.insert("registMenu", menuVo);
    }

    @Override
    public List<MenuVo> retrieveMenuList(MenuVo menuVo) {
        return dao.selectList("retrieveMenuList", menuVo);
    }

    @Override
    public MenuVo retrieveMenuDetail(MenuVo menuVo) {
        return dao.selectOne("retrieveMenuDetail", menuVo);
    }

    @Override
    public int updateMenu(MenuVo menuVo) {
        return dao.update("updateMenu", menuVo);
    }

    @Override
    public int deleteMenu(String menuId) {
        return dao.delete("deleteMenu", menuId);
    }

}
