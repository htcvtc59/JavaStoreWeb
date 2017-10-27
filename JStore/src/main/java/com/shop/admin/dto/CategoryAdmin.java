
package com.shop.admin.dto;

import java.sql.Date;

public class CategoryAdmin {
    
    private static CategoryAdmin instance = null;

    public CategoryAdmin() {

    }

    public static CategoryAdmin getInstance() {
        if (instance == null) {
            instance = new CategoryAdmin();
        }
        return instance;
    }
    
    private int id;
    private String name;
    private String metatitle;
    private int parentid;
    private int displayorder;
    private String seotitle;
    private Date createddate;
    private boolean status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMetatitle() {
        return metatitle;
    }

    public void setMetatitle(String metatitle) {
        this.metatitle = metatitle;
    }

    public int getParentid() {
        return parentid;
    }

    public void setParentid(int parentid) {
        this.parentid = parentid;
    }

    public int getDisplayorder() {
        return displayorder;
    }

    public void setDisplayorder(int displayorder) {
        this.displayorder = displayorder;
    }

    public String getSeotitle() {
        return seotitle;
    }

    public void setSeotitle(String seotitle) {
        this.seotitle = seotitle;
    }

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
}
