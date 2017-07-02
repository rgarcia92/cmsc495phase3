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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public final class DataAccess {
    /**
     * Basic method to retrieve all medications in the database
     * @return An array of Medication objects
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static ArrayList<Medications> selectAllMedications() throws ClassNotFoundException, SQLException {
        ArrayList<Medications> allMedications = new ArrayList<>();
        Connection conn = Utilities.connectToDatabase("medications.db");
        // Make two calls to the database instead of multiple nested calls
        // Retrieve conditions
        PreparedStatement stmt = conn.prepareStatement("SELECT MEDCON.MEDID, CONDITIONS.CONDITION FROM MEDCON INNER JOIN CONDITIONS ON CONDITIONS.CONID = MEDCON.CONID");
        ResultSet rs = stmt.executeQuery();
        // Need to create a list of conditions since you can't reset conRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
        ArrayList<ConList> conList = new ArrayList<>();
        while (rs.next()) {
            conList.add(new ConList(rs.getInt(1), rs.getString(2)));
        }
        rs.close();
        stmt.close();
        // Retrieve medications
        stmt = conn.prepareStatement("SELECT MEDID, GNAME, BNAME, BTFLAG FROM MEDICATIONS");
        rs = stmt.executeQuery();
        Integer lastIndex = 0;
        // Need to create a list of medications since you can't reset medRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
        ArrayList<Medications> medList = new ArrayList<>();
        // Loop through the result set
        while (rs.next()) {
            String[] conTemp = new String[3]; 
            Integer conCount = 0;
            // lastIndex starts the condition loop at the last condition read to avoid going through the full arraylist
            for (Integer i = lastIndex; i < conList.size(); i++) {
                if (conList.get(i).getMedID() == rs.getInt("MEDID")) {
                    // Add condition to temorary array
                    conTemp[conCount] = conList.get(i).getCondition();
                    conCount++;
                } else if (conList.get(i).getMedID() > rs.getInt("MEDID")) {
                    lastIndex = i;
                    // Stop the iteration to make app faster
                    break;
                }
            }
            // Put it all together
            medList.add(new Medications(
                rs.getInt("MEDID"),
                rs.getString("GNAME"),
                rs.getString("BNAME"),
                conTemp[0],
                conTemp[1],
                conTemp[2],
                rs.getInt("BTFLAG")
            ));
        }
        // Loop through the result set twice based on regex
        // Add by generic name in the first loop...
        for (Medications m : medList) {
            // Add by generic name in the first loop...
            allMedications.add(new Medications(
                    m.getMedID(),
                    m.getGName() + " (G)",
                    m.getBName() + " (B)",
                    m.getCond1(),
                    m.getCond2(),
                    m.getCond3(),
                    m.getBTFlag()
            ));
            // Add by brand name in the second loop...
            allMedications.add(new Medications(
                    m.getMedID(),
                    m.getBName() + " (B)",
                    m.getGName() + " (G)",
                    m.getCond1(),
                    m.getCond2(),
                    m.getCond3(),
                    m.getBTFlag()
            ));
        }
        rs.close();
        stmt.close();
        conn.close();
        // Sorting
        allMedications.sort(Comparator.comparing(med -> med.gName));
        // Return results
        return allMedications;
    }
    
    /**
     * An overloaded method to retrieve all medications starting with the letters from the selected keypad group
     * @param keypadLetterGroup the letters associated with the key from the keypad
     * @return An array of Medication objects
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static ArrayList<Medications> selectAllMedications(int keypadLetterGroup) throws ClassNotFoundException, SQLException {
        ArrayList<Medications> allMedications = new ArrayList<>();
        Connection conn = Utilities.connectToDatabase("medications.db");
        /* Get regex pattern to select medications */
        Pattern pattern = Pattern.compile(Utilities.getPattern(keypadLetterGroup));
        // Make two calls to the database instead of multiple nested calls
        // Retrieve conditions
        PreparedStatement stmt = conn.prepareStatement("SELECT MEDCON.MEDID, CONDITIONS.CONDITION FROM MEDCON INNER JOIN CONDITIONS ON CONDITIONS.CONID = MEDCON.CONID");
        ResultSet rs = stmt.executeQuery();
        // Need to create a list of conditions since you can't reset conRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
        ArrayList<ConList> conList = new ArrayList<>();
        while (rs.next()) {
            conList.add(new ConList(rs.getInt(1), rs.getString(2)));
        }
        rs.close();
        stmt.close();
        // Retrieve medications
        stmt = conn.prepareStatement("SELECT MEDID, GNAME, BNAME, BTFLAG FROM MEDICATIONS");
        rs = stmt.executeQuery();
        Integer lastIndex = 0;
        // Need to create a list of medications since you can't reset medRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
        ArrayList<Medications> medList = new ArrayList<>();
        // Loop through the result set
        while (rs.next()) {
            String[] conTemp = new String[3]; 
            Integer conCount = 0;
            // lastIndex starts the condition loop at the last condition read to avoid going through the full arraylist
            for (Integer i = lastIndex; i < conList.size(); i++) {
                if (conList.get(i).getMedID() == rs.getInt("MEDID")) {
                    // Add condition to temorary array
                    conTemp[conCount] = conList.get(i).getCondition();
                    conCount++;
                } else if (conList.get(i).getMedID() > rs.getInt("MEDID")) {
                    lastIndex = i;
                    // Stop the iteration to make app faster
                    break;
                }
            }
            // Put it all together
            medList.add(new Medications(
                rs.getInt("MEDID"),
                rs.getString("GNAME"),
                rs.getString("BNAME"),
                conTemp[0],
                conTemp[1],
                conTemp[2],
                rs.getInt("BTFLAG")
            ));
        }
        // Loop through the result set twice based on regex
        // Add by generic name in the first loop...
        for (Medications m : medList) {
            Matcher gMatcher = pattern.matcher(m.getGName());
            Matcher bMatcher = pattern.matcher(m.getBName());
            if (gMatcher.find()) {
                allMedications.add(new Medications(
                        m.getMedID(),
                        m.getGName() + " (G)",
                        m.getBName() + " (B)",
                        m.getCond1(),
                        m.getCond2(),
                        m.getCond3(),
                        m.getBTFlag()
                ));
            }
            if (bMatcher.find()) {
                allMedications.add(new Medications(
                        m.getMedID(),
                        m.getBName() + " (B)",
                        m.getGName() + " (G)",
                        m.getCond1(),
                        m.getCond2(),
                        m.getCond3(),
                        m.getBTFlag()
                ));
            }
        }
        rs.close();
        stmt.close();
        conn.close();
        // Sorting
        allMedications.sort(Comparator.comparing(med -> med.gName));
        // Return results
        return allMedications;
    }
    
    /**
     * Method to retrieve all medications by generic name
     * @return An array of Medication objects
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static ArrayList<Medications> selectMedicationsByGenericName() throws ClassNotFoundException, SQLException {
        ArrayList<Medications> allMedications = new ArrayList<>();
        Connection conn = Utilities.connectToDatabase("medications.db");
        // Make two calls to the database instead of multiple nested calls
        // Retrieve conditions
        PreparedStatement stmt = conn.prepareStatement("SELECT MEDCON.MEDID, CONDITIONS.CONDITION FROM MEDCON INNER JOIN CONDITIONS ON CONDITIONS.CONID = MEDCON.CONID");
        ResultSet rs = stmt.executeQuery();
        // Need to create a list of conditions since you can't reset conRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
        ArrayList<ConList> conList = new ArrayList<>();
        while (rs.next()) {
            conList.add(new ConList(rs.getInt(1), rs.getString(2)));
        }
        rs.close();
        stmt.close();
        // IMPORTANT - Sort by medID or SPEED UP won't work
        conList.sort(Comparator.comparing(con -> con.medID));
        Integer lastIndex = 0;
        // Retrieve medications
        stmt = conn.prepareStatement("SELECT MEDID, GNAME, BNAME, BTFLAG FROM MEDICATIONS");
        rs = stmt.executeQuery();
        // Loop through the result set
        while (rs.next()) {
            String[] conTemp = new String[3]; 
            Integer conCount = 0;
            // SPEEDUP - lastIndex starts the condition loop at the last condition read to avoid going through the full arraylist
            for (Integer i = lastIndex; i < conList.size(); i++) {
                if (conList.get(i).getMedID() == rs.getInt("MEDID")) {
                    // Add condition to temorary array
                    conTemp[conCount] = conList.get(i).getCondition();
                    conCount++;
                } else if (conList.get(i).getMedID() > rs.getInt("MEDID")) {
                    lastIndex = i;
                    // SPEEDUP - Stop the iteration to make app faster
                    break;
                }
            }
            // Put it all together
            allMedications.add(new Medications(
                rs.getInt("MEDID"),
                rs.getString("GNAME") + " (G)",
                rs.getString("BNAME") + " (B)",
                conTemp[0],
                conTemp[1],
                conTemp[2],
                rs.getInt("BTFLAG")
            ));
        }
        rs.close();
        stmt.close();
        conn.close();
        // Sorting
        allMedications.sort(Comparator.comparing(med -> med.gName));
        // Return results
        return allMedications;
    }
    
    /**
     * Method to retrieve medication details
     * @param medID the unique ID for medication in the database
     * @return A Medications object
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static Medications selectMedicationDetails(int medID) throws ClassNotFoundException, SQLException {
        Medications medication = new Medications();
        Connection conn = Utilities.connectToDatabase("medications.db");
        // Make two calls to the database instead of multiple nested calls
        // Retrieve conditions
        PreparedStatement stmt = conn.prepareStatement("SELECT CONDITIONS.CONID, CONDITIONS.CONDITION FROM MEDCON INNER JOIN CONDITIONS ON CONDITIONS.CONID = MEDCON.CONID WHERE MEDCON.MEDID = ?");
        /* Check if conID is an integer */
        if (medID == (int)medID) {
            stmt.setString(1, String.valueOf(medID));
        } else {
            throw new IllegalArgumentException("No such medication");
        }
        ResultSet rs = stmt.executeQuery();
        // Need to create a list of conditions since you can't reset conRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
        ConList conList[] = new ConList[3];
        for (Integer i = 0; i < 3; i++) {
            conList[i] = (rs.next() ? new ConList(rs.getInt(1), rs.getString(2)) : new ConList(0, null));
        }
        rs.close();
        stmt.close();
        // Retrieve medication details
        stmt = conn.prepareStatement("SELECT * FROM MEDICATIONS WHERE MEDID = ?");
        stmt.setString(1, String.valueOf(medID));
        rs = stmt.executeQuery();
        /* Check for data */
        if (rs.isBeforeFirst()) {
            medication.setMedID(rs.getInt("MEDID"));
            medication.setGName(rs.getString("GNAME"));
            medication.setBName(rs.getString("BNAME"));
            medication.setAction(rs.getString("ACTION"));
            medication.setCond1(conList[0].getCondition());
            medication.setCond2(conList[1].getCondition());
            medication.setCond3(conList[2].getCondition());
            medication.setDEA(rs.getInt("DEA"));
            medication.setBTFlag(rs.getInt("BTFLAG"));
            medication.setSide_Effects(rs.getString("SIDE_EFFECTS"));
            medication.setInteractions(rs.getString("INTERACTIONS"));
            medication.setWarnings(rs.getString("WARNINGS"));
        } else {
            throw new IllegalArgumentException("No such medication");
        }
        rs.close();
        stmt.close();
        conn.close();
        // Return results
        return medication;        
    }

    /**
     * A method to retrieve all conditions in the database
     * @return An array of Condition objects
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static ArrayList<Conditions> selectAllConditions() throws ClassNotFoundException, SQLException {
        ArrayList<Conditions> allConditionss = new ArrayList<>();
        Connection conn = Utilities.connectToDatabase("medications.db");
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM CONDITIONS");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            allConditionss.add(new Conditions(
                    rs.getInt("conID"),
                    rs.getString("condition"),
                    rs.getString("description")
            ));
        }
        rs.close();
        stmt.close();
        conn.close();
        // Sorting
        allConditionss.sort(Comparator.comparing(con -> con.condition));
        // Return results
        return allConditionss;
    }
    
    /**
     * An overloaded method to retrieve all conditions starting with the letters from the selected keypad group
     * @param keypadLetterGroup the letters associated with the key from the keypad
     * @return An array of Condition objects
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static ArrayList<Conditions> selectAllConditions(int keypadLetterGroup) throws ClassNotFoundException, SQLException {
        ArrayList<Conditions> allConditionss = new ArrayList<>();
        Connection conn = Utilities.connectToDatabase("medications.db");
        /* Get regex pattern to select medications */
        Pattern pattern = Pattern.compile(Utilities.getPattern(keypadLetterGroup));
        // String sql = "SELECT * FROM CONDITIONS";
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM CONDITIONS");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Matcher bMatcher = pattern.matcher(rs.getString("condition"));
            if (bMatcher.find()) {
                allConditionss.add(new Conditions(
                        rs.getInt("conID"),
                        rs.getString("condition"),
                        rs.getString("description")
                ));
            }
        }
        rs.close();
        stmt.close();
        conn.close();
        // Sorting
        allConditionss.sort(Comparator.comparing(con -> con.condition));
        // Return results
        return allConditionss;
    }
    
    /**
     * Method to retrieve condition details
     * @param conID the unique ID for condition in the database
     * @return A Conditions object
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static Conditions selectConditionDetails(int conID) throws ClassNotFoundException, SQLException {
        Conditions condition = new Conditions();
        Connection conn = Utilities.connectToDatabase("medications.db");
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM CONDITIONS WHERE CONID = ?");
        /* Check if conID is present and is an integer */
        if (conID == (int)conID) {
            stmt.setString(1, String.valueOf(conID));
        } else {
            throw new IllegalArgumentException("No such condition");
        }
        ResultSet rs = stmt.executeQuery();
        /* Check for data */
        if (rs.next()) {
            condition.setConID(rs.getInt("CONID"));
            condition.setCondition(rs.getString("CONDITION"));
            condition.setDescription(rs.getString("DESCRIPTION"));
        } else {
            throw new IllegalArgumentException("No such condition");
        }
        rs.close();
        stmt.close();
        conn.close();
        // Return results
        return condition;        
    }
    
    /**
     * Method to retrieve all medications associated with a condition
     * @param conID the unique ID for condition in the database
     * @return An array of Conditions objects
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */
    public static ArrayList<Medications> selectMedicationsInCondition(int conID) throws ClassNotFoundException, SQLException {
        ArrayList<Medications> medications = new ArrayList<>();
        Connection conn = Utilities.connectToDatabase("medications.db");
        PreparedStatement stmt = conn.prepareStatement("SELECT MEDICATIONS.MEDID, MEDICATIONS.GNAME, MEDICATIONS.BNAME FROM MEDCON INNER JOIN MEDICATIONS ON MEDICATIONS.MEDID = MEDCON.MEDID WHERE MEDCON.CONID = ?");
        /* Check if conID is present and is an integer */
        if (conID == (int)conID) {
            stmt.setString(1, String.valueOf(conID));
        } else {
            throw new IllegalArgumentException("No such condition");
        }
        ResultSet rs = stmt.executeQuery();
        /* Check for data */
        while (rs.next()) {
            Medications m = new Medications();
            m.setMedID(rs.getInt("MEDID"));
            m.setGName(rs.getString("GNAME"));
            m.setBName(rs.getString("BNAME"));
            medications.add(m);
        }
        rs.close();
        stmt.close();
        conn.close();
        // Sorting
        medications.sort(Comparator.comparing(med -> med.gName));
        // Return results
        return medications;   
    }

    /**
     * Method to retrieve user information
     * @param username the unique username in the database
     * @return A User Condition object
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */    
    public static Users selectUser(String username) throws ClassNotFoundException, SQLException {
        Users user = new Users();
        Connection conn = Utilities.connectToDatabase("users.db");
        PreparedStatement stmt = conn.prepareStatement("SELECT USERS.USERID, USERS.USERNAME, ROLES.ROLE, USERS.SALT, USERS.PASSWORDHASH, USERS.LOCKEDOUT, USERS.LASTLOGIN FROM USERS LEFT JOIN ROLES ON USERS.ROLEID = ROLES.ROLEID WHERE USERNAME = ?");
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        /* Check for data */
        if (rs.next()) {
            user.setUserID(rs.getInt("USERID"));
            user.setUsername(rs.getString("USERNAME"));
            user.setRole(rs.getString("ROLE"));
            user.setSalt(rs.getString("SALT"));
            user.setPasswordHash(rs.getString("PASSWORDHASH"));
            user.setLockedOut(rs.getInt("LOCKEDOUT"));
            user.setLastLogin(rs.getString("LASTLOGIN"));
        } else {
            user.setUserID(0);
        }
        rs.close();
        stmt.close();
        conn.close();
        // Return results
        return user;
    }

    /**
     * Method to update user last login
     * @param userID the unique user ID in the database
     * @param lastLogin the date using ZonedDateTime
     * @throws java.lang.ClassNotFoundException if external class is not found
     * @throws java.sql.SQLException if unable to retrieve data from the database
     */    
    public static void updateUserLastLogin(int userID, String lastLogin) throws ClassNotFoundException, SQLException {
        Connection conn = Utilities.connectToDatabase("users.db");
        PreparedStatement stmt = conn.prepareStatement("UPDATE USERS SET LASTLOGIN = ? WHERE USERID = ?");
        stmt.setString(1, lastLogin);
        stmt.setString(2, String.valueOf(userID));
        int check = stmt.executeUpdate();
        stmt.close();
        conn.close();
    }
    
    /**
     * Conlist Utility Object for use by DataAccess methods
     */
    public final static class ConList {
        private int medID;
        private String condition;
        
        /**
         * Constructor used to create a conList object
         * @param medID     the unique medication identifier from the junction table
         * @param condition the associated condition for the medication
         */
        public ConList(int medID, String condition) {
            this.medID = medID;
            this.condition = condition;
        }
        
        /* Getter functions */
        public int getMedID() {
            return medID;
        }

        public String getCondition() {
            return condition;
        }
        
        /* Setter functions */
        public void setMedID(int medID) {
            this.medID = medID;
        }

        public void setCondition(String condition) {
            this.condition = condition;
        }
    }
}
