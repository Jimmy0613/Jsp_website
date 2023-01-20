package com.cre.w.sys;

import com.cre.w.dao.CharacterDAO;
import com.cre.w.db.Db;
import com.cre.w.dto.CharacterDTO;
import com.cre.w.dto.MemberDTO;

public class Charac extends CharacterDAO {

	Log log = new Log();

	public boolean isName(String name) { // 이름 존재하면 true, 아니면 false를 리턴하는 함수
		return is("name", name);
	}

	public String newAlert(String input_name) {
		String alert = "";
		if (isName(input_name)) {
			alert = alert + "(이미 사용 중)";
		} else if (input_name.length() < 2 || input_name.length() > 6) {
			alert = alert + "(글자 수 확인)";
		}
		return alert;
	}

	public void newCharacter(String name, String mem_id) {
		String sql = String.format("INSERT INTO %s(NAME, MEMBER_ID) VALUES('%s','%s');", Db.TABLE_CHARACTER, name,
				mem_id);
		update(sql);
	}

	public void memberUpdate(MemberDTO member) {
		String sql = String.format(
				"update %s set password='%s', email='%s', post_count=%d, reply_count=%d, heart=%d where member_id='%s'",
				Db.TABLE_MEMBER, member.getPw(), member.getEmail(), member.getPCount(), member.getRCount(),
				member.getHeart(), member.getId());
		update(sql);
	}

	public void characterUpdate(CharacterDTO player) {
		String sql = String.format(
				"update %s set power=%d, level=%d, max_power=%d, coin=%d, exp=%d, max_exp=%d, story=%d, location='%s' where name='%s'",
				Db.TABLE_CHARACTER, player.getPower(), player.getLevel(), player.getMaxPower(), player.getCoin(),
				player.getExp(), player.getMaxExp(), player.getStory(), player.getLocation(), player.getName());
		update(sql);
	}

	public void levelCheck(CharacterDTO player) {
		if (player.getExp() >= player.getMaxExp()) {
			int exp_over = player.getExp() - player.getMaxExp();
			player.setLevel(player.getLevel() + 1);
			player.setMaxPower(player.getMaxPower() + 1);
			player.setPower(player.getMaxPower());
			player.setMaxExp(player.getMaxExp() * 13 / 10);
			player.setExp(exp_over);
			log.send("🎊 레벨이 올랐습니다. (레벨 " + player.getLevel() + ", 최대 힘 +1)", "good");
		}
	}

}
