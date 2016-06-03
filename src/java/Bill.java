/**
 * Bill is used for the list of bills to be printed
 *
 * @author Brian Fung
 */

import java.time.*;
import java.sql.*;

public class Bill {
   private int reservationID;
   private String billDate;
   private int price;
   private String serviceName;

   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setBillDate(String billDate) { this.billDate = billDate; }
   public String getBillDate() { return billDate; }
   public void setPrice(int price) { this.price = price; }
   public int getPrice() { return price; }
   public void setServiceName(String serviceName) { this.serviceName = serviceName; }
   public String getServiceName() { return serviceName; }
}