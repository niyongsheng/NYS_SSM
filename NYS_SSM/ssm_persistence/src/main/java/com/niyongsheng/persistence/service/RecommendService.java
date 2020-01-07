package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Recommend;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface RecommendService extends IService<Recommend> {

    List<Recommend> selectRecommendByFellowshipMultiTable(Integer fellowship, String account);
}
