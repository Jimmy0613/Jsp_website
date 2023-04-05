package com.cre.w;

import com.cre.w.dao.UserDAO;
import com.cre.w.db.Db;
import com.cre.w.dto.UserDTO;

public class User extends UserDAO {
	public void userUpdate(UserDTO user) {
		String sql = String.format("update %s set email='%s', post_count=%d, reply_count=%d, heart_count=%d, character1='%s', character2='%s' where user_id='%s'",
				Db.TABLE_USER, user.getEmail(), user.getPCount(),
				user.getRCount(), user.getHeart(), user.getCharacter1(), user.getCharacter2(), user.getId());
		update(sql);
	}

	public void newUser(String id, String pw, String name, String email) {
		String sql = String.format("insert into %s(user_id,password,user_name,email) values('%s','%s','%s','%s');",
				Db.TABLE_USER, id, pw, name, email);
		update(sql);
	}

	public boolean isId(String id) { // id가 존재하면 true, 아니면 false를 리턴하는 함수
		return is("user_id", id);
	}

	public boolean isName(String name) { // 이름 존재하면 true, 아니면 false를 리턴하는 함수
		return is("user_name", name);
	}

	public boolean isEmail(String email) { // 이메일 존재하면 true, 아니면 false를 리턴하는 함수
		return is("email", email);
	}

	public boolean pwCheck(String id, String pw) {
		UserDTO dto = getUser(id);
		boolean correct = false;
		if (pw.equals(dto.getPw())) {
			correct = true;
		}
		return correct;
	}

	public String joinAlert(String input_id, String input_pw1, String input_pw2, String input_name,
			String input_email) {
		String alert = "";
		if (input_id.length() < 6) {
			alert = alert + "(아이디 글자 수 확인)";
		} else if (isId(input_id)) {
			alert = alert + "(중복된 아이디) ";
		}
		if (input_pw1.length() < 8) {
			alert = alert + "(비밀번호 글자 수 확인) ";
		} else if (!input_pw1.equals(input_pw2)) {
			alert = alert + "(비밀번호 일치하지 않음) ";
		}
		if (input_name.length() < 2) {
			alert = alert + "(이름 글자 수 확인) ";
		} else if (isName(input_name)) {
			alert = alert + "(중복된 이름) ";
		}
		if (!input_email.equals("")) {
			if (isEmail(input_email)) {
				alert = alert + "(이미 등록된 이메일) ";
			}
		}

		return alert;
	}

	public String loginAlert(String input_id, String input_pw) {
		String alert = "";
		if (!isId(input_id)) {
			alert = alert + "(존재하지 않는 아이디) ";
		} else if (!pwCheck(input_id, input_pw)) {
			alert = alert + "(비밀번호 불일치)";
		}
		return alert;
	}
	
}
