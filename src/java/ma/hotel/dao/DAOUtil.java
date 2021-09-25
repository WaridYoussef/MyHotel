/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ma.hotel.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Utilisateur
 */
public class DAOUtil {
    
     public static Connection getConnection() throws Exception{
         Connection con=null;
         String url="jdbc:oracle:thin:@localhost:1521/xe";
         String user="hotel";
         String mdp="hotel";
         try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             con=DriverManager.getConnection(url, user, mdp);
         } catch (ClassNotFoundException ex) {
             throw new Exception("impossible de charger le driver");
         } catch (SQLException ex) {
             throw new Exception("impossible de Se Connecter"+ex.getMessage());
         }
         
         return con;
         
     }
        
    
}
