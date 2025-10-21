package model;

public class TeacherBean extends UserBean{
	private String teacher_name;
	private String email;
	private String phone;
	
	public TeacherBean() {
		
	}
	public TeacherBean(String user_id,String password,String role,String created_at,String updated_at,String updated_by,
			String teacher_name,String email,String phone) {
		super( user_id, password, role, created_at, updated_at, updated_by);
		this.teacher_name = teacher_name;
		this.email = email;
		this.phone = phone;
	}
	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
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
