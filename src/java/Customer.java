/**
 * Customer reflects all necessary functions in the Customer page
 *
 * @author Brian Fung
 * @author Justin Zaman
 */

import java.time.*;
import java.sql.*;

public class Customer {
   private int reservationID;
   private int floorNumber;
   private int roomNumber;
   private LocalDate startDate;
   private LocalDate endDate;

   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setFloorNumber(int floorNumber) { this.floorNumber = floorNumber; }
   public int getFloorNumber() { return floorNumber; }
   public void setRoomNumber(int roomNumber) { this.roomNumber = roomNumber; }
   public int getRoomNumber() { return roomNumber; }
   public void setStartDate(String date) { startDate = LocalDate.parse(date); }
   public LocalDate getStartDate() { return startDate; }
   public void setEndDate(String date) { endDate = LocalDate.parse(date); }
   public LocalDate getEndDate() { return endDate; }

   public void getReservation() {
      //TODO : Add queries
   }

   public void checkReservations() {
      //TODO : Add queries
   }

   public void cancelReservations() {
      //TODO : Add queries
   }
}