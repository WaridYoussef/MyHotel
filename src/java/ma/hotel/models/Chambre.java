/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ma.hotel.models;

/**
 *
 * @author hp
 */
public class Chambre {
    private String idch;
    private String imgch;
    private float prix;
    private int idcat;
    private Hotel hotel;
    private int numch;
    private String etatch;

    public Chambre(String idch, String imgch, float prix, int idcat, Hotel hotel, int numch, String etatch) {
        this.idch = idch;
        this.imgch = imgch;
        this.prix = prix;
        this.idcat = idcat;
        this.hotel = hotel;
        this.numch = numch;
        this.etatch = etatch;
    }

    public String getIdch() {
        return idch;
    }

    public void setIdch(String idch) {
        this.idch = idch;
    }

    public String getImgch() {
        return imgch;
    }

    public void setImgch(String imgch) {
        this.imgch = imgch;
    }

    public float getPrix() {
        return prix;
    }

    public void setPrix(float prix) {
        this.prix = prix;
    }

    public int getIdcat() {
        return idcat;
    }

    public void setIdcat(int idcat) {
        this.idcat = idcat;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

    public int getNumch() {
        return numch;
    }

    public void setNumch(int numch) {
        this.numch = numch;
    }

    public String getEtatch() {
        return etatch;
    }

    public void setEtatch(String etatch) {
        this.etatch = etatch;
    }
    
    
    
}
