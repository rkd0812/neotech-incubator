package com.okestro.app.menu;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class MenuCtr {

    @Resource(name="menuSvc")
    MenuSvc menuSvc;

    // 메뉴 등록화면 이동
    @GetMapping("/menu/openRegist.do")
    public String openRegistMenu() {

        return "menu/menuRegist";
    }

    // 메뉴 등록
    @PostMapping("/menu/regist.do")
    public String registMenu(@ModelAttribute MenuVo menuVo, Model model) {
        int cnt = menuSvc.registMenu(menuVo);

        return "redirect:/menu/list.do";
    }

    // 메뉴 목록조회
    @GetMapping("/menu/list.do")
    public String retrieveMenuList(@ModelAttribute MenuVo menuVo, Model model) {

        model.addAttribute("menuVo", menuVo);

        List<MenuVo> menuList = menuSvc.retrieveMenuList(menuVo);
        model.addAttribute("menuList", menuList);
        
        return "menu/menuList";
    }

    // 메뉴 상세조회
    @GetMapping("/menu/detail.do")
    public String retrieveMenuDetail(@ModelAttribute MenuVo menuVo, Model model) {

        MenuVo menuDetail = menuSvc.retrieveMenuDetail(menuVo);
        model.addAttribute("menuDetail", menuDetail);

        return "menu/menuDetail";
    }

    // 메뉴 수정
    @PostMapping("/menu/update.do")
    public String updateMenu(@ModelAttribute MenuVo menuVo, Model model) {
        int cnt = menuSvc.updateMenu( menuVo);
        return "redirect:/menu/detail.do?menuId=" + menuVo.getMenuId();
    }

    // 메뉴 삭제
    @GetMapping("/menu/delete.do")
    public String deleteMenu(@RequestParam String menuId) {
        int cnt = menuSvc.deleteMenu(menuId);

        return "redirect:/menu/list.do";
    }

}
