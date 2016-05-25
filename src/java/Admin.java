/**
 * Admin reflects all necessary functions in the Admin page
 *
 * @author Brian Fung
 * @author Justin Zaman
 */

import java.time.*;
import java.sql.*;

public class Admin {
   private String username;
   private String password;
   private String firstName;
   private String lastName;
   private LocalDate startDate;
   private LocalDate endDate;
   private int floorNumber;
   private int roomNumber;
   private int price;

   public void setUsername(String username) { this.username = username; }
   public String getUsername() { return username; }
   public void setPassword(String password) { this.password = password; }
   public String getPassword() { return password; }
   public void setFirstName(String firstName) { this.firstName = firstName; } 
   public String getFirstName() { return firstName; }
   public void setLastName(String lastName) { this.lastName = lastName; }
   public String getLastName() { return lastName; }
   public void setFloorNumber(int floorNumber) { this.floorNumber = floorNumber; }
   public int getFloorNumber() { return floorNumber; }
   public void setRoomNumber(int roomNumber) { this.roomNumber = roomNumber; }
   public int getRoomNumber() { return roomNumber; }
   public void setStartDate(String date) { startDate = LocalDate.parse(date); }
   public LocalDate getStartDate() { return startDate; }
   public void setEndDate(String date) { endDate = LocalDate.parse(date); }
   public LocalDate getEndDate() { return endDate; }
   public void setRoomPrice(int price) { this.price = price; }
   public int getRoomPrice() { return price; }

   public void updateAdminPassword(String password) {
      try {
         DBConnection connection = new DBConnection();
         String query = "UPDATE authentications " + 
                        "SET password = '" + password + "' " + 
                        "WHERE username = 'admin'";
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   public void createStaff() {
      try {
         DBConnection connection = new DBConnection();
         String authQuery = "INSERT INTO authentications " + 
                            "VALUES (" + "'" + username + "', " + 
                                         "'" + password + "')";
         String staffQuery = "INSERT INTO staff " + 
                             "VALUES (" + "'" + username + "', " + 
                                          "'" + firstName + "', " + 
                                          "'" + lastName + "')"; 
         connection.executeUpdate(authQuery);
         connection.executeUpdate(staffQuery);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }

   public void addRoomPrice() {
      try {
         String query = 
            "SELECT * " + 
            "FROM room_prices " + 
            "WHERE start_date = " + "'" + startDate.toString() + "'" + 
            "AND end_date = " + "'" + endDate.toString() + "'";
         DBConnection connection = new DBConnection();
         ResultSet result = connection.executeQuery(query);

         if (result.next()) {
            String update = 
               "UPDATE room_prices " + 
               "SET price = " + price + 
               "WHERE start_date = " + "'" + startDate.toString() + "'" + 
               "AND end_date = " + "'" + endDate.toString() + "'";
            connection.executeUpdate(update);
         }  
         else {
            String insert = 
               "INSERT INTO room_prices " + 
               "VALUES (" + floorNumber + ", " + 
                            roomNumber + ", " + 
                            "'" + startDate.toString() + "'" + ", " +
                            "'" + endDate.toString() + "'" + ", " +
                            price + ")";
            connection.executeUpdate(insert);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }   
   }
}