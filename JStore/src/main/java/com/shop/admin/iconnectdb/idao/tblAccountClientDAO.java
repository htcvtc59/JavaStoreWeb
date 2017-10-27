/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.iconnectdb.idao;

import com.shop.admin.dto.AccountClientAdmin;
import java.util.ArrayList;

/**
 *
 * @author MacOS
 */
public interface tblAccountClientDAO {
    
    public int insertAccountClient(AccountClientAdmin a);

    public boolean deleteAccountClient(int id);

    public boolean updateAccountClient(AccountClientAdmin a, int id);

    public ArrayList<AccountClientAdmin> dataAccountClient();
    
    public boolean loginAccountClient(AccountClientAdmin a);
}
