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
   private String viewType;
   private String roomType;
   private String startDate;
   private String endDate;

   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setViewType(String viewType) { this.viewType = viewType; }
   public String getViewType() { return viewType; }
   public void setRoomType(String roomType) { this.roomType = roomType; }
   public String getRoomType() { return roomType; }
   public void setStartDate(String date) { startDate = date; }
   public String getStartDate() { return startDate; }
   public void setEndDate(String date) { endDate = date; }
   public String getEndDate() { return endDate; }

   public void makeReservation() {
      try {
         String query = 
            "SELECT RO.floor_num, RO.room_num " + 
            "FROM rooms RO " + 
            "WHERE RO.view_type = '" + viewType + "' AND " + 
                  "RO.room_type = '" + roomType + "' AND " + 
                  "RO.room_num NOT IN " + 
                     "((SELECT room_num " + 
                       "FROM reservations " + 
                       "WHERE start_date >= '" + startDate + "' AND " + 
                             "start_date <= '" + endDate + "') " +
                     "UNION " + 
                     "(SELECT room_num " +
                      "FROM reservations " + 
                      "WHERE end_date >= '" + startDate + "' AND " + 
                             "end_date <= '" + endDate + "') " +
                     "UNION " + 
                     "(SELECT room_num " + 
                      "FROM reservations " + 
                      "WHERE start_date <= '" + startDate + "' AND " + 
                             "end_date >= '" + endDate + "'))";
         DBConnection connection = new DBConnection();
         ResultSet result = connection.executeQuery(query);
         int reservationID = 0;

         if (result.next()) {
            int floorNumber = result.getInt(Table.FLOOR_NUMBER);
            int roomNumber = result.getInt(Table.ROOM_NUMBER);

            getUsername();
            query = 
               "INSERT INTO reservations " + 
               "VALUES " + 
                  "(DEFAULT, " + 
                    "'" + this.username + "', " +
                          floorNumber + ", " +
                          roomNumber + ", " + 
                    "'" + startDate + "', " + 
                    "'" + endDate + "', " + 
                    "NULL, NULL)";
            ResultSet generatedKeys = connection.executeUpdate(query);          
            
            if (generatedKeys.next()) {
               reservationID = generatedKeys.getInt(Table.RESERVATION_ID);
            }
            
            query = 
               "INSERT INTO bills " +
               "VALUES " +
               "   (" + reservationID + ", 0, 'List of Services Ordered');";
            connection.executeUpdate(query);
         }

         result.close();
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
            "WHERE username = '" + username + "'";  
         DBConnection connection = new DBConnection();
         ResultSet result = connection.executeQuery(query);

         while (result.next()) {
            int id = result.getInt(Table.RESERVATION_ID);
            int floorNumber = result.getInt(Table.FLOOR_NUMBER);
            int roomNumber = result.getInt(Table.ROOM_NUMBER);
            LocalDate startDate = 
               LocalDate.parse(result.getDate(Table.START_DATE).toString());
            LocalDate endDate = 
               LocalDate.parse(result.getDate(Table.END_DATE).toString());

            query = 
               "SELECT * " + 
               "FROM rooms " + 
               "WHERE room_num = " + roomNumber + " AND " + 
                     "floor_num = " + floorNumber;
            ResultSet room_result = connection.executeQuery(query);

            if (room_result.next()) {
               String viewType = room_result.getString(Table.VIEW_TYPE);
               String roomType = room_result.getString(Table.ROOM_TYPE);

               Reservation reservation = new Reservation();
               reservation.setReservationID(id);
               reservation.setStartDate(startDate.toString());
               reservation.setEndDate(endDate.toString());
               reservation.setFloorNumber(floorNumber);
               reservation.setRoomNumber(roomNumber);
               reservation.setViewType(viewType);
               reservation.setRoomType(roomType);

               list.add(reservation);
            }

            room_result.close();
         }

         result.close();
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
      System.out.println("login: " + login.getUsername());
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