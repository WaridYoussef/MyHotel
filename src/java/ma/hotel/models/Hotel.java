/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ma.hotel.models;

import java.util.Date;

/**
 *
 * @author hp
 */
public class Hotel {
    private int idh;
    private String nomh;
    private Ville ville;
    private String img;
    private Responsable responsable;
    private String etat;
    private String adresse;
    private int etoile;
    private Date datepub;

    public Hotel(int idh, String nomh, Ville ville, String img, Responsable responsable, String etat, String adresse, int etoile, Date datepub) {
        this.idh = idh;
        this.nomh = nomh;
        this.ville = ville;
        this.img = img;
        this.responsable = responsable;
        this.etat = etat;
        this.adresse = adresse;
        this.etoile = etoile;
        this.datepub = datepub;
    }

    public int getIdh() {
        return idh;
    }

    public void setIdh(int idh) {
        this.idh = idh;
    }

    public String getNomh() {
        return nomh;
    }

    public void setNomh(String nomh) {
        this.nomh = nomh;
    }

    public Ville getVille() {
        return ville;
    }

    public void setVille(Ville ville) {
        this.ville = ville;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Responsable getResponsable() {
        return responsable;
    }

    public void setResponsable(Responsable responsable) {
        this.responsable = responsable;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public int getEtoile() {
        return etoile;
    }

    public void setEtoile(int etoile) {
        this.etoile = etoile;
    }

    public Date getDatepub() {
        return datepub;
    }

    public void setDatepub(Date datepub) {
        this.datepub = datepub;
    }
    
    
    
    
}
