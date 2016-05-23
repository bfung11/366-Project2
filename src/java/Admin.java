/**
 * Admin reflects all necessary functions in the Admin page
 *
 * @author Brian Fung
 */

import java.time.*;

public class Admin {
   private String username;
   private String password;
   private String firstName;
   private String lastName;
   private LocalDate startDate;
   private LocalDate endDate;
   private int roomNumber;
   private int price;

   public void updatePassword(String password) {
      DBConnection.updatePassword(password);
   }

   public void setUsername(String username) {
      this.username = username;
   }

   public String getUsername() {
      return username;
   }

   public void setPassword(String password) {
      this.password = password;
   }

   public String getPassword() {
      return password;
   }

   public void setFirstName(String firstName) {
      this.firstName = firstName;
   } 

   public String getFirstName() {
      return firstName;
   }

   public void setLastName(String lastName) {
      this.lastName = lastName;
   }

   public String getLastName() {
      return lastName;
   }

   public void createStaff() {

   }

   public void setStartDate(String date) {
      startDate = LocalDate.parse(date);

   }

   public LocalDate getStartDate() {
      return startDate;
   }

   public void setEndDate(String date) {
      endDate = LocalDate.parse(date);
   }

   public LocalDate getEndDate() {
      return endDate;
   }

   public void setRoomNumber(int roomNumber) {
      this.roomNumber = roomNumber;
   }

   public int getRoomNumber() {
      return roomNumber;
   }

   public void setRoomPrice(int price) {
      this.price = price;
   }

   public int getRoomPrice() {
      return price;
   }

   public void addRoomPrice() {

   }
}