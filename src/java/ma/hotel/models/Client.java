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
public class Client {
    private int idclt;
    private String cin;
    private String nomclt;
    private String prenomclt;
    private String villeclt;
    private String adresseclt;
    private String email;
    private String tel;
    private int situation;

    public Client(int idclt, String cin, String nomclt, String prenomclt, String villeclt, String adresseclt, String email, String tel, int situation) {
        this.idclt = idclt;
        this.cin = cin;
        this.nomclt = nomclt;
        this.prenomclt = prenomclt;
        this.villeclt = villeclt;
        this.adresseclt = adresseclt;
        this.email = email;
        this.tel = tel;
        this.situation = situation;
    }

    public int getIdclt() {
        return idclt;
    }

    public void setIdclt(int idclt) {
        this.idclt = idclt;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getNomclt() {
        return nomclt;
    }

    public void setNomclt(String nomclt) {
        this.nomclt = nomclt;
    }

    public String getPrenomclt() {
        return prenomclt;
    }

    public void setPrenomclt(String prenomclt) {
        this.prenomclt = prenomclt;
    }

    public String getVilleclt() {
        return villeclt;
    }

    public void setVilleclt(String villeclt) {
        this.villeclt = villeclt;
    }

    public String getAdresseclt() {
        return adresseclt;
    }

    public void setAdresseclt(String adresseclt) {
        this.adresseclt = adresseclt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public int getSituation() {
        return situation;
    }

    public void setSituation(int situation) {
        this.situation = situation;
    }

    
    
}
