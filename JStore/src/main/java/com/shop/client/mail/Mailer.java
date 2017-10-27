package com.shop.client.mail;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class Mailer {

    public static void send(final String from, final String password, String to, String sub, String msg, String content) {
        //Get properties object    
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        //get Session   
        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });
        //compose message    
        try {
            MimeMessage message = new MimeMessage(session);
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(sub, "UTF-8");
            message.setText(msg, "UTF-8");
            message.setContent(content, "text/html; charset=UTF-8");
            System.setProperty("mail.mime.charset", "utf8");
            //send message  
            Transport.send(message);
            System.out.println("message sent successfully");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

    }

    public static String HtmlContentCart(String name, String email, String phone, String subject, String msg) {
        StringBuilder contentBuilder = new StringBuilder();
        try {
            BufferedReader in = new BufferedReader(new FileReader("C:\\Users\\MacOS\\Documents\\NetBeansProjects\\JStore\\src\\main\\webapp\\cart.html"));
            String str;
            while ((str = in.readLine()) != null) {
                contentBuilder.append(str);
            }
            in.close();
        } catch (IOException e) {

        }
        String content = contentBuilder.toString();
        content = content.replace("YOUR NEW", name);
        content = content.replace("SPRING WARDROBE", subject);
        content = content.replace("Aenean amet dignissim erat eu adipiscing ullamcorper nisl morbi semper integer aliquet ante egestas a sociis porta ac integer conubia cras.", "<div>Email<b>" + email + "<b></div>" + "<div>Phone<b>" + phone + "<b></div>" + "<div>Content<b>" + msg + "<b></div>");

        return content;
    }

    public static String HtmlContent(String name, String email, String phone, String subject, String msg) {

        StringBuilder contentBuilder = new StringBuilder();
        try {
            BufferedReader in = new BufferedReader(new FileReader("C:\\Users\\MacOS\\Documents\\NetBeansProjects\\JStore\\src\\main\\webapp\\cart.html"));
            String str;
            while ((str = in.readLine()) != null) {
                contentBuilder.append(str);
            }
            in.close();
        } catch (IOException e) {

        }
        String content = contentBuilder.toString();
        content = content.replace("YOUR NEW", name);
        content = content.replace("SPRING WARDROBE", subject);
        content = content.replace("Aenean amet dignissim erat eu adipiscing ullamcorper nisl morbi semper integer aliquet ante egestas a sociis porta ac integer conubia cras.", "<div>Email<b>" + email + "<b></div>" + "<div>Phone<b>" + phone + "<b></div>" + "<div>Content<b>" + msg + "<b></div>");

        return content;
    }

}
