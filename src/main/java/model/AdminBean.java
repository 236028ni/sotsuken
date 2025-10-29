package model;

public class AdminBean extends UserBean {
	private String admin_name;
	private String email;
	private String phone;

	public AdminBean() {
	}

	public AdminBean(String user_id, String password, String role, String created_at, String updated_at, String updated_by,
			String admin_name, String email, String phone) {
		super(user_id, password, role, created_at, updated_at, updated_by);
		this.admin_name = admin_name;
		this.email = email;
		this.phone = phone;
	}

	public String getAdmin_name() {
		return admin_name;
	}

	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
}

