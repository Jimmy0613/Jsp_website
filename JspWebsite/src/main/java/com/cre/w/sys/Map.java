package com.cre.w.sys;

import com.cre.w.dao.MapDAO;
import com.cre.w.dto.CharacterDTO;
import com.cre.w.dto.MapDTO;

public class Map extends MapDAO {
	Charac ch = new Charac();
	Log log = new Log();

	public void move(MapDTO currentMap, CharacterDTO player) {
		Log.turnCount++;
		log.send("[ " + Log.turnCount + " ] " + currentMap.getName() + "(으)로 이동했습니다.", "normal");
		player.setLocation(currentMap.getMapId());
		ch.characterUpdate(player);
	}
}
