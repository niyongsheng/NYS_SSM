package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Advertisement;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface AdvertisementService extends IService<Advertisement> {
    List<Advertisement> selectAdvertisementList(Integer fellowship, Integer type);
}
