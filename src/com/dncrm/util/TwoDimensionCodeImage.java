package com.dncrm.util;

import jp.sourceforge.qrcode.data.QRCodeImage;

import java.awt.image.BufferedImage;

/**
 * 二维码
 * 创建人：Simon创建时间：2015年4月10日
 */
public class TwoDimensionCodeImage implements QRCodeImage {

    BufferedImage bufImg;

    public TwoDimensionCodeImage(BufferedImage bufImg) {
        this.bufImg = bufImg;
    }

    @Override
    public int getHeight() {
        return bufImg.getHeight();
    }

    @Override
    public int getPixel(int x, int y) {
        return bufImg.getRGB(x, y);
    }

    @Override
    public int getWidth() {
        return bufImg.getWidth();
    }

}
