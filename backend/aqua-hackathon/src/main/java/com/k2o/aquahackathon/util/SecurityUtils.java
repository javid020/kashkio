package com.k2o.aquahackathon.util;

import java.security.MessageDigest;

public class SecurityUtils {

    public static String sha1EncodedText(String plainText) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA1");
            md.update(plainText.getBytes());
            return bytesToHex(md.digest());

        } catch (Exception e) {
            return "";
        }
    }

    private static String bytesToHex(byte[] bytes) {
        char[] hexDigit = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
        StringBuilder builder = new StringBuilder();
        for (byte bytesItem : bytes) {
            builder.append(hexDigit[(bytesItem >> 4) & 0x0f]);
            builder.append(hexDigit[bytesItem & 0x0f]);
        }
        return builder.toString();
    }}
