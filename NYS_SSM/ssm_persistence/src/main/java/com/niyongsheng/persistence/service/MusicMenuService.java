package com.niyongsheng.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.niyongsheng.persistence.domain.MusicMenu;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public interface MusicMenuService extends IService<MusicMenu> {

    List<MusicMenu> selectAllByFellowship(Integer fellowship);

    MusicMenu selectMusicListById(Integer id, String account);
}
