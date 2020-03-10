package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.PlateMissionDao;
import com.niyongsheng.persistence.domain.PlateMission;
import com.niyongsheng.persistence.service.PlateMissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service
public class PlateMissionServiceImpl extends ServiceImpl<PlateMissionDao, PlateMission> implements PlateMissionService {

    @Autowired
    private PlateMissionDao plateMissionDao;

    @Override
    public List<PlateMission> selectUnfinishedMissionList(String serialno) {
        return plateMissionDao.selectUnfinishedMissionList(serialno);
    }
}
