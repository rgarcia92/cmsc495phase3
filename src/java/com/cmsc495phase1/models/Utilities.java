/*
 * Copyright (C) 2017 Rob Garcia at rgarcia92.student.umuc.edu
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.cmsc495phase1.models;

import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public class Utilities {
    /**
     * Check if the browser is on a mobile device
     * @param request the request from the client
     * @return if true or false
     */  
    public static Boolean isMobile(HttpServletRequest request) {
        /* Check for mobile browser */
        return !request.getHeader("User-Agent").toLowerCase().contains("mobi");
    }

    /**
     * Retrieve the appropriate regex pattern based on key selected
     * @param keypadLetterGroup the key number from the key selected
     * @return regex string
     */      
    public static String getPattern(int keypadLetterGroup) {
        String pattern;
        /* Select regex pattern based on key selected */
        switch (keypadLetterGroup) {
            case 1:
                pattern = "^[A-Ca-c]";
                break;
            case 2:
                pattern = "^[D-Fd-f]";
                break;
            case 3:
                pattern = "^[G-Ig-i]";
                break;
            case 4:
                pattern = "^[J-Lj-l]";
                break;
            case 5:
                pattern = "^[M-Om-o]";
                break;
            case 6:
                pattern = "^[P-Rp-r]";
                break;
            case 7:
                pattern = "^[S-Us-u]";
                break;
            case 8:
                pattern = "^[V-Xv-x]";
                break;
            case 9:
                pattern = "^[Y-Zy-z]";
                break;
            case 0:
            default:
                /* Select all data */
                pattern = "^[A-Za-z]";
                break;
        }
        return pattern;
    }

    /**
     * Connect to the SQLite database
     * @param dbName the name of the SQLite database to open
     * @return the Connection object
     */    
    public static Connection connectToDatabase(String dbName) {
        Connection conn = null;
        try {
            Class.forName("org.sqlite.JDBC");
            /* Look for database in the com.cmsc495ems.models package */
            URL url = Utilities.class.getResource(dbName);
            conn = DriverManager.getConnection("jdbc:sqlite::resource:" + url);
        } catch ( ClassNotFoundException | SQLException ex ) {
            Logger.getLogger(Utilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;        
    }
}
