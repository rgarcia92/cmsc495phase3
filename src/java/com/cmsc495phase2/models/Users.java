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

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public final class Users {
    private int userID;
    String username; /* Package-private: Used for sorting in DataAccess */
    private String role;
    private String salt;
    private String passwordHash;
    private int lockedOut;
    private String lastLogin;

    /**
     * Basic constructor used to create a Users object
     */
    public Users() {
        /* Used to initialize object. See overloaded functions */
    }
    
    /**
     * Overloaded constructor used to create a Users object
     *
     * @param userID        the unique user identifier in the database
     * @param username      the user's name
     * @param role          the user's role
     * @param salt          the 32-character alphanumeric salt
     * @param passwordHash  the SHA256 password hash
     * @param lockedOut     the locked-out flag
     * @param lastLogin     the date of the last login
     */
    public Users(int userID, String username, String role, String salt, String passwordHash, int lockedOut, String lastLogin) {
        this.userID = userID;
        this.username = username;
        this.role = role;
        this.salt = salt;
        this.passwordHash = passwordHash;
        this.lockedOut = lockedOut;
        this.lastLogin = lastLogin;
    }

    /* Getter functions */
    public int getUserID() {
        return userID;
    }

    public String getUserame() {
        return username;
    }
    
    public String getRole() {
        return role;
    }
    
    public String getSalt() {
        return salt;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public int getLockedOut() {
        return lockedOut;
    }    

    public String getLastLogin() {
        return lastLogin;
    }
    
    /* Setter functions */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public void setLockedOut(int lockedOut) {
        this.lockedOut = lockedOut;
    }

    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin;
    }
}