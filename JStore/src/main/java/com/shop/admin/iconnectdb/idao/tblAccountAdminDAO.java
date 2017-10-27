package com.shop.admin.iconnectdb.idao;

import com.shop.admin.dto.AccountAdmin;
import java.util.ArrayList;

public interface tblAccountAdminDAO {

    public boolean insertAccountAdmin(AccountAdmin a);

    public boolean deleteAccountAdmin(int id);

    public boolean updateAccountAdmin(AccountAdmin a, int id);

    public ArrayList<AccountAdmin> dataAccountAdmin();
    
    public boolean loginAccountAdmin(AccountAdmin a);

}
