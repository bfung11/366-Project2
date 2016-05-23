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
 * @author stanchev
 */
@Named(value = "selector")
@ManagedBean
@SessionScoped
public class Selector implements Serializable {
    private String[] adminOptions = {"Change Password", "Create New Employee", "Set Room Prices"};
    
    private String[] employeeOptions = {"Check-in Guest", "Checkout Guest", "Add Charges"};
    private String[] customerOptions = {"View Schedule", "Choose Preferred Workday", "Choose Time Off"};
    
    private String adminChoice;
    private String employeeChoice;
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
    public String[] getEmployeeOptions() {
        return this.employeeOptions;
    }

    // Set Employee Options
    public void setEmployeeOptions(String[] options) {
        this.employeeOptions = options;
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
    public String getEmployeeChoice() {
        return this.employeeChoice;
    }

    // Set Employee dropdown choice
    public void setEmployeeChoice(String choice) {
        this.employeeChoice = choice;
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
                return "docViewSchedule";
            case "Create New Employee":
                return "docPrefWorkday";
            case "Set Room Prices":
                return "docTimeOff";
            default:
                return null;
        }
    }
    
    
    public String employeeList() {
        switch (this.employeeChoice) {
            case "Check-in Guest":
                return "techViewSchedule";
            case "Checkout Guest":
                return "techPrefWorkday";
            case "Add Charges":
                return "techTimeOff";
            default:
                return null;
        }
    }
        
    public String customerList() {
        switch (this.customerChoice) {
            case "View Schedule":
                return "listDoctors";
            case "Choose Preferred Workday":
                return "newDoctor";
            case "Choose Time Off":
                return "deleteDoctor";
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
