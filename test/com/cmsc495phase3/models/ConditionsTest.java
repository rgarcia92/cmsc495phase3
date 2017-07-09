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
public final class ConditionsTest {
    
    public ConditionsTest() {
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
     * Test of getConID method, of class Conditions.
     */
    @Test
    public void testGetConID() {
        System.out.println("getConID");
        Conditions instance = new Conditions();
        int expResult = 0;
        int result = instance.getConID();
        assertEquals(expResult, result);
        // Review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getCondition method, of class Conditions.
     */
    @Test
    public void testGetCondition() {
        System.out.println("getCondition");
        Conditions instance = new Conditions();
        String expResult = "";
        String result = instance.getCondition();
        assertEquals(expResult, result);
        // Review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getDescription method, of class Conditions.
     */
    @Test
    public void testGetDescription() {
        System.out.println("getDescription");
        Conditions instance = new Conditions();
        String expResult = "";
        String result = instance.getDescription();
        assertEquals(expResult, result);
        // Review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setConID method, of class Conditions.
     */
    @Test
    public void testSetConID() {
        System.out.println("setConID");
        int conID = 0;
        Conditions instance = new Conditions();
        instance.setConID(conID);
        // Review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setCondition method, of class Conditions.
     */
    @Test
    public void testSetCondition() {
        System.out.println("setCondition");
        String condition = "";
        Conditions instance = new Conditions();
        instance.setCondition(condition);
        // Review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setDescription method, of class Conditions.
     */
    @Test
    public void testSetDescription() {
        System.out.println("setDescription");
        String description = "";
        Conditions instance = new Conditions();
        instance.setDescription(description);
        // Review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
