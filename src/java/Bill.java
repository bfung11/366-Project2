/**
 * Bill is used for the list of bills to be printed
 *
 * @author Brian Fung
 */

import java.time.*;
import java.sql.*;

public class Bill {
   private int reservationID;
   private int total;
   private String description;

   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setTotal(int total) { this.total = total; }
   public int getTotal() { return total; }
   public void setDescription(String description) { this.description = description; }
   public String getDescription() { return description; }
}