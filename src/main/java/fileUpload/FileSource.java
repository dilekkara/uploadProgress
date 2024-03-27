package fileUpload;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

/**
 * Servlet implementation class FileSource
 */
@MultipartConfig
public class FileSource extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileSource() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		
		try (PrintWriter out = response.getWriter()){
			//fetch form data
			
			Part part = request.getPart("file");
			String fileName = part.getSubmittedFileName();
			
			String path = getServletContext().getRealPath("/" + "files" + File.separator+fileName);
			
			
			InputStream is = part.getInputStream();
			
			boolean succs = upoloadFile(is, path);
			if(succs) {
				out.println("File Uploaded to this directory:" +path );
			}else {
				out.println("error");
			}
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	}	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
		
	}
	
	public boolean upoloadFile(InputStream is, String path) {
		boolean test = false;
		try {
			byte[] byt = new byte[is.available()];
			is.read();
			FileOutputStream fops = new FileOutputStream(path);
			fops.write(byt);
			fops.flush();
			fops.close();
			test = true;
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return test;
		
		
	}

}