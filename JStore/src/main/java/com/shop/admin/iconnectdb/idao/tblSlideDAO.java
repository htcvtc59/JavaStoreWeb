/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.iconnectdb.idao;

import com.shop.admin.dto.SlideAdmin;
import java.util.ArrayList;

/**
 *
 * @author MacOS
 */
public interface tblSlideDAO {

    public boolean insertSlideAdmin(SlideAdmin slide);

    public boolean deleteSlideAdmin(int id);

    public boolean updateSlideAdmin(SlideAdmin slide, int id);

    public ArrayList<SlideAdmin> dataSlideAdmin();
}
