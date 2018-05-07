package model;
// Generated 07.05.2018 17:57:59 by Hibernate Tools 4.3.1

/**
 * User generated by hbm2java
 */

public class User  implements java.io.Serializable {

     private Integer id;
     private String firstName;
     private String secondName;
     private String workName;
     private String email;
     private String password;
     private boolean admin;

    public User() {
    }

	
    public User(String email, String password, boolean admin) {
        this.email = email;
        this.password = password;
        this.admin = admin;
    }
    public User(String firstName, String secondName, String workName, String email, String password, boolean admin) {
       this.firstName = firstName;
       this.secondName = secondName;
       this.workName = workName;
       this.email = email;
       this.password = password;
       this.admin = admin;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public String getFirstName() {
        return this.firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getSecondName() {
        return this.secondName;
    }
    
    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }
    public String getWorkName() {
        return this.workName;
    }
    
    public void setWorkName(String workName) {
        this.workName = workName;
    }
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    public boolean isAdmin() {
        return this.admin;
    }
    
    public void setAdmin(boolean admin) {
        this.admin = admin;
    }




}

