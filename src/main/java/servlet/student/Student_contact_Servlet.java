package servlet.student;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

// --- ↓↓↓↓ エラーが出ているのは、これらのライブラリが見つからないためです ↓↓↓↓ ---
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client; // S3Client の定義元
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;
// --- ↑↑↑↑ Mavenプロジェクトの更新で解決するはずです ↑↑↑↑ ---

// 1. JSPの <form action="Student_contact_Servlet"> に合わせる
@WebServlet("/Student_contact_Servlet")
// ファイルアップロードを受け付けるために必須
@MultipartConfig
public class Student_contact_Servlet extends HttpServlet {

    // S3バケットの情報
    private static final String BUCKET_NAME = "1sotuken1";
    // Region.AP_NORTHEAST_1 は、 'import software.amazon.awssdk.regions.Region;' によって解決されます
    private static final Region S3_REGION = Region.AP_NORTHEAST_1;

    // S3Client は、 'import software.amazon.awssdk.services.s3.S3Client;' によって解決されます
    private S3Client s3Client;

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
        response.setContentType("text/html; charset=UTF-8"); 

        PrintWriter out = response.getWriter();
        
        String s3ImageUrl = null; 
        String uniqueFileName = null; 

        try {
            // --- 1. JSPからテキストデータを取得 ---
            String contactDate = request.getParameter("contact-date");
            String[] periods = request.getParameterValues("periods");
            String periodsStr = (periods != null) ? String.join(", ", periods) : "なし";
            String timeType = request.getParameter("time-type");
            String reasonType = request.getParameter("reason-type");
            String reasonDescription = request.getParameter("reason-description");

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
            
            // --- 4. ユーザーへの完了通知 (例) ---
            out.println("<html><head><title>送信完了</title></head><body>");
            out.println("<h1>連絡が送信されました</h1>");
            out.println("<p>日付: " + escapeHtml(contactDate) + "</p>");
            out.println("<p>時限: " + escapeHtml(periodsStr) + "</p>");
            out.println("<p>画像URL: " + (s3ImageUrl.startsWith("http") ? 
                "<a href='" + escapeHtml(s3ImageUrl) + "' target='_blank'>画像を表示</a>" : escapeHtml(s3ImageUrl)) + "</p>");
            out.println("<br><p><a href='" + request.getContextPath() + "/Redirect_Student_menu_Servlet'>メニューに戻る</a></p>");
            out.println("</body></html>");

        } catch (S3Exception e) {
            out.println("<html><body><h2>S3へのアップロードに失敗しました</h2>");
            out.println("<p>エラー: " + e.awsErrorDetails().errorMessage() + "</p></body></html>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<html><body><h2>処理中にエラーが発生しました</h2>");
            out.println("<p>エラー: " + e.getMessage() + "</p></body></html>");
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        if (this.s3Client != null) {
            this.s3Client.close();
        }
    }

    // ファイル名から拡張子を取得
    private String getFileExtension(String fileName) {
        if (fileName != null && fileName.lastIndexOf(".") != -1) {
            return fileName.substring(fileName.lastIndexOf("."));
        }
        return "";
    }

    // HTMLエスケープ（簡易版）
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
}