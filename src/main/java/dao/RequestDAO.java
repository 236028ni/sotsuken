package dao;

public class RequestDAO extends DAOparam{
	static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	public boolean add_request()
}
