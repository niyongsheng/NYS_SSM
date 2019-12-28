package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.MusicDao;
import com.niyongsheng.persistence.domain.Music;
import com.niyongsheng.persistence.service.MusicService;
import org.springframework.stereotype.Service;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service
public class MusicServiceImpl extends ServiceImpl<MusicDao, Music> implements MusicService {
}
