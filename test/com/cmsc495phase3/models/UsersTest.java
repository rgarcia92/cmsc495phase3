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
package com.cmsc495phase3.models;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public final class UsersTest {
    
    public UsersTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getUserID method, of class Users.
     */
    @Test
    public void testGetUserID() {
        System.out.println("getUserID");
        Users instance = new Users();
        int expResult = 0;
        int result = instance.getUserID();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getUserame method, of class Users.
     */
    @Test
    public void testGetUserame() {
        System.out.println("getUserame");
        Users instance = new Users();
        String expResult = "";
        String result = instance.getUserName();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getRole method, of class Users.
     */
    @Test
    public void testGetRole() {
        System.out.println("getRole");
        Users instance = new Users();
        String expResult = "";
        String result = instance.getRole();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getSalt method, of class Users.
     */
    @Test
    public void testGetSalt() {
        System.out.println("getSalt");
        Users instance = new Users();
        String expResult = "";
        String result = instance.getSalt();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getPasswordHash method, of class Users.
     */
    @Test
    public void testGetPasswordHash() {
        System.out.println("getPasswordHash");
        Users instance = new Users();
        String expResult = "";
        String result = instance.getPasswordHash();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getLockedOut method, of class Users.
     */
    @Test
    public void testGetLockedOut() {
        System.out.println("getLockedOut");
        Users instance = new Users();
        int expResult = 0;
        int result = instance.getLockedOut();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getLastLogin method, of class Users.
     */
    @Test
    public void testGetLastLogin() {
        System.out.println("getLastLogin");
        Users instance = new Users();
        String expResult = "";
        String result = instance.getLastLogin();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setUserID method, of class Users.
     */
    @Test
    public void testSetUserID() {
        System.out.println("setUserID");
        int userID = 0;
        Users instance = new Users();
        instance.setUserID(userID);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setUserName method, of class Users.
     */
    @Test
    public void testSetUserName() {
        System.out.println("setUserName");
        String userName = "";
        Users instance = new Users();
        instance.setUserName(userName);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setRole method, of class Users.
     */
    @Test
    public void testSetRole() {
        System.out.println("setRole");
        String role = "";
        Users instance = new Users();
        instance.setRole(role);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setSalt method, of class Users.
     */
    @Test
    public void testSetSalt() {
        System.out.println("setSalt");
        String salt = "";
        Users instance = new Users();
        instance.setSalt(salt);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setPasswordHash method, of class Users.
     */
    @Test
    public void testSetPasswordHash() {
        System.out.println("setPasswordHash");
        String passwordHash = "";
        Users instance = new Users();
        instance.setPasswordHash(passwordHash);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setLockedOut method, of class Users.
     */
    @Test
    public void testSetLockedOut() {
        System.out.println("setLockedOut");
        int lockedOut = 0;
        Users instance = new Users();
        instance.setLockedOut(lockedOut);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setLastLogin method, of class Users.
     */
    @Test
    public void testSetLastLogin() {
        System.out.println("setLastLogin");
        String lastLogin = "";
        Users instance = new Users();
        instance.setLastLogin(lastLogin);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getUserName method, of class Users.
     */
    @Test
    public void testGetUserName() {
        System.out.println("getUserName");
        Users instance = new Users();
        String expResult = "";
        String result = instance.getUserName();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getNewLogin method, of class Users.
     */
    @Test
    public void testGetNewLogin() {
        System.out.println("getNewLogin");
        Users instance = new Users();
        String expResult = "";
        String result = instance.getNewLogin();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setNewLogin method, of class Users.
     */
    @Test
    public void testSetNewLogin() {
        System.out.println("setNewLogin");
        String newLogin = "";
        Users instance = new Users();
        instance.setNewLogin(newLogin);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
