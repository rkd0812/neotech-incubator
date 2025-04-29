package com.okestro.app.project;


import java.util.List;

public interface ProjectSvc {
    List<ProjectVo> retrieveProjcetList();

    ProjectVo retrieveProjectDetail(ProjectVo projectVo);

    int updateProjectDetail(ProjectVo projectVo);

//    int deleteProjectDetail(ProjectVo projectVo);

    int delYnConfirmProjectDetail(ProjectVo projectVo);
}
