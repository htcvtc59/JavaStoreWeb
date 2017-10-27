/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.iconnectdb.idao;

import com.shop.admin.dto.CategoryAdmin;
import java.util.ArrayList;

/**
 *
 * @author MacOS
 */
public interface tblCategoryDAO {

    public boolean insertCategoryAdmin(CategoryAdmin category);

    public boolean deleteCategoryAdmin(int id);

    public boolean updateCategoryAdmin(CategoryAdmin category, int id);

    public ArrayList<CategoryAdmin> dataCategoryAdmin();

    public ArrayList<CategoryAdmin> dataCategoryOrder();

    public ArrayList<CategoryAdmin> dataCategoryParentID(int parentid);

}
