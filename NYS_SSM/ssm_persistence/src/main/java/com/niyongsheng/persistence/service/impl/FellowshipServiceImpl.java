package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.FellowshipDao;
import com.niyongsheng.persistence.domain.Fellowship;
import com.niyongsheng.persistence.service.FellowshipService;
import org.springframework.stereotype.Service;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service("fellowshipService")
public class FellowshipServiceImpl extends ServiceImpl<FellowshipDao, Fellowship> implements FellowshipService {
}
