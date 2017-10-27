/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.iconnectdb.idao;

import com.shop.admin.dto.ProductAdmin;
import java.util.ArrayList;

/**
 *
 * @author MacOS
 */
public interface tblProductDAO {

    public boolean insertProductAdmin(ProductAdmin product);

    public boolean deleteProductAdmin(int id);

    public boolean updateProductAdmin(ProductAdmin product, int id);

    public ArrayList<ProductAdmin> dataProductAdmin();

    public ArrayList<ProductAdmin> dataidProductAdmin(int id);

    public boolean updateviewProductAdmin(ProductAdmin product, int id);

    public ArrayList<ProductAdmin> dataidProductAdminCate(int cateid);
    
    public ArrayList<ProductAdmin> dataidProductAdminSearch(int currentpage,int limit,String name);
    
    public int dataProductSearchTotalPage(int currentpage,int limit,String name);
}
