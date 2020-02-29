package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.Plate;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface PlateService extends IService<Plate> {
    Plate selectOneByPlate(String plate);

    List<Plate> selectAllByFellowship(Integer fellowship);
}
