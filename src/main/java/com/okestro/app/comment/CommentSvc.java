package com.okestro.app.comment;

import java.util.List;

public interface CommentSvc {
    // 댓글 목록조회
    List<CommentVo> retrieveCommentList(String projectId);
}
