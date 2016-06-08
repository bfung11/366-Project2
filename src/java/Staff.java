/**
 * Staff reflects all necessary functions in the Staff page
 *
 * @author Brian Fung
 * @author Justin Zaman
 */

import java.util.*;
import java.time.*;
import java.sql.*;

public class Staff {
   private int reservationID;
   private String service;
   private String startDate;
   private String endDate;
   
   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setService(String service) { this.service = service; }
   public String getService() { return service; }
   public void setStartDate(String date) {this.startDate = date;}
   public String getStartDate(){return this.startDate;};
   public void setEndDate(String date) {this.endDate = date;}
   public String getEndDate(){return this.endDate;}
   
   public String checkCustomerIn() {
      try {
         String query = 
            "UPDATE reservations " + 
            "SET check_in_date = '" + LocalDate.now().toString() + "' " + 
            "WHERE reservation_id = " + reservationID;
         DBConnection connection = new DBConnection();
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      return "staff";
   }

   public String checkCustomerOut() {  
      try {
         String query = 
            "SELECT check_out_date " +
            "FROM reservations " + 
            "WHERE reservation_id = " + reservationID;
         DBConnection connection = new DBConnection();
         ResultSet hasBeenCheckedOut = connection.executeQuery(query);

         if (!hasBeenCheckedOut.next()) {
            query = 
               "UPDATE reservations " + 
               "SET check_out_date = '" + LocalDate.now().toString() + "' " +
               "WHERE reservation_id = " + reservationID;
            connection.executeUpdate(query);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      //TODO : Print out customer bill
      return "bill";
   }
   
   public String addCharges() {
      DBConnection connection = new DBConnection();
      ResultSet results;
      int price = 0;
      
      try {
         String query = 
            "SELECT price " +
            "FROM service_prices " +
            "WHERE service_name = '" + service + "' " +
            "AND   start_date <= '" + LocalDate.now().toString() + "' " +
            "AND   end_date >= '" + LocalDate.now().toString() + "'";

         results = connection.executeQuery(query);
         if (results.next()) {
            price = results.getInt(Table.PRICE);
         }

         LocalDate aStartDate = LocalDate.parse(startDate);
         LocalDate anEndDate = LocalDate.parse(endDate);

         // Adding one day so that the equals also covers the last day
         anEndDate = anEndDate.plusDays(1);

         while (aStartDate.isBefore(anEndDate)) {
            query = 
               "INSERT INTO bills " +
               "VALUES (DEFAULT, " + 
                            reservationID + ", " +
                            "'" + aStartDate.toString() + "', " +
                            price + ", " +
                            "'" + service + "')";
            connection.executeUpdate(query);
            aStartDate = aStartDate.plusDays(1);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      return "staff";
   }

   public ArrayList<Bill> viewBill() {
      ArrayList<Bill> list = new ArrayList<Bill>();

      try {
         String dateQuery = 
            "SELECT start_date, end_date " +
            "FROM reservations " +
            "WHERE reservation_id = " + reservationID;
         DBConnection connection = new DBConnection();
         ResultSet dateResult = connection.executeQuery(dateQuery);

         if (dateResult.next()) {
            LocalDate aStartDate = LocalDate.parse(dateResult.getDate(Table.START_DATE).toString());
            LocalDate anEndDate = LocalDate.parse(dateResult.getDate(Table.END_DATE).toString());

            anEndDate = anEndDate.plusDays(1);
            while (aStartDate.isBefore(anEndDate)) {

               String billQuery = 
                  "SELECT * " +
                  "FROM bills " +
                  "WHERE reservation_id = " + reservationID + " " +
                  "AND bill_date = '" + aStartDate.toString() + "'";
               ResultSet billResult = connection.executeQuery(billQuery);
               String billDate = "";
               while (billResult.next()) {
                  billDate = billResult.getDate(Table.BILL_DATE).toString();
                  Bill bill = new Bill();
                  bill.setBillDate(billDate);
                  bill.setPrice(billResult.getString(Table.PRICE));
                  bill.setServiceName(billResult.getString(Table.SERVICE_NAME));
                  list.add(bill);
               }

               String subtotalQuery =
                  "SELECT sum(price) AS sum " +
                  "FROM bills " +
                  "WHERE reservation_id = " + reservationID + " " +
                  "AND bill_date = '" + aStartDate.toString() + "'";
               ResultSet subtotalResult = connection.executeQuery(subtotalQuery);
               if (subtotalResult.next()) {
                  Bill bill = new Bill();
                  bill.setSubtotal(subtotalResult.getString(Table.SUM));
                  list.add(bill);
               }

               aStartDate = aStartDate.plusDays(1);
            }

            String totalQuery =
               "SELECT sum(price) AS sum " +
               "FROM bills " +
               "WHERE reservation_id = " + reservationID;
            ResultSet totalResult = connection.executeQuery(totalQuery);
            if (totalResult.next()) {
               Bill bill = new Bill();
               bill.setTotal(totalResult.getString(Table.SUM));
               list.add(bill);
            }
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }

      return list;
   }
}