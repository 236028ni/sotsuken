package model;

public class StudentBean extends UserBean{
	private String student_name;
	private String class_id;
	private String email;
	private String phone;
	private String photo_path;
	
	public StudentBean() {
		
	}
	public StudentBean(String user_id,String password,String role,String created_at,String updated_at,String updated_by,
			String student_name,String class_id,String email,String phone,String photo_path) {
		super( user_id, password, role, created_at, updated_at, updated_by);
		this.student_name = student_name;
		this.class_id = class_id;
		this.email = email;
		this.phone = phone;
		this.photo_path = photo_path;
	}
	public String getStudent_name() {
	    return student_name;
	}

	public String getClass_id() {
	    return class_id;
	}

	public String getEmail() {
	    return email;
	}

	public String getPhone() {
	    return phone;
	}

	public String getPhoto_path() {
	    return photo_path;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}

	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}


}
