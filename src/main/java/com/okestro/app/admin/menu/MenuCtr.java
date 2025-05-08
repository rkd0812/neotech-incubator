package com.okestro.app.admin.menu;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;

@Controller
public class MenuCtr {

    @Resource(name="menuSvc")
    MenuSvc menuSvc;

    // 메뉴 등록화면 이동
    @GetMapping("/admin/menu/openRegist.do")
    public String openRegistMenu() {

        return "/admin/menu/menuRegist";
    }

    // 메뉴 등록
    @PostMapping("/admin/menu/regist.do")
    public String registMenu(@ModelAttribute MenuVo menuVo, Model model, RedirectAttributes redirectAttributes) {
        String menuId = "MENU" + menuSvc.getmenuIndex();
        menuVo.setMenuId(menuId);

        int cnt = menuSvc.registMenu(menuVo);

        if (cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "등록 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "등록 실패");
        }

        return "redirect:/admin/menu/list.do";
    }

    // 메뉴 목록조회
    @GetMapping("/admin/menu/list.do")
    public String retrieveMenuList(@ModelAttribute MenuVo menuVo, Model model) {

        if(menuVo.getStartDate() == null && menuVo.getEndDate() == null) {
            LocalDate nowDate = LocalDate.now();
            menuVo.setStartDate(LocalDate.now().minusMonths(1).toString());
            menuVo.setEndDate(nowDate.toString());
        }

        model.addAttribute("menuVo", menuVo);

        List<MenuVo> menuList = menuSvc.retrieveMenuList(menuVo);
        model.addAttribute("menuList", menuList);
        
        return "/admin/menu/menuList";
    }

    // 메뉴 상세조회
    @GetMapping("/admin/menu/detail.do")
    public String retrieveMenuDetail(@ModelAttribute MenuVo menuVo, Model model) {

        MenuVo menuDetail = menuSvc.retrieveMenuDetail(menuVo);
        model.addAttribute("menuDetail", menuDetail);

        return "/admin/menu/menuDetail";
    }

    // 메뉴 수정
    @PostMapping("/admin/menu/update.do")
    public String updateMenu(@ModelAttribute MenuVo menuVo, Model model, RedirectAttributes redirectAttributes) {
        int cnt = menuSvc.updateMenu( menuVo);

        if (cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "수정 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "수정 실패");
        }

        return "redirect:/admin/menu/detail.do?menuId=" + menuVo.getMenuId();
    }

    // 메뉴 삭제
    @GetMapping("/admin/menu/delete.do")
    public String deleteMenu(@RequestParam String menuId, RedirectAttributes redirectAttributes) {
        int cnt = menuSvc.deleteMenu(menuId);

        if (cnt > 0) {
            redirectAttributes.addFlashAttribute("msg", "삭제 완료");
        } else {
            redirectAttributes.addFlashAttribute("msg", "삭제 실패");
        }

        return "redirect:/admin/menu/list.do";
    }

}
