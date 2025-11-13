 package servlet.student; // パッケージ宣言 (環境に合わせてください)

import java.io.IOException;
import java.io.InputStream;
// import java.io.PrintWriter; // ← 不要になります
import java.util.UUID;

import jakarta.servlet.RequestDispatcher; // ★ JSP遷移のために追加
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

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

    private static final String BUCKET_NAME = "1sotuken1";
    private static final Region S3_REGION = Region.AP_NORTHEAST_1;
    private S3Client s3Client;

    // ▼▼▼ 遷移先のJSPパスを定義 ▼▼▼
    private static final String JSP_PATH_COMPLETE = "/WEB-INF/jsp/studentStudent_contact_complete.jsp";

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
        String uniqueFileName = null; 

        // ▼▼▼ JSPに渡すための変数を準備 ▼▼▼
        String contactDate = "";
        String student_id = "";
        String periodsStr = "";
        String errorMessage = null; // エラーメッセージ格納用

        try {
            // --- 1. JSPからテキストデータを取得 ---
            contactDate = request.getParameter("contact-date");//「該当日付」
            student_id = request.getParameter("student_id");//「学籍番号」
            String[] periods = request.getParameterValues("periods");//「〇限目」（配列データ）
            periodsStr = (periods != null) ? String.join(", ", periods) : "なし";
            String timeType = request.getParameter("time-type");//「事前・事後」区分
            String reasonType = request.getParameter("reason-type");//「結果・欠席・早退」
            String reasonDescription = request.getParameter("reason-description");//「理由記述」

            // --- 2. JSPからファイルデータを取得 ---
            Part filePart = request.getPart("evidence-image");
            
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String originalFileName = filePart.getSubmittedFileName();
                String extension = getFileExtension(originalFileName);
                uniqueFileName = "std123_" + UUID.randomUUID().toString() + extension;

                // 2-4. S3にアップロード
                try (InputStream fileInputStream = filePart.getInputStream()) {
                    PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                            .bucket(BUCKET_NAME)
                            .key(uniqueFileName)
                            .contentType(filePart.getContentType())
                            .build();

                    s3Client.putObject(putObjectRequest, 
                            RequestBody.fromInputStream(fileInputStream, filePart.getSize()));
                }

                // 2-5. DBに保存するためのURLを構築
                s3ImageUrl = String.format("https://%s.s3.%s.amazonaws.com/%s",
                        BUCKET_NAME, S3_REGION.id(), uniqueFileName);
            } else {
                s3ImageUrl = "（画像なし）"; 
            }

            // --- 3. データベースへの保存処理 ---
            // ここにDB保存ロジックを実装
            //（１）Beanに登録
            RequestBean req = new RequestBean();
            req.setStudent_id(student_id);
            req.setRequest_date(contactDate);
            
            // --- 4. ユーザーへの完了通知 (HTML出力をすべて削除) ---
            // out.println(...) 関連はすべて不要

        } catch (S3Exception e) {
            // ▼▼▼ S3エラーをJSPに渡すため、変数に格納 ▼▼▼
            errorMessage = "S3へのアップロードに失敗しました: " + e.awsErrorDetails().errorMessage();
            e.printStackTrace(); // サーバーログにはスタックトレースを残す
        
        } catch (Exception e) {
            // ▼▼▼ 一般エラーをJSPに渡すため、変数に格納 ▼▼▼
            errorMessage = "処理中にエラーが発生しました: " + e.getMessage();
            e.printStackTrace(); // サーバーログにはスタックトレースを残す
        }

        // --- 5. 処理結果をJSPに渡すために requestスコープ に属性を設定 ---
        request.setAttribute("contactDate", contactDate);
        request.setAttribute("periodsStr", periodsStr);
        request.setAttribute("s3ImageUrl", s3ImageUrl);
        request.setAttribute("errorMessage", errorMessage); // 成功時は null, エラー時はメッセージが入る

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