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
public class Ville {
    private int idville;
    private String nomville;

    public Ville(int idville, String nomville) {
        this.idville = idville;
        this.nomville = nomville;
    }

    public int getIdville() {
        return idville;
    }

    public void setIdville(int idville) {
        this.idville = idville;
    }

    public String getNomville() {
        return nomville;
    }

    public void setNomville(String nomville) {
        this.nomville = nomville;
    }
    
    
}
