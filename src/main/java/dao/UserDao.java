/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import controller.EncDecPassword;
import controller.HibernateUtil;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import model.User;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author user-22112
 */
public class UserDao {

    SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
    Session session;

    /* Method to  READ all the employees */
    /**
     *
     * @return
     */
    public List<User> listUsers() {
        List<User> userData = new ArrayList<User>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            userData = session.createQuery("FROM User").list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return userData;
    }

    public String addUser(String firstName, String secondName, String workName, String email, String password, boolean isAdmin) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            User user = new User(firstName, secondName, workName, email, password, isAdmin);
            session.save(user);
            tx.commit();
            return "added";
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }

    public String deleteUser(Integer UserID) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            User user = (User) session.get(User.class, UserID);
            session.delete(user);
            tx.commit();
            return "deleted";
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }

    public String updateUser(Integer userId, String name, String surname, String email, String password, String work, boolean admin) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            User user = new User(userId, name, surname, email, password, work, admin);
            session.update(user);
            tx.commit();
            return "updated";
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }

    public String authenticateUser(User userTemp) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            User user = userTemp;
            String email = user.getEmail();
            String password = user.getPassword();
            List<User> list = null;
            Query query = session.createQuery("FROM User WHERE email=:email AND password=:password");
            query.setParameter("email", email);
            query.setParameter("password", password);
            list = query.list();
            tx.commit();
            if (list.isEmpty()) {
                return "Неправильно заполнены поля email и/или пароль";
            } else if (list.get(0).isAdmin() == true) {
                return "Admin";
            } else {
                return "User";
            }
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }

    public String getUserPassword(String email) throws UnsupportedEncodingException, InvalidAlgorithmParameterException, NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("SELECT U.password FROM User U WHERE U.email=:email");
            query.setParameter("email", email);
            List result = query.list();
            if (!result.isEmpty()) {
                EncDecPassword decryptor = new EncDecPassword();
                return decryptor.decrypt((String) result.get(0));
            }
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }
}
