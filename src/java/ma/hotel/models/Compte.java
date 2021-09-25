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
public class Compte {
    private String login;
    private String mdp;
    private String role;
    

    public Compte(String login, String mdp, String role) {
        this.login = login;
        this.mdp = mdp;
        this.role = role;
        
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

   
    
    
    
}
