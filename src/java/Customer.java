/**
 * Customer reflects all necessary functions in the Customer page
 *
 * @author Brian Fung
 * @author Justin Zaman
 */

import javax.el.ELContext;
import javax.faces.context.FacesContext;
import java.time.*;
import java.sql.*;
import java.util.*;


public class Customer {
   private String username;
   private int reservationID;
   private int floorNumber;
   private int roomNumber;
   private LocalDate startDate;
   private LocalDate endDate;

   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setFloorNumber(int floorNumber) { this.floorNumber = floorNumber; }
   public int getFloorNumber() { return floorNumber; }
   public void setRoomNumber(int roomNumber) { this.roomNumber = roomNumber; }
   public int getRoomNumber() { return roomNumber; }
   public void setStartDate(String date) { startDate = LocalDate.parse(date); }
   public LocalDate getStartDate() { return startDate; }
   public void setEndDate(String date) { endDate = LocalDate.parse(date); }
   public LocalDate getEndDate() { return endDate; }

   public void makeReservation() {
      try {
         String query = 
            "INSERT INTO reservations " + 
            "VALUES " + 
               "(DEFAULT, " + 
                 "'" + username + "', " +
                       floorNumber + "', " +
                       roomNumber + ", " + 
                 "'" + startDate + "', " + 
                 "'" + endDate + "', " + 
                 "NULL, NULL)";
         DBConnection connection = new DBConnection();
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   public ArrayList<Reservation> checkReservations() {
      getUsername();

      ArrayList<Reservation> list = new ArrayList<Reservation>();
      try {
         String query = 
            "SELECT * " + 
            "FROM reservations " + 
            "WHERE reservation_id = " + reservationID;  
         DBConnection connection = new DBConnection();
         ResultSet result = connection.executeQuery(query);

         while (result.next()) {
            Reservation reservation = new Reservation();
            reservation.setReservationID(result.getInt(Table.RESERVATION_ID));
            reservation.setFloorNumber(result.getInt(Table.FLOOR_NUMBER));
            reservation.setRoomNumber(result.getInt(Table.ROOM_NUMBER));
            LocalDate startDate = 
               LocalDate.parse(result.getDate(Table.START_DATE).toString());
            reservation.setStartDate(startDate.toString());
            LocalDate endDate = 
               LocalDate.parse(result.getDate(Table.END_DATE).toString());
            reservation.setEndDate(endDate.toString());
            list.add(reservation);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }

      return list;
   }

   private void getUsername() {
      ELContext elContext = FacesContext.getCurrentInstance().getELContext();
      Login login = (Login) elContext.getELResolver().getValue(elContext, null, "login");
      username = login.getUsername();
   }

   public void cancelReservations() {
      try {
         String query = 
            "DELETE FROM bills " + 
            "WHERE reservation_id = " + reservationID;
         DBConnection connection = new DBConnection();
         connection.executeUpdate(query);

         query = 
            "DELETE FROM reservations " + 
            "WHERE reservation_id = " + reservationID;
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }
}