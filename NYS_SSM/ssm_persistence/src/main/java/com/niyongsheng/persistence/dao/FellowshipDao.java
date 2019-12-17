package com.niyongsheng.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.niyongsheng.persistence.domain.Fellowship;
import org.springframework.stereotype.Repository;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Repository
public interface FellowshipDao extends BaseMapper<Fellowship> {

    Fellowship findOneById(Integer id);
}
