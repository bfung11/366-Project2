/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.Serializable;
import javax.inject.Named;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

/**
 *
 * @author Kevin Yang
 */
@Named(value = "selector")
@ManagedBean
@SessionScoped
public class Selector implements Serializable {
    private String[] adminOptions = {"Change Password", "Create New Staff", "Set Room Prices"};
    
    private String[] staffOptions = {"Check-in Guest", "Checkout Guest", "Add Charges"};
    private String[] customerOptions = {"Make Reservation", "View Reservation", "Cancel Reservation"};
    
    private String adminChoice;
    private String staffChoice;
    private String customerChoice;

    /*
     * Drop down options
    */
    
    // Get Admin options
    public String[] getAdminOptions() {
        return this.adminOptions;
    }

    // Set Admin options
    public void setAdminOptions(String[] options) {
        this.adminOptions = options;
    }

    // Get Employee Options
    public String[] getStaffOptions() {
        return this.staffOptions;
    }

    // Set Employee Options
    public void setStaffOptions(String[] options) {
        this.staffOptions = options;
    }
    
    // Get Customer Options
    public String[] getCustomerOptions() {
        return this.customerOptions;
    }

    // Set Employee Options
    public void setCustomerOptions(String[] options) {
        this.customerOptions = options;
    }
    
    
    /*
     * Drop down selection get() and set()
     */
    
    // Get Admin dropdown choice
    public String getAdminChoice() {
        return this.adminChoice;
    }

    // Set Admin dropdown choice
    public void setAdminChoice(String choice) {
        this.adminChoice = choice;
    }
    
    // Get Employee dropdown choice
    public String getStaffChoice() {
        return this.staffChoice;
    }

    // Set Employee dropdown choice
    public void setStaffChoice(String choice) {
        this.staffChoice = choice;
    }
    
        // Get Admin dropdown choice
    public String getCustomerChoice() {
        return this.customerChoice;
    }

    // Set Admin dropdown choice
    public void setCustomerChoice(String choice) {
        this.customerChoice = choice;
    }

    /*
    private String[] adminOptions = {"Change Password", "Create New Employee", "Set Room Prices"};
    
    private String[] employeeOptions = {"Check-in Guest", "Checkout Guest", "Add Charges"};
    private String[] customerOptions = {"View Schedule", "Choose Preferred Workday", "Choose Time Off"};
    */
    
    public String adminList() {
        switch (this.adminChoice) {
            case "Change Password":
                return "changeAdminPassword";
            case "Create New Staff":
                return "newStaff";
            case "Set Room Prices":
                return "setRoomPrice";
            default:
                return null;
        }
    }
    
    
    public String staffList() {
        switch (this.staffChoice) {
            case "Check-in Guest":
                return "checkIn";
            case "Checkout Guest":
                return "checkOut";
            case "Add Charges":
                return "addCharges";
            default:
                return null;
        }
    }
    
    public String customerList() {
        switch (this.customerChoice) {
            case "Make Reservation":
                return "makeReservation";
            case "View Reservation":
                return "viewReservation";
            case "Cancel Reservation":
                return "cancelReservation";
            default:
                return null;
        }
    }
    
    // Go to login page
    public String loginButton() {
       return "login";
    }
    
    // Go to register page
    public String registerButton() {
       return "register";
    }
}
