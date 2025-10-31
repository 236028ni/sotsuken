package servlet.student;

import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
/**
 * Servlet implementation class Qr_code_Servlet
 */
@WebServlet("/Qr_code_Servlet")
public class Qr_code_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Qr_code_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. QRコードにしたい文字列をリクエストから取得
        // (例: index.jspから ?text=S12345 のように渡される)
        request.setCharacterEncoding("UTF-8");
        String text = request.getParameter("text");
        
        /*
        if (text == null || text.isEmpty()) {
            text = "Hello QR"; // デフォルトの文字列
        }
        */

        // 2. Zxingライブラリを使ってQRコードを生成
        QRCodeWriter qrWriter = new QRCodeWriter();
        BitMatrix bitMatrix = null;
        try {
            // QRコードのサイズ（幅・高さ）
            int width = 200;
            int height = 200;
            
            bitMatrix = qrWriter.encode(text, BarcodeFormat.QR_CODE, width, height);
            
        } catch (WriterException e) {
            e.printStackTrace();
            // エラー処理 (例: エラー画像を返すか、テキストでエラーを返す)
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "QR code generation failed.");
            return;
        }

        // 3. 生成したQRコード画像(BitMatrix)をPNG形式でレスポンスに書き出す
        
        // (1) レスポンスのタイプを「PNG画像」に設定
        response.setContentType("image/png");
        
        // (2) レスポンスの出力ストリームを取得
        OutputStream out = response.getOutputStream();
        
        // (3) MatrixToImageWriterを使って、ストリームにPNG画像を書き込む
        try {
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", out);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                out.close(); // ストリームを閉じる
            }
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
