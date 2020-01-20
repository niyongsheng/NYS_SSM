package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Pray;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface PrayService extends IService<Pray> {
    List<Pray> selectAllMultiTable();

    List<Pray> selectAllByFellowshipMultiTable(Integer fellowship, String account);

    List<Pray> selectMyPrayList(Integer fellowship, String account);
}
