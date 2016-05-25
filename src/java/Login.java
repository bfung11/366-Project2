
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.annotation.ManagedBean;
import javax.faces.application.FacesMessage;
import javax.faces.bean.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
import javax.faces.validator.ValidatorException;
import javax.inject.Named;
import javax.servlet.http.HttpSession;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * Used Lubomir Stanchev's code as a basis for this code.
 */

/**
 *
 * @author Kevin Yang
 * @author Brian Fung
 * @author Justin Zaman
 * @author Lubomir Stanchev
 */

@Named(value = "login")
@SessionScoped
@ManagedBean
public class Login implements Serializable {
   DBConnection connection;

   private String username;
   private String password;
   private UIInput loginUI;
    
   public final  int CUSTOMER = 1;
   public final  int STAFF = 2;
   public final  int ADMIN = 3;
    
    private int loginType;

    public UIInput getLoginUI() {
        return loginUI;
    }

    public void setLoginUI(UIInput loginUI) {
        this.loginUI = loginUI;
    }

    // Changing getUsername to getBlah will make XHTML from login.username to login.blah
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void validate(
            FacesContext context, 
            UIComponent component, 
            Object value
    ) throws ValidatorException, SQLException {
        this.username = loginUI.getLocalValue().toString();
        this.password = value.toString();
        String storedPassword = null;
        ResultSet result;
        
        HttpSession session = (HttpSession) context.getExternalContext().getSession(true);
        session.setAttribute("user", this.username);
        //System.out.println(session.);

        // TODO: check if user and password matches input
        //Get password from DB
        
        try {
            String query = "select password from authentications where username = '" 
                   + this.username + "'";
            DBConnection con = new DBConnection();
            int userId = -1;
            
            result = con.executeQuery(query);
            result.next();
            
            storedPassword = result.getString(1);
            this.loginType = ADMIN;
            if (!this.username.equals("admin")) {
               query = "SELECT id FROM staff AS s WHERE s.username = " + this.username;
               result = con.executeQuery(query);
               // Check if there are rows in staff
               if (result.isBeforeFirst()) {
                  this.loginType = STAFF;
                  userId = result.getInt("id");
                  session.setAttribute("userId", userId);
                  result.close();
               }
               else {
                  query = "SELECT id FROM customers AS c WHERE c.username = " + this.username;
                  result = con.executeQuery(query);
                  if (result.isBeforeFirst()) {
                     this.loginType = CUSTOMER;
                     userId = result.getInt("id");
                     session.setAttribute("userId", userId);
                     result.close();
                  }
               }
            }
            
               
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        
        if (storedPassword == null || !this.password.equals(storedPassword)) {
            FacesMessage errorMessage = new FacesMessage("Wrong username or password!");
            throw new ValidatorException(errorMessage);
        }       
    }

    public String go() {
        this.invalidateUserSession();
        switch(this.loginType) {
            case CUSTOMER:
               return "customer";
            case STAFF:
                return "staff";
            case ADMIN:
                return "admin";
            default:
                System.out.println(this.username + " is not a customer, staff, or admin!");
                return "loginError";
        }
    }
    
    public void invalidateUserSession() {
        FacesContext context = FacesContext.getCurrentInstance();
        HttpSession session = (HttpSession) context.getExternalContext().getSession(false);
        session.invalidate();
    }

}