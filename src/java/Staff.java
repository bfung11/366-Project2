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
      DBConnection connection = new DBConnection();
      ResultSet results;
      LocalDate startDate, endDate;
      int price;
      int roomNum;
      int total;
      String description;
      
      //Set checkout date
      try {
         String query = 
            "UPDATE reservations " + 
            "SET check_out_date = '" + LocalDate.now().toString() + "' " +
            "WHERE reservation_id = " + reservationID;
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      //Get date range of reservation
      try {
         String query = 
            "SELECT * " +
            "FROM reservations " +
            "WHERE reservation_id = " + reservationID;

         results = connection.executeQuery(query);
         while (results.next()) {
            startDate = LocalDate.parse(results.getString(Table.START_DATE));
            endDate = LocalDate.parse(results.getString(Table.CHECK_OUT_DATE));
            roomNum = results.getInt(Table.ROOM_NUMBER);
            
            //Set end date 1 day later so loop will include end date
            endDate = endDate.plusDays(1);
            
            //Add room charges to bill for all dates in range of reservation
            while (startDate.isBefore(endDate)) {
               price = getRoomPriceForDay(startDate, roomNum);
               addRoomPriceToBill(startDate, price);
               startDate = startDate.plusDays(1);
            }
            
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      
      //TODO : Print out customer bill
      return "bill";
   }

   private int getRoomPriceForDay(LocalDate date, int roomNum) {
      DBConnection connection = new DBConnection();
      ResultSet results;
      int price = 0;
      
      try {
         String query = 
            "SELECT max(price) " +
            "FROM room_prices " +
            "WHERE start_date <= '" + date + "' " +
            "AND   end_date >= '" + date + "' " +
            "AND   room_num = " + roomNum;


         results = connection.executeQuery(query);
         while (results.next()) {
            price = results.getInt(1);
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      return price;
   }

   private void addRoomPriceToBill(LocalDate startDate, int price) {
      DBConnection connection = new DBConnection();
      
      try {
         String query = 
            "INSERT INTO bills " +
            "VALUES (DEFAULT, " + reservationID + ", " +
                                  "'" + startDate.toString() + "', " + 
                                  price + ", 'Room Price')";
         connection.executeUpdate(query);
      }
      catch (Exception e) {
         e.printStackTrace();
      }
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

         while (!aStartDate.equals(anEndDate)) {
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
            while (!aStartDate.equals(anEndDate)) {

               String billQuery = 
                  "SELECT * " +
                  "FROM bills " +
                  "WHERE reservation_id = " + reservationID + " " +
                  "AND bill_date = '" + aStartDate.toString() + "'";
               ResultSet billResult = connection.executeQuery(billQuery);
               while (billResult.next()) {
                  Bill bill = new Bill();
                  bill.setReservationID(reservationID);
                  bill.setBillDate(billResult.getDate(Table.BILL_DATE).toString());
                  bill.setPrice(billResult.getInt(Table.PRICE));
                  bill.setServiceName(billResult.getString(Table.SERVICE_NAME));
                  list.add(bill);
               }

               String subtotalQuery =
                  "SELECT sum(price) AS sum" +
                  "FROM bills " +
                  "WHERE reservation_id = " + reservationID + " " +
                  "AND bill_date = '" + aStartDate.toString() + "'";
               ResultSet subtotalResult = connection.executeQuery(subtotalQuery);
               if (subtotalResult.next()) {
                  Bill bill = new Bill();
                  bill.setServiceName(subtotalResult.getString(Table.SUM));
                  list.add(bill);
               }
            }

            String totalQuery =
               "SELECT sum(price) AS sum" +
               "FROM bills " +
               "WHERE reservation_id = " + reservationID;
            ResultSet totalResult = connection.executeQuery(totalQuery);
            if (totalResult.next()) {
               Bill bill = new Bill();
               bill.setServiceName(totalResult.getString(Table.SUM));
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