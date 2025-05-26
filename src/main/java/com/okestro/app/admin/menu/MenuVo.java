package com.okestro.app.admin.menu;

import lombok.Getter;
import lombok.Setter;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.util.Date;

@Getter @Setter
public class MenuVo extends PaginationInfo {

    private String menuId;
    private String menuName;
    private int menuLevel;
    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;
    private String startDate;
    private String endDate;
    private String upperMenuId;
    private String upperMenuName;
    private String rnum;
}
