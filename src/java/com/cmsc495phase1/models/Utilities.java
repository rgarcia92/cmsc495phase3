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
        return request.getHeader("User-Agent").toLowerCase().contains("mobi");
    }
}
