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
   private String startDate;
   private String endDate;
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
   public void setStartDate(String date) { startDate = LocalDate.parse(date).toString(); }
   public String getStartDate() { return startDate; }
   public void setEndDate(String date) { endDate = LocalDate.parse(date).toString(); }
   public String getEndDate() { return endDate; }
   public void setRoomPrice(int price) { this.price = price; }
   public int getRoomPrice() { return price; }

   public String updatePassword() {
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
      return "admin";
   }

   public String createStaff() {
      try {
         DBConnection connection = new DBConnection();
         String authQuery = "INSERT INTO authentications " + 
                            "VALUES (" + "'" + username + "', " + 
                                         "'" + password + "', " +
                                               "'staff')";
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
      
      return "admin";
   }

   public String addRoomPrice() throws Exception {
      try {
         if (!isEndDateBeforeStartDate()) {
            throw new Exception("End date must be after start date");
         }

         if (!isRoomOnFloor()) {
            throw new Exception("Room must be on the same floor");
         }

         String query = 
            "SELECT * " + 
            "FROM room_prices " + 
            "WHERE start_date = " + "'" + startDate + "' " + 
            "AND end_date = " + "'" + endDate + "' " + 
            "AND floor_num = " + floorNumber + " " + 
            "AND room_num = " + roomNumber;
         DBConnection connection = new DBConnection();
         ResultSet result = connection.executeQuery(query);

         if (result.next()) {
            String update = 
               "UPDATE room_prices " + 
               "SET price = " + price + " " +
               "WHERE start_date = " + "'" + startDate + "' " + 
               "AND end_date = " + "'" + endDate + "'";
            connection.executeUpdate(update);
         }  
         else {
            String insert = 
               "INSERT INTO room_prices (floor_num, room_num, start_date, end_date, price) " + 
               "VALUES (" + floorNumber + ", " + 
                            roomNumber + ", " + 
                      "'" + startDate + "'" + ", " +
                      "'" + endDate + "'" + ", " +
                            price + ")";
            connection.executeUpdate(insert);
         }

         result.close();
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      return "admin";
   }

   private boolean isRoomOnFloor() {
      String number = roomNumber + "";

      return floorNumber == Integer.parseInt(number.substring(0, 1));
   }

   private boolean isEndDateBeforeStartDate() {
      LocalDate start = LocalDate.parse(startDate);
      LocalDate end = LocalDate.parse(endDate);

      return start.isBefore(end) || start.isEqual(end);
   }
}