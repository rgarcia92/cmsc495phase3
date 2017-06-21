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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public class DataAccess {
    /**
     * (Overloaded)
     * Retrieve all medications starting with the letters from the selected keypad group
     * @return An array of Medication objects
     */
    public static ArrayList<Medications> selectAllMedications() {
        ArrayList<Medications> allMedications = new ArrayList<>();
        try {
            Connection conn = Utilities.connectToDatabase("medications.db");
            // Make two calls to the database instead of multiple nested calls
            // Retrieve conditions
            String conSQL = "SELECT MEDCON.MEDID, CONDITIONS.CONDITION FROM MEDCON INNER JOIN CONDITIONS ON CONDITIONS.CONID = MEDCON.CONID";
            PreparedStatement stmt = conn.prepareStatement(conSQL);
            ResultSet conRS = stmt.executeQuery();
            // Need to create a list of conditions since you can't reset conRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
            ArrayList<ConList> conList = new ArrayList<>();
            while (conRS.next()) {
                conList.add(new ConList(conRS.getInt(1), conRS.getString(2)));
            }
            // Retrieve medications
            String medSQL = "SELECT MEDID, GNAME, BNAME, BTFLAG FROM MEDICATIONS";
            stmt = conn.prepareStatement(medSQL);
            ResultSet medRS = stmt.executeQuery();
            int lastIndex = 0;
            // Need to create a list of medications since you can't reset medRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
            ArrayList<Medications> medList = new ArrayList<>();
            // Loop through the result set
            while (medRS.next()) {
                String[] conTemp = new String[3]; 
                int conCount = 0;
                // lastIndex starts the condition loop at the last condition read to avoid going through the full arraylist
                for (int i = lastIndex; i < conList.size(); i++) {
                    if (conList.get(i).getMedID() == medRS.getInt("MEDID")) {
                        // Add condition to temorary array
                        conTemp[conCount] = conList.get(i).getCondition();
                        conCount++;
                    } else if (conList.get(i).getMedID() > medRS.getInt("MEDID")) {
                        lastIndex = i;
                        // Stop the iteration to make app faster
                        break;
                    }
                }
                // Put it all together
                medList.add(new Medications(
                    medRS.getInt("MEDID"),
                    medRS.getString("GNAME"),
                    medRS.getString("BNAME"),
                    conTemp[0],
                    conTemp[1],
                    conTemp[2],
                    medRS.getInt("BTFLAG")
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
            // Sorting
            allMedications.sort(Comparator.comparing(med -> med.gName));
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        /* Return results */
        return allMedications;
    }
    
    /**
     * (Overloaded)
     * Retrieve all medications starting with the letters from the selected keypad group
     * @param keypadLetterGroup the letters associated with the key from the keypad
     * @return An array of Medication objects
     */
    public static ArrayList<Medications> selectAllMedications(int keypadLetterGroup) {
        ArrayList<Medications> allMedications = new ArrayList<>();
        try {
            /* Get regex pattern to select medications */
            Pattern pattern = Pattern.compile(Utilities.getPattern(keypadLetterGroup));
            Connection conn = Utilities.connectToDatabase("medications.db");
            // Make two calls to the database instead of multiple nested calls
            // Retrieve conditions
            String conSQL = "SELECT MEDCON.MEDID, CONDITIONS.CONDITION FROM MEDCON INNER JOIN CONDITIONS ON CONDITIONS.CONID = MEDCON.CONID";
            PreparedStatement stmt = conn.prepareStatement(conSQL);
            ResultSet conRS = stmt.executeQuery();
            // Need to create a list of conditions since you can't reset conRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
            ArrayList<ConList> conList = new ArrayList<>();
            while (conRS.next()) {
                conList.add(new ConList(conRS.getInt(1), conRS.getString(2)));
            }
            // Retrieve medications
            String medSQL = "SELECT MEDID, GNAME, BNAME, BTFLAG FROM MEDICATIONS";
            stmt = conn.prepareStatement(medSQL);
            ResultSet medRS = stmt.executeQuery();
            int lastIndex = 0;
            // Need to create a list of medications since you can't reset medRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
            ArrayList<Medications> medList = new ArrayList<>();
            // Loop through the result set
            while (medRS.next()) {
                String[] conTemp = new String[3]; 
                int conCount = 0;
                // lastIndex starts the condition loop at the last condition read to avoid going through the full arraylist
                for (int i = lastIndex; i < conList.size(); i++) {
                    if (conList.get(i).getMedID() == medRS.getInt("MEDID")) {
                        // Add condition to temorary array
                        conTemp[conCount] = conList.get(i).getCondition();
                        conCount++;
                    } else if (conList.get(i).getMedID() > medRS.getInt("MEDID")) {
                        lastIndex = i;
                        // Stop the iteration to make app faster
                        break;
                    }
                }
                // Put it all together
                medList.add(new Medications(
                    medRS.getInt("MEDID"),
                    medRS.getString("GNAME"),
                    medRS.getString("BNAME"),
                    conTemp[0],
                    conTemp[1],
                    conTemp[2],
                    medRS.getInt("BTFLAG")
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
            // Sorting
            allMedications.sort(Comparator.comparing(med -> med.gName));
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        /* Return results */
        return allMedications;
    }
    
    /**
     * Retrieve all medications by generic name
     * @return An array of Medication objects
     */
    public static ArrayList<Medications> selectMedicationsByGenericName() {
        ArrayList<Medications> allMedications = new ArrayList<>();
        try {
            Connection conn = Utilities.connectToDatabase("medications.db");
            // Make two calls to the database instead of multiple nested calls
            // Retrieve conditions
            String conSQL = "SELECT MEDCON.MEDID, CONDITIONS.CONDITION FROM MEDCON INNER JOIN CONDITIONS ON CONDITIONS.CONID = MEDCON.CONID";
            PreparedStatement stmt = conn.prepareStatement(conSQL);
            ResultSet conRS = stmt.executeQuery();
            // Need to create a list of conditions since you can't reset conRS; SQLite is ResultSet.TYPE_FORWARD_ONLY
            ArrayList<ConList> conList = new ArrayList<>();
            while (conRS.next()) {
                conList.add(new ConList(conRS.getInt(1), conRS.getString(2)));
            }
            // IMPORTANT - Sort by medID or SPEED UP won't work
            conList.sort(Comparator.comparing(con -> con.medID));
            int lastIndex = 0;
            // Retrieve medications
            String medSQL = "SELECT MEDID, GNAME, BNAME, BTFLAG FROM MEDICATIONS";
            stmt = conn.prepareStatement(medSQL);
            ResultSet medRS = stmt.executeQuery();
            // Loop through the result set
            while (medRS.next()) {
                String[] conTemp = new String[3]; 
                int conCount = 0;
                // SPEEDUP - lastIndex starts the condition loop at the last condition read to avoid going through the full arraylist
                for (int i = lastIndex; i < conList.size(); i++) {
                    if (conList.get(i).getMedID() == medRS.getInt("MEDID")) {
                        // Add condition to temorary array
                        conTemp[conCount] = conList.get(i).getCondition();
                        conCount++;
                    } else if (conList.get(i).getMedID() > medRS.getInt("MEDID")) {
                        lastIndex = i;
                        // SPEEDUP - Stop the iteration to make app faster
                        break;
                    }
                }
                // Put it all together
                allMedications.add(new Medications(
                    medRS.getInt("MEDID"),
                    medRS.getString("GNAME") + " (G)",
                    medRS.getString("BNAME") + " (B)",
                    conTemp[0],
                    conTemp[1],
                    conTemp[2],
                    medRS.getInt("BTFLAG")
                ));
            }
            // Sorting
            allMedications.sort(Comparator.comparing(med -> med.gName));
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        /* Return results */
        return allMedications;
    }
    
    /*
    * Conlist Object
    */
    public static class ConList {
        private int medID;
        private String condition;
        
        /**
         * Constructor
         * Used to create a conList object
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
    
    public static Medications selectMedicationDetails(int medID) {
        Medications medication = new Medications();
        String sql = "SELECT * FROM MEDCOMP WHERE MEDID = " + medID;
        try {
            Connection conn = Utilities.connectToDatabase("medications.db");
            PreparedStatement stmt = conn.prepareStatement(sql);
            /* Set values here */
            ResultSet rs = stmt.executeQuery();
                medication.setMedID(rs.getInt("MEDID"));
                medication.setGName(rs.getString("GNAME"));
                medication.setBName(rs.getString("BNAME"));
                medication.setAction(rs.getString("ACTION"));
                medication.setCond1(rs.getString("COND1"));
                medication.setCond2(rs.getString("COND2"));
                medication.setCond3(rs.getString("COND3"));
                medication.setDEA(rs.getInt("DEA"));
                medication.setBTFlag(rs.getInt("BTFLAG"));
                medication.setSide_Effects(rs.getString("SIDE_EFFECTS"));
                medication.setInteractions(rs.getString("INTERACTIONS"));
                medication.setWarnings(rs.getString("WARNINGS"));
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        /* Return results */
        return medication;        
    }
    
    /**
     * (Overloaded)
     * Retrieve all conditions starting with the letters from the selected keypad group
     * @param keypadLetterGroup the letters associated with the key from the keypad
     * @return An array of Condition objects
     */
    public static ArrayList<Conditions> selectAllConditions(int keypadLetterGroup) {
        ArrayList<Conditions> allConditionss = new ArrayList<>();
        try {
            /* Get regex pattern to select medications */
            Pattern pattern = Pattern.compile(Utilities.getPattern(keypadLetterGroup));
            Connection conn = Utilities.connectToDatabase("medications.db");
            String sql = "SELECT * FROM CONDITIONS";
            PreparedStatement stmt = conn.prepareStatement(sql);
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
            // Sorting
            allConditionss.sort(Comparator.comparing(con -> con.condition));
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        /* Return results */
        return allConditionss;
    }
    
    public static Conditions selectConditionDetails(int conID) {
        Conditions condition = new Conditions();
        String sql = "SELECT * FROM CONDITIONS WHERE CONID = " + conID;
        try {
            Connection conn = Utilities.connectToDatabase("medications.db");
            PreparedStatement stmt = conn.prepareStatement(sql);
            /* Set values here */
            ResultSet rs = stmt.executeQuery();
                condition.setConID(rs.getInt("CONID"));
                condition.setCondition(rs.getString("CONDITION"));
                condition.setDescription(rs.getString("DESCRIPTION"));
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        /* Return results */
        return condition;        
    }
    
    public static ArrayList<Medications> selectMedicationsinCondition(int conID) {
        ArrayList<Medications> medications = new ArrayList<>();
        String sql = "SELECT MEDICATIONS.MEDID, MEDICATIONS.GNAME, MEDICATIONS.BNAME FROM MEDCON INNER JOIN MEDICATIONS ON MEDICATIONS.MEDID = MEDCON.MEDID WHERE MEDCON.CONID = " + conID;
        try {
            Connection conn = Utilities.connectToDatabase("medications.db");
            PreparedStatement stmt = conn.prepareStatement(sql);
            /* Set values here */
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Medications m = new Medications();
                m.setMedID(rs.getInt("MEDID"));
                m.setGName(rs.getString("GNAME"));
                m.setBName(rs.getString("BNAME"));
                medications.add(m);
            }
            // Sorting
            medications.sort(Comparator.comparing(med -> med.gName));
        } catch (SQLException ex) {
            Logger.getLogger(DataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        /* Return results */
        return medications;   
    }
}
