package model;

import java.io.Serializable;

public class userBean implements Serializable{
	private String user_id;
	private String password;
	private String role;
	private String created_at;//作成日時
	private String updated_at;//更新日時
	private String updated_by;//更新者
	
	public userBean() {
		
	}
	public userBean(String user_id,String password,String role,
			String created_at,String updated_at,String updated_by) {
		this.user_id = user_id;
		this.password = password;
		this.role = role;
		this.created_at = created_at;
		this.updated_at = updated_at;
		this.updated_by = updated_by;
	}
	public String getId() {
		return user_id;
	}
	public String getPw() {
		return password;
	}
	public String getRole() {
		return role;
	}
	public String cr_at() {
		return created_at;
	}
	public String ud_at() {
		return updated_at;
	}
	public String ud_by() {
		return updated_by;
	}
}
