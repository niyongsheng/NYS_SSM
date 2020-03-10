package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.PlateMission;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface PlateMissionService extends IService<PlateMission> {

    List<PlateMission> selectUnfinishedMissionList(String serialno);
}
