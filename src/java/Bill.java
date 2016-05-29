/**
 * Bill is used for the list of bills to be printed
 *
 * @author Brian Fung
 */

import java.time.*;
import java.sql.*;

public class Bill {
   private int reservationID;
   private int price;
   private String description;

   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setPrice(int price) { this.price = price; }
   public int getPrice() { return price; }
   public void setDescription(String description) { description = description; }
   public String getDescription() { return description; }
}