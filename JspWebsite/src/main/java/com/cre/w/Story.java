package com.cre.w;

import java.util.ArrayList;

import com.cre.w.dao.StoryDAO;
import com.cre.w.dto.CharacterDTO;
import com.cre.w.dto.StoryDTO;

public class Story extends StoryDAO{
	
	public ArrayList<StoryDTO> load(CharacterDTO player) {
		ArrayList<StoryDTO> dtos = select();
		ArrayList<StoryDTO> story = new ArrayList<>();
		for(StoryDTO s : dtos) {
			if(s.getStNum()<=player.getStory()) {
				story.add(s);
			}
		}
		
		return story;
	}
}
