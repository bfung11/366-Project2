/**
 * Staff reflects all necessary functions in the Staff page
 *
 * @author Brian Fung
 */

import java.time.*;
import java.sql.*;

public class Staff {
   private int reservationID;
   private String service;

   public void setReservationID(int reservationID) {
      this.reservationID = reservationID;
   }

   public int getReservationID() {
      return reservationID;
   }

   public void checkCustomerIn() {
      try {
         String query = 
            "UPDATE reservations " + 
            "SET check_in_date = '" + LocalDate.now().toString() + "' " + 
            "WHERE reservation_id = " + reservationID;
         DBConnection connection = new DBConnection();
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   public void checkCustomerOut() {
      try {
         String query = 
            "UPDATE reservations " + 
            "SET check_out_date = '" + LocalDate.now().toString() + "' " +
            "WHERE reservation_id = " + reservationID;
         DBConnection connection = new DBConnection();
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   public void setService(String service) {
      this.service = service;
   }

   public String getService() {
      return service;
   }

   public void addCharges() {
      // TODO : Add queries
      // TODO : Add to description of bill
   }
}