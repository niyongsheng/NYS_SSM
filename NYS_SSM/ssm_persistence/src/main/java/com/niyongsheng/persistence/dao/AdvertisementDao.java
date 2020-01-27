package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Advertisement;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository
public interface AdvertisementDao extends BaseMapper<Advertisement> {
    List<Advertisement> selectAdvertisementList(@Param("fellowship") Integer fellowship, @Param("type") Integer type);
}
