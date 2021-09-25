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
public class Reserv {
    private int num_res;
    private Date datedebut;
    private Date datefin;
    private int idh;
    private Chambre chambre;
    private Client client;

    public Reserv(int num_res, Date datedebut, Date datefin, int idh, Chambre chambre, Client client) {
        this.num_res = num_res;
        this.datedebut = datedebut;
        this.datefin = datefin;
        this.idh = idh;
        this.chambre = chambre;
        this.client = client;
    }

    public int getNum_res() {
        return num_res;
    }

    public void setNum_res(int num_res) {
        this.num_res = num_res;
    }

    public Date getDatedebut() {
        return datedebut;
    }

    public void setDatedebut(Date datedebut) {
        this.datedebut = datedebut;
    }

    public Date getDatefin() {
        return datefin;
    }

    public void setDatefin(Date datefin) {
        this.datefin = datefin;
    }

    public int getIdh() {
        return idh;
    }

    public void setIdh(int idh) {
        this.idh = idh;
    }

    public Chambre getChambre() {
        return chambre;
    }

    public void setChambre(Chambre chambre) {
        this.chambre = chambre;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }
    
    
    
}
