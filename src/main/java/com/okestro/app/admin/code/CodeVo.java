package com.okestro.app.admin.code;

import lombok.Getter;
import lombok.Setter;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Getter @Setter
public class CodeVo extends PaginationInfo {

    private String upperCodeName;
    private String codeName;
    private String codeVal;
    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;
    private String startDate;
    private String endDate;
    private String preCodeVal;
    private String preCodeName;
    private String rnum;
}

