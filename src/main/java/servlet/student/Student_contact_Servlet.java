 package servlet.student; // パッケージ宣言 (環境に合わせてください)

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.RequestDispatcher; // ★ JSP遷移のために追加
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import dao.RequestDAO;
import dao.StudentDAO;
import model.RequestBean;
import software.amazon.awssdk.core.sync.RequestBody;
// import javax.swing.plaf.synth.Region; // ← 修正済みと仮定
import software.amazon.awssdk.regions.Region; // ← 正しい Region をインポート
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;


@WebServlet("/Student_contact_Servlet")
@MultipartConfig
public class Student_contact_Servlet extends HttpServlet {
	//AWS関係の
    private static final String BUCKET_NAME = "1sotuken1";
    private static final Region S3_REGION = Region.AP_NORTHEAST_1;
    private S3Client s3Client;

    // ▼▼▼ 遷移先のJSPパスを定義 ▼▼▼
    private static final String JSP_PATH_COMPLETE = "/WEB-INF/jsp/student/Student_contact_complete.jsp";

    @Override
    public void init() throws ServletException {
        // S3クライアントを初期化
        this.s3Client = S3Client.builder()
                .region(S3_REGION)
                .build();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        // response.setContentType("text/html; charset=UTF-8"); // ← JSP側で設定するため不要
        // PrintWriter out = response.getWriter(); // ← JSPにフォワードするため不要

        String s3ImageUrl = null; 

        // ▼▼▼ JSPに渡すための変数を準備 ▼▼▼
        String request_date = "";
        String student_id = "";
        String periodStr = "";
        String error_message = null; // エラーメッセージ格納用
        
        //必要なDAOをあらかじめ宣言しておく
        RequestDAO rdao = new RequestDAO();
        StudentDAO sdao = new StudentDAO();
        
        try {
            // --- 1. JSPからテキストデータを取得 ---
        	request_date = request.getParameter("request-date");//「該当日付」
            student_id = request.getParameter("student_id");//「学籍番号」
            String[] period = request.getParameterValues("period");//「〇限目」（配列データ）
            periodStr = (period != null) ? String.join(", ", period) : "なし";
            String timing= request.getParameter("timing");//「事前・事後」区分
            String status = request.getParameter("status");//「遅刻・欠課・欠席・早退」
            String reason = request.getParameter("reason-description");//「理由記述」

            // --- 2. JSPからファイルデータを取得 ---
            Part filePart = request.getPart("evidence-image");
            
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
            	// --- (A) 拡張子の取得 ---
                String originalFileName = filePart.getSubmittedFileName();
                String extension = getFileExtension(originalFileName); // .jpg など

                // --- (B) 新しいファイル名の生成 (YYYYMMDD-HHmmss) ---
                LocalDateTime now = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss");
                String timestamp = now.format(formatter);
                
                // 結合してファイル名を生成
                String newFileName = String.format("%s-%s%s", 
                                        timestamp,   // YYYYMMDD-HHmmss
                                        student_id,   // 学籍番号
                                        extension);  // .jpg
                // -> 例: "20251114-123000-123456.jpg"


                // --- (D) S3のキー（フォルダパス + ファイル名）を生成 ---
                // "Request/" プレフィックスを付ける
                String s3Key = "Request/" + newFileName;

                // 2-4. S3にアップロード
                try (InputStream fileInputStream = filePart.getInputStream()) {
                    PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                            .bucket(BUCKET_NAME)
                            .key(s3Key)
                            .contentType(filePart.getContentType())
                            .build();

                    s3Client.putObject(putObjectRequest, 
                            RequestBody.fromInputStream(fileInputStream, filePart.getSize()));
                }

                // 2-5. DBに保存するためのURLを構築
                s3ImageUrl = String.format("https://%s.s3.%s.amazonaws.com/%s",
                        BUCKET_NAME, S3_REGION.id(), s3Key);
            } else {
                s3ImageUrl = "（画像なし）"; 
            }

            // --- 3. データベースへの保存処理 ---
            // ここにDB保存ロジックを実装
            if(status.equals("full-absence")) {
            	//欠席の時は時限が送信されないのでfor文は使わない
            	//（１）Beanに登録
                RequestBean req = new RequestBean();
                req.setStudent_id(student_id);//学籍番号
                req.setTiming(timing);//事前事後区分
                req.setRequest_date(request_date);//対象日付
                req.setStatus(status);//申請区分
                req.setReason(reason);//理由
                req.setAttachment_path(s3ImageUrl);//画像パス
                req.setUpdated_by(sdao.search_name_by_id(student_id));//最終更新者
                
                //（２）DAO経由でDBに登録する
                
                rdao.add_request(req);
            }else {
            	//その他は時限が複数選択されている場合に備えてfor文で実行する
            	for(String p : period) {
            		//（１）Beanに登録
                    RequestBean req = new RequestBean();
                    req.setStudent_id(student_id);//学籍番号
                    req.setTiming(timing);//事前事後区分
                    req.setRequest_date(request_date);//対象日付
                    req.setPeriod(Integer.parseInt(p));//時限
                    req.setStatus(status);//申請区分
                    req.setReason(reason);//理由
                    req.setAttachment_path(s3ImageUrl);//画像パス
                    req.setUpdated_by(sdao.search_name_by_id(student_id));//最終更新者
                    
                    //（２）DAO経由でDBに登録する
                    rdao.add_request(req);
            	}
            }
            
            
            // --- 4. ユーザーへの完了通知 (HTML出力をすべて削除) ---
            // out.println(...) 関連はすべて不要

        } catch (S3Exception e) {
            // ▼▼▼ S3エラーをJSPに渡すため、変数に格納 ▼▼▼
            error_message = "S3へのアップロードに失敗しました: " + e.awsErrorDetails().errorMessage();
            e.printStackTrace(); // サーバーログにはスタックトレースを残す
        
        } catch (Exception e) {
            // ▼▼▼ 一般エラーをJSPに渡すため、変数に格納 ▼▼▼
            error_message = "処理中にエラーが発生しました: " + e.getMessage();
            e.printStackTrace(); // サーバーログにはスタックトレースを残す
        }

        // --- 5. 処理結果をJSPに渡すために requestスコープ に属性を設定 ---
        request.setAttribute("request_date", request_date);
        request.setAttribute("periodStr", periodStr);
        request.setAttribute("s3ImageUrl", s3ImageUrl);
        request.setAttribute("error_message", error_message); // 成功時は null, エラー時はメッセージが入る

        // --- 6. JSPにフォワード(遷移) ---
        RequestDispatcher dispatcher = request.getRequestDispatcher(JSP_PATH_COMPLETE);
        dispatcher.forward(request, response);
    }

    @Override
    public void destroy() {
        if (this.s3Client != null) {
            this.s3Client.close();
        }
    }

    // ファイル名から拡張子を取得 (変更なし)
    private String getFileExtension(String fileName) {
        if (fileName != null && fileName.lastIndexOf(".") != -1) {
            return fileName.substring(fileName.lastIndexOf("."));
        }
        return "";
    }

    // HTMLエスケープ (JSP側でJSTL <c:out> を使うことを前提とし、サーブレットからは削除)
    /*
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
    */
}