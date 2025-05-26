package com.okestro.app.evaProject;

import lombok.Getter;
import lombok.Setter;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Getter @Setter
public class EvaProjectVo extends PaginationInfo {

    private String projectId;
    private String projectName;
    private String evaCd;
    private String evaCdNm;
    private String scoreFin;
    private String evaStartDt;
    private String evaEndDt;
    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;
    private String userGroupId;
    private String evaGroupId;
    private String projectDetail;
    private String url;
    private String evaFormYn;
    private String startDate;
    private String endDate;
    private String groupId;
    private String groupCd;
    private String groupCdNm;
    private String rnum;
}
