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
package com.cmsc495phase2.models;

import static com.cmsc495phase2.models.DataAccess.selectUser;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public final class Utilities {
    /* Global variables */
    static String userCode = new String();
    
    /**
     * Method to check if the browser is on a mobile device
     * @param request the request from the client
     * @return True if a mobile device, false if not
     */  
    public static Boolean isMobile(HttpServletRequest request) {
        // Check for mobile browser
        return request.getHeader("User-Agent").toLowerCase().contains("mobi");
    }

    /**
     * Method to retrieve the appropriate regex pattern based on key selected
     * @param keypadLetterGroup the key number from the key selected
     * @return The appropriate regex as a string
     */      
    public static String getPattern(int keypadLetterGroup) {
        String pattern;
        // Select regex pattern based on key selected
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
                // Select all data
                pattern = "^[A-Za-z]";
                break;
        }
        return pattern;
    }

    /**
     * Method used to connect to the SQLite database
     * @param dbName the name of the SQLite database to open
     * @return The Connection object
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */    
    public static Connection connectToDatabase(String dbName) throws ClassNotFoundException, SQLException {
        Class.forName("org.sqlite.JDBC");
        // Look for database in the com.cmsc495ems.models package
        URL url = Utilities.class.getResource(dbName);
        Connection conn = DriverManager.getConnection("jdbc:sqlite::resource:" + url);
        return conn;
    }
    
    /**
     * Method used to log events (e.g., session started, etc.)
     * @param logEntry the text of the entry
     * @throws java.io.IOException
     */    
    public void logEvent(String logEntry) throws IOException {
        // AU-3 - CONTENT OF AUDIT RECORDS
        // Write the text using the bufferedwriter to eventLog.txt
        BufferedWriter writer = new BufferedWriter(new FileWriter("eventlog.txt", true));
        writer.append(String.format("%s: %s", ZonedDateTime.now(ZoneOffset.UTC).toString(), logEntry));
        writer.newLine();
        writer.close();
    }

    /**
     * Method used to log events (e.g., session started, etc.)
     * @return An ArrayList of events
     * @throws java.io.FileNotFoundException
     * @throws java.io.IOException
     */   
    public ArrayList readEventLog() throws FileNotFoundException, IOException {
        ArrayList events = new ArrayList();
        BufferedReader reader = new BufferedReader(new FileReader("eventlog.txt"));
        String eventEntry;
        while ((eventEntry = reader.readLine()) != null) {
            events.add(eventEntry);
        }
        reader.close();
        return events;
    }
    
    /**
     * Method used to send verification code to user for multi-factor authentication
     * @param emailAddress the address of the code recipient
     * @throws java.io.UnsupportedEncodingException
     * @throws javax.mail.internet.AddressException
     */ 
    public void sendCode(String emailAddress) throws UnsupportedEncodingException, IOException, AddressException, MessagingException {
        // IA-2(1) IDENTIFICATION AND AUTHENTICATION (ORGANIZATIONAL USERS) | NETWORK ACCESS TO PRIVILEGED ACCOUNTS
        // Setup SMTP server
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        // Open flat file in the models package with smtp creditials
        InputStream is = Utilities.class.getResourceAsStream("smtpInfo.txt");
        BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
        // Remove byte-order-mark if present
        removeBOM(br);
        final String username = br.readLine();
        final String password = br.readLine();
        Session session = Session.getInstance(props,
        new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
            }
        });
        Random r = new Random( System.currentTimeMillis() );
        userCode = Integer.toString(r.nextInt(80000) + 10000);
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("rgarcia92@student.umuc.edu"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailAddress));
        message.setSubject("CMSC 495 EMR Login Code");
        message.setText(String.format("Welcome back!\n"
                + "Your login code is: %s.\n"
                + "If you did not request a login code, please contact us at "
                + "rgarcia92@student.umuc.edu as soon as possible", userCode));
        Transport.send(message);
        // AU-8 - TIME STAMPS by logging event
        logEvent("Code sent to user");
    }

    /**
     * Method to authenticate user
     * @param username the inputted username
     * @param password the inputted password
     * @return TRUE if the user is valid, FALSE if not
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     * @throws java.io.IOException
     * @throws java.security.NoSuchAlgorithmException
     */
    public Boolean authenticate(String username, String password) throws ClassNotFoundException, SQLException, IOException, NoSuchAlgorithmException {
        Users user = selectUser(username);
        // Check id user exists
        if (user.getUserID() == 0) {
            logEvent("Attempted login by unknown user");
            return false;
        } else {
            // Check if user is using the correct password
            if (getPasswordHash(password, user.getSalt()).equals(user.getPasswordHash())) {

                logEvent(String.format("%s logged in", username));
                return true;
            } else {
                logEvent(String.format("%s login failed", username));
                return false;
            }
        }
    }

    /**
     * Method used to turn password into hash with salt
     * @param password the password
     * @param salt a 32-character alphanumeric salt
     * @return SHA256 salted hash
     * @throws java.io.IOException
     * @throws java.security.NoSuchAlgorithmException
     */
    public String getPasswordHash(String password, String salt) throws IOException, NoSuchAlgorithmException {
        // SC-13 - CRYPTOGRAPHIC PROTECTION
        // Get salt and hash
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.reset();
        // Add salt to MessageDigest
        md.update(salt.getBytes("UTF-8"));
        // Add password to MessageDigest
        byte[] bytes = md.digest(password.getBytes("UTF-8"));
        // Create hash string
        StringBuilder sb = new StringBuilder();
        for(int i=0; i< bytes.length ;i++) {
            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
        }
        // Return the hash
        return sb.toString();
    }
    
    /**
     * Method remove byte-order-mark for UTF-8, UTF-16 (LE & BE) & UTF-32(LE & BE) courtesy of Andrei Punko
     * @param br the Buffered Reader
     * @throws java.io.IOException
     */ 
    public static void removeBOM(Reader br) throws IOException {
        br.mark(1);
        char[] possibleBOM = new char[1];
        br.read(possibleBOM);

        if (possibleBOM[0] != '\ufeff')
        {
            br.reset();
        }
    }
    
    public void throwException() throws Exception {
        throw new Exception("Ahhh!");
    }
}
