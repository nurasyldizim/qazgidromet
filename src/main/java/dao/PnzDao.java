/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import controller.HibernateUtil;
import java.util.ArrayList;
import model.Pnz;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author user-22112
 */
public class PnzDao {

    SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
    Session session;

    /* Method to  READ all the employees */
    /**
     *
     * @return
     */
    public List<Pnz> listPnzs(int cityId) {
        List<Pnz> pnzData = new ArrayList<Pnz>();
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            pnzData = session.createQuery("FROM Pnz WHERE city_id = " + cityId + "").list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
        return pnzData;
    }

}
