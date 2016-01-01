import java.io.*;
import java.util.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;

public class UploadServlet extends HttpServlet {

private boolean isMultipart;
private String filePath;
private int maxFileSize = 500 * 1024;
private int maxMemSize = 40 * 1024;
private File file;

public void init( ){
        // Get the file location where it would be stored.
        filePath =
                getServletContext().getInitParameter("file-upload");
}
public void doPost(HttpServletRequest request,
                   HttpServletResponse response)
throws ServletException, java.io.IOException {
        // Check that we have a file upload request
        HttpSession session = request.getSession();
        isMultipart = ServletFileUpload.isMultipartContent(request);
        java.io.PrintWriter out = response.getWriter( );
        if( !isMultipart ) {
                return;
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File(filePath));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
        upload.setSizeMax( maxFileSize );

        try{

                String newFileName="";
                String fieldvalue="";

                // Parse the request to get file items.
                List fileItems = upload.parseRequest(request);
                //List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

                // Process the uploaded file items
                Iterator i = fileItems.iterator();

                while ( i.hasNext () )
                {

                        FileItem fi = (FileItem)i.next();
                        if ( !fi.isFormField () )
                        {
                                // Get the uploaded file parameters
                                String fieldName = fi.getFieldName();
                                String fileName = newFileName;
                                String contentType = fi.getContentType();
                                boolean isInMemory = fi.isInMemory();
                                long sizeInBytes = fi.getSize();
                                // Write the file
                                if( fileName.lastIndexOf("\\") >= 0 ) {
                                        file = new File( filePath +
                                                         fileName.substring( fileName.lastIndexOf("\\")));
                                }else{
                                        file = new File( filePath +
                                                         fileName.substring(fileName.lastIndexOf("\\")+1));
                                }
                                fi.write( file );
                        } else {
                                String fieldname = fi.getFieldName();
                                fieldvalue = fi.getString();
                                newFileName = String.format("img_%s.jpg",fieldvalue);
                        }
                }

                session.setAttribute("addProductID",fieldvalue);
                session.setAttribute("uploadImageValue","true");
                response.sendRedirect("addProduct.jsp");

        }catch(Exception ex) {
                System.out.println(ex);
        }
}
public void doGet(HttpServletRequest request,
                  HttpServletResponse response)
throws ServletException, java.io.IOException {

        throw new ServletException("GET method used with " +
                                   getClass( ).getName( )+": POST method required.");
}
}
