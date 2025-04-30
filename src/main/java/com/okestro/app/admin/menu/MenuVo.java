package com.okestro.app.admin.menu;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter @Setter
public class MenuVo {

    private String menuId;
    private String menuName;
    private int menuLevel;
    private String delYn;
    private String frstRgsrId;
    private Date frstRgsrDtlDttm;
    private String lastChngId;
    private Date lastChngDtlDttm;
}
