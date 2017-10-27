
package com.shop.admin.dto;


public class AccountAdmin {

    private static AccountAdmin instance = null;

    public AccountAdmin() {

    }

    public static AccountAdmin getInstance() {
        if (instance == null) {
            instance = new AccountAdmin();
        }
        return instance;
    }

    private int id;
    private String username;
    private String password;
    private String salt;
    private String note;
    private boolean status;

    public AccountAdmin(int id, String username, String password, String salt, String note, boolean status) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.salt = salt;
        this.note = note;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
