/**
 * Bill is used for the list of bills to be printed
 *
 * @author Brian Fung
 */

import java.time.*;
import java.sql.*;

public class Bill {
   private String billDate;
   private String price;
   private String serviceName;
   private String subtotal;
   private String total;

   public void setBillDate(String billDate) { this.billDate = billDate; }
   public String getBillDate() { return billDate; }
   public void setPrice(String price) { this.price = price; }
   public String getPrice() { return price; }
   public void setServiceName(String serviceName) { this.serviceName = serviceName; }
   public String getServiceName() { return serviceName; }
   public void setSubtotal(String subtotal) { this.subtotal = subtotal; }
   public String getSubtotal() { return subtotal; }
   public void setTotal(String total) { this.total = total; }
   public String getTotal() { return total; }
}