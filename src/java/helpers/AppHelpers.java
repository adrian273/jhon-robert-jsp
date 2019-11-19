/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * @author: Adrian
 */
package helpers;

import java.text.DecimalFormat;
import javax.servlet.http.Part;

/**
 *
 * @author adrian
 */
public class AppHelpers {
    
    public AppHelpers() {
        
    }
    
    /**
     * format : $0.000
     * @param price
     * @return 
     */
    public String priceFormat(String price) {
        DecimalFormat df = new DecimalFormat("#,###");
        return "$" + df.format(Double.parseDouble(price));
    }
    
    public String getFilename(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }
    
}
