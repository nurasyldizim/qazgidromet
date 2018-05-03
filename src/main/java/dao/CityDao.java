/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.City;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Nurasy Dizim
 */
public class CityDao {
      SessionFactory sessionFactory=new Configuration().configure().buildSessionFactory();
  Session session;

   /* Method to  READ all the cities */

    /**
     *
     * @return
     */
    
   public List<City> listCitis( ){
      List<City> cityData = new ArrayList<City>();
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      
      try {
         tx = session.beginTransaction();
         cityData = session.createQuery("FROM City").list(); 
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return cityData;
   }
   
   
}
