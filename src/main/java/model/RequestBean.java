package model;

public class RequestBean {
    private int request_id;
    private String student_id;
    private String timing;
    private String request_date;
    private int period;
    private String status;
    private String reason;
    private String attachment_path;
    private String approval_status;
    private String created_at;
    private String updated_at;
    private String updated_by;

    // --- デフォルトコンストラクタ ---
    public RequestBean() {
    }

    // --- 全フィールドを受け取るコンストラクタ ---
    public RequestBean(int request_id, String student_id, String timing, String request_date, int period,
                       String status, String reason, String attachment_path, String approval_status,
                       String created_at, String updated_at, String updated_by) {
        this.request_id = request_id;
        this.student_id = student_id;
        this.timing = timing;
        this.request_date = request_date;
        this.period = period;
        this.status = status;
        this.reason = reason;
        this.attachment_path = attachment_path;
        this.approval_status = approval_status;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.updated_by = updated_by;
    }

    // --- ゲッター・セッター ---
    public int getRequest_id() {
        return request_id;
    }

    public void setRequest_id(int request_id) {
        this.request_id = request_id;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getTiming() {
        return timing;
    }

    public void setTiming(String timing) {
        this.timing = timing;
    }

    public String getRequest_date() {
        return request_date;
    }

    public void setRequest_date(String request_date) {
        this.request_date = request_date;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getAttachment_path() {
        return attachment_path;
    }

    public void setAttachment_path(String attachment_path) {
        this.attachment_path = attachment_path;
    }

    public String getApproval_status() {
        return approval_status;
    }

    public void setApproval_status(String approval_status) {
        this.approval_status = approval_status;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }

    public String getUpdated_by() {
        return updated_by;
    }

    public void setUpdated_by(String updated_by) {
        this.updated_by = updated_by;
    }
}
