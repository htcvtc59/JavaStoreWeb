package com.shop.client.TransactionAPI.payment.baokim;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Hashtable;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 * Phiên bản: 1.1 Tên lớp: BaoKimPayment Chức năng: Tích hợp thanh toán qua
 * baokim.vn cho các merchant site có đăng ký API - Xây dựng URL chuyển thông
 * tin tới baokim.vn để xử lý việc thanh toán cho merchant site. - Xác thực tính
 * chính xác của thông tin đơn hàng được gửi về từ baokim.vn.
 */
public class BaoKimPayment {

    // URL checkout của baokim.vn
    private String baokim_url = "https://sandbox.baokim.vn/payment/order/version11";

    // Mã merchante site
    private String merchant_id = "647";	// Biến này được baokim.vn cung cấp khi bạn đăng ký merchant site

    // Mật khẩu bảo mật
    private String secure_pass = "ae543c080ad91c23";	// Biến này được baokim.vn cung cấp khi bạn đăng ký merchant site

    /**
     * Hàm thực hiện việc mã hóa, tạo khóa trên đường dẫn
     *
     * @param messages xâu gốc
     * @return kết quả mã hóa
     * @throws Exception
     */
    private String getHmacHash(String messages) {
        try {
            Mac mac = Mac.getInstance("HmacSHA1");
            SecretKeySpec secret = new SecretKeySpec(this.secure_pass.getBytes(), "HmacSHA1");
            mac.init(secret);
            byte[] digest = mac.doFinal(messages.getBytes());

            BigInteger hash = new BigInteger(1, digest);
            String hmac = hash.toString(16);

            if (hmac.length() % 2 != 0) {
                hmac = "0" + hmac;
            }

            return hmac;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "";
    }

    /**
     * Hàm xây dựng url chuyển đến BaoKim.vn thực hiện thanh toán, trong đó có
     * tham số mã hóa (còn gọi là public key)
     *
     * @param $order_id	Mã đơn hàng
     * @param $business Email tài khoản người bán
     * @param $total_amount	Giá trị đơn hàng
     * @param $shipping_fee	Phí vận chuyển
     * @param $tax_fee	Thuế
     * @param $order_description	Mô tả đơn hàng
     * @param $url_success	Url trả về khi thanh toán thành công
     * @param $url_cancel	Url trả về khi hủy thanh toán
     * @param $url_detail	Url chi tiết đơn hàng
     * @return url cần tạo
     */
    public String createRequestUrl(String order_id, String business, String total_amount, String shipping_fee, String tax_fee, String order_description, String url_success, String url_cancel, String url_detail) {
        Hashtable params = new Hashtable();
        params.put("merchant_id", this.merchant_id);
        params.put("order_id", order_id);
        params.put("business", business);
        params.put("total_amount", total_amount);
        params.put("shipping_fee", shipping_fee);
        params.put("tax_fee", tax_fee);
        params.put("order_description", order_description);
        params.put("url_success", url_success);
        params.put("url_cancel", url_cancel);
        params.put("url_detail", url_detail);
        
        
        //Sap xep mang thuoc tinh don hang theo key
        String[] keys = (String[]) params.keySet().toArray(new String[0]);
        Arrays.sort(keys);

        // Tao public key
        String str_combined = "";
        for (String key : keys) {
            str_combined += (String) params.get(key);
        }
        // Thực hiện mã hóa tạo checksum
        String checksum = this.getHmacHash(str_combined).toUpperCase();

        // Kiểm tra url_success xem có '?' không, nếu chưa có, bổ sung vào
        String redirect_url = baokim_url;
        if (redirect_url.indexOf("?") == -1) {
            redirect_url += "?";
        } else if (redirect_url.substring(redirect_url.length() - 1, redirect_url.length()) == "?" && redirect_url.indexOf("&") == -1) {
            // Nếu url_success có '?' nhưng không kết thúc bằng '?' và chưa có dấu '&' thì bổ sung vào cuối
            redirect_url += "&";
        }

        // Tạo url, phần chứa các tham số
        String url_params = "";
        for (String key : keys) {
            String val = (String) params.get(key);
            if (url_params == "") {
                url_params += key + "=" + java.net.URLEncoder.encode(val);
            } else {
                url_params += "&" + key + "=" + java.net.URLEncoder.encode(val);
            }
        }
        url_params += "&checksum=" + checksum;

        return redirect_url + url_params;
    }

    /**
     * Hàm thực hiện xác minh tính chính xác thông tin trả về từ BaoKim.vn
     *
     * @param $_GET chứa tham số trả về trên url
     * @return true nếu thông tin là chính xác, false nếu thông tin không chính
     * xác
     */
    public Boolean verifyResponseUrl(Hashtable get_params) {
        // Sắp xếp mảng thông tin trả về theo key để mã hóa
        String[] keys = (String[]) get_params.keySet().toArray(new String[0]);
        Arrays.sort(keys);

        // Thực hiện mã hóa dữ liệu trả về để kiểm tra
        String str_combined = "";
        String checksum = "";
        for (String key : keys) {
            if (!(key.equals("checksum") || key == "checksum")) {
                str_combined += get_params.get(key);
            } else {
                checksum = get_params.get(key).toString();
            }
        }

        String verify_checksum = this.getHmacHash(str_combined);

        // Kiểm tra kết quả mã hóa thu được xem có trùng với mã trả về từ BaoKim.vn không
        if (verify_checksum.equalsIgnoreCase(checksum)) {
            return true;
        }
        return false;
    }
}
