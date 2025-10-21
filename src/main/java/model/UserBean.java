package model;

public class UserBean {
	private String user_id;//学生は学籍番号、講師は「g+（苗字）」
	private String password;
	private String role;//"student","teacher","admin"
	private String created_at;//作成日時
	private String updated_at;//更新日時
	private String updated_by;//更新者
	
	public UserBean() {
		
	}
	public UserBean(String user_id,String password,String role,
			String created_at,String updated_at,String updated_by) {
		this.user_id = user_id;
		this.password = password;
		this.role = role;
		this.created_at = created_at;
		this.updated_at = updated_at;
		this.updated_by = updated_by;
	}
	public String getUser_id() {
		return user_id;
	}
	public String getPassword() {
		return password;
	}
	public String getRole() {
		return role;
	}
	public String getCreated_at() {
		return created_at;
	}
	public String getUpdated_at() {
		return updated_at;
	}
	public String getUpdated_by() {
		return updated_by;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}

	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}

}
