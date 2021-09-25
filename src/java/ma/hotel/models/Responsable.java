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
public class Responsable {
    private int idr;
    private String nom;
    private String prenom;
    private String email;
    private Compte compte;
    private String imgres;
    private Date datenaiss;

    public Responsable(int idr, String nom, String prenom, String email, String imgres, Date datenaiss ,Compte compte) {
        this.idr = idr;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.imgres = imgres;
        this.datenaiss = datenaiss;
        this.compte = compte;
        
    }

    public int getIdr() {
        return idr;
    }

    public void setIdr(int idr) {
        this.idr = idr;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Compte getCompte() {
        return compte;
    }

    public void setCompte(Compte compte) {
        this.compte = compte;
    }

    public String getImgres() {
        return imgres;
    }

    public void setImgres(String imgres) {
        this.imgres = imgres;
    }

    public Date getDatenaiss() {
        return datenaiss;
    }

    public void setDatenaiss(Date datenaiss) {
        this.datenaiss = datenaiss;
    }

   
    
}
