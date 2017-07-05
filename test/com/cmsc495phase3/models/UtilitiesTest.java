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

import java.io.Reader;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
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
public final class UtilitiesTest {
    
    public UtilitiesTest() {
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
     * Test of isMobile method, of class Utilities.
     */
    @Test
    public void testIsMobile() {
        System.out.println("isMobile");
        HttpServletRequest request = null;
        Boolean expResult = null;
        Boolean result = Utilities.isMobile(request);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getPattern method, of class Utilities.
     */
    @Test
    public void testGetPattern() {
        System.out.println("getPattern");
        int keypadLetterGroup = 0;
        String expResult = "";
        String result = Utilities.getPattern(keypadLetterGroup);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of connectToDatabase method, of class Utilities.
     */
    @Test
    public void testConnectToDatabase() throws Exception {
        System.out.println("connectToDatabase");
        String dbName = "";
        Connection expResult = null;
        Connection result = Utilities.connectToDatabase(dbName);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of logEvent method, of class Utilities.
     */
    @Test
    public void testLogEvent() throws Exception {
        System.out.println("logEvent");
        String logEntry = "";
        Utilities instance = new Utilities();
        instance.logEvent(logEntry);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of readEventLog method, of class Utilities.
     */
    @Test
    public void testReadEventLog() throws Exception {
        System.out.println("readEventLog");
        Utilities instance = new Utilities();
        ArrayList expResult = null;
        ArrayList result = instance.readEventLog();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of sendCode method, of class Utilities.
     */
    @Test
    public void testSendCode() throws Exception {
        System.out.println("sendCode");
        String emailAddress = "";
        Utilities instance = new Utilities();
        instance.sendCode(emailAddress);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of authenticate method, of class Utilities.
     */
    @Test
    public void testAuthenticate() throws Exception {
        System.out.println("authenticate");
        String userName = "";
        String password = "";
        Utilities instance = new Utilities();
        Boolean expResult = null;
        Boolean result = instance.authenticate(userName, password);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getPasswordHash method, of class Utilities.
     */
    @Test
    public void testGetPasswordHash() throws Exception {
        System.out.println("getPasswordHash");
        String password = "";
        String salt = "";
        Utilities instance = new Utilities();
        String expResult = "";
        String result = instance.getPasswordHash(password, salt);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of removeBOM method, of class Utilities.
     */
    @Test
    public void testRemoveBOM() throws Exception {
        System.out.println("removeBOM");
        Reader br = null;
        Utilities.removeBOM(br);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of changePassword method, of class Utilities.
     */
    @Test
    public void testChangePassword() throws Exception {
        System.out.println("changePassword");
        String userName = "";
        String newPassword = "";
        Utilities instance = new Utilities();
        boolean expResult = false;
        boolean result = instance.changePassword(userName, newPassword);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
