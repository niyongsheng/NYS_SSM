package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Banner;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface BannerService extends IService<Banner> {
    List<Banner> selectAllMultiTable();

    List<Banner> selectByFellowshipMultiTable(Integer fellowship);
}
