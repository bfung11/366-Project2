/**
 * Registration reflects all necessary functions in the Registration page
 *
 * @author Brian Fung
 * @author Justin Zaman
 */

import java.time.*;
import java.sql.*;

public class Registration {
   private String username;
   private String password;
   private String firstName;
   private String lastName;
   private String email;
   private String address;
   private int creditCardNumber;
   private int crc;
   private LocalDate expirationDate;

   public void setUsername(String username) { this.username = username; }
   public String getUsername() { return username; }
   public void setPassword(String password) { this.password = password; }
   public String getPassword() { return password; }
   public void setFirstName(String firstName) { this.firstName = firstName; }
   public String getFirstName() { return firstName; }
   public void setLastName(String lastName) { this.lastName = lastName; }
   public String getLastName() { return lastName; }
   public void setEmail(String email) { this.email = email; }
   public String getEmail() { return email; }
   public void setAddress(String address) { this.address = address; }
   public String getAddress() { return address; }
   public void setCreditCardNumber(int creditCardNumber) { this.creditCardNumber = creditCardNumber; }
   public int getCreditCardNumber() { return creditCardNumber; }
   public void setCRC(int crc) { this.crc = crc; }
   public int getCRC() { return crc; }
   public void setExpirationDate(LocalDate expirationDate) { this.expirationDate = expirationDate; }
   public LocalDate getExpirationDate() { return expirationDate; }

   public void createCustomer() {
      try {
         DBConnection connection = new DBConnection();
         String query = 
            "INSERT INTO authentications " + 
            "VALUES ('" + username + "', '" + password + "')";
         connection.executeUpdate(query);

         query = 
            "INSERT INTO credit_cards " + 
            "VALUES (" + creditCardNumber + ", " + crc + ", '" + expirationDate + "')";
         connection.executeUpdate(query);

         query = 
            "INSERT INTO customers " + 
            "VALUES (" + "'" + username + "', " +
                         "'" + firstName + "', " + 
                         "'" + lastName + "')";
      }
      catch (Exception e) {
         e.printStackTrace();
      }
   }
}