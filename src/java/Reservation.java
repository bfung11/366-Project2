/**
 * Reservation is used for the list of reservations to be printed
 *
 * @author Brian Fung
 */

import java.time.*;
import java.sql.*;

public class Reservation {
   private int reservationID;
   private String startDate;
   private String endDate;
   private int viewType;
   private int roomType;
   private int floorNumber;
   private int roomNumber;

   public void setReservationID(int reservationID) { this.reservationID = reservationID; }
   public int getReservationID() { return reservationID; }
   public void setStartDate(String date) { startDate = date; }
   public String getStartDate() { return startDate; }
   public void setEndDate(String date) { endDate = date; }
   public String getEndDate() { return endDate; }
   public void setFloorNumber(int floorNumber) { this.floorNumber = floorNumber; }
   public int getFloorNumber() { return floorNumber; }
   public void setRoomNumber(int roomNumber) { this.roomNumber = roomNumber; }
   public int getRoomNumber() { return roomNumber; }
   public void setViewType(int viewType) { this.viewType = viewType; }
   public int getViewType() { return viewType; }
   public void setRoomType(int roomType) { this.roomType = roomType; }
   public int getRoomType() { return roomType; }
}