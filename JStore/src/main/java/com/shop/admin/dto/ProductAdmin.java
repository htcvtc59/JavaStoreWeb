package com.shop.admin.dto;

import java.sql.Date;

public class ProductAdmin {

    private static ProductAdmin instance = null;

    public ProductAdmin() {

    }

    public static ProductAdmin getInstance() {
        if (instance == null) {
            instance = new ProductAdmin();
        }
        return instance;
    }

    private int id;
    private String name;
    private String code;
    private String metatitle;
    private String description;
    private String images;
    private String moreimages;
    private double price;
    private double promotionprice;
    private boolean includedvat;
    private int quantity;
    private int categoryid;
    private String detail;
    private int warranty;
    private Date createddate;
    private boolean status;
    private Date tophot;
    private int viewcount;

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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMetatitle() {
        return metatitle;
    }

    public void setMetatitle(String metatitle) {
        this.metatitle = metatitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getMoreimages() {
        return moreimages;
    }

    public void setMoreimages(String moreimages) {
        this.moreimages = moreimages;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getPromotionprice() {
        return promotionprice;
    }

    public void setPromotionprice(double promotionprice) {
        this.promotionprice = promotionprice;
    }

    public boolean isIncludedvat() {
        return includedvat;
    }

    public void setIncludedvat(boolean includedvat) {
        this.includedvat = includedvat;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(int categoryid) {
        this.categoryid = categoryid;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public int getWarranty() {
        return warranty;
    }

    public void setWarranty(int warranty) {
        this.warranty = warranty;
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

    public Date getTophot() {
        return tophot;
    }

    public void setTophot(Date tophot) {
        this.tophot = tophot;
    }

    public int getViewcount() {
        return viewcount;
    }

    public void setViewcount(int viewcount) {
        this.viewcount = viewcount;
    }

}
