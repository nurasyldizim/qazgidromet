/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import model.Pnz;

import java.util.List; 
import model.City;
import model.PnzData;
 
import org.hibernate.HibernateException; 
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session; 
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author user-22112
 */
public class PnzDataDao {
  SessionFactory sessionFactory=new Configuration().configure().buildSessionFactory();
  Session session;

   /* Method to CREATE an employee in the database */

    /**
     *
     * @param pnz
     * @param pnzDateTime
     * @param bsh
     * @param ds
     * @param sr
     * @param ou
     * @param do_
     * @param oa
     * @param ozon
     * @param serovodorod
     * @param fenol
     * @param fv
     * @param hlor
     * @param hv
     * @param ammiak
     * @param skIs
     * @param formaldigid
     * @param nsm
     * @param hromSh
     * @param sumU
     */
    
   public void addPnzData(Pnz pnz, Date pnzDateTime, double bsh, double ds, double sr, double ou, double do_, double oa, double ozon, double serovodorod, double fenol, double fv, double hlor, double hv, double ammiak, double skIs, double formaldigid, double nsm, double hromSh, double sumU){
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      
      try {
         tx = session.beginTransaction();
         PnzData pnzData = new PnzData( pnz, pnzDateTime, bsh, ds, sr, ou, do_, oa, ozon, serovodorod, fenol, fv, hlor, hv, ammiak, skIs, formaldigid, nsm, hromSh, sumU);
         session.save(pnzData); 
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
   }
   
    /**
     *
     * @param pnzDataId
     * @param pnz
     * @param pnzDateTime
     * @param bsh
     * @param ds
     * @param sr
     * @param ou
     * @param do_
     * @param oa
     * @param ozon
     * @param serovodorod
     * @param fenol
     * @param fv
     * @param hlor
     * @param hv
     * @param ammiak
     * @param skIs
     * @param formaldigid
     * @param nsm
     * @param hromSh
     * @param sumU
     */
    public void updatePnzData(int pnzDataId, Pnz pnz, Date pnzDateTime, double bsh, double ds, double sr, double ou, double do_, double oa, double ozon, double serovodorod, double fenol, double fv, double hlor, double hv, double ammiak, double skIs, double formaldigid, double nsm, double hromSh, double sumU){
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      
      try {
         tx = session.beginTransaction();
         PnzData pnzData = new PnzData(pnzDataId, pnz, pnzDateTime, bsh, ds, sr, ou, do_, oa, ozon, serovodorod, fenol, fv, hlor, hv, ammiak, skIs, formaldigid, nsm, hromSh, sumU);
         session.update(pnzData); 
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
   }
   
    /**
     *
     * @param pnzId
     * @param month
     * @return
     */
    public List<PnzData> listPnzDatas(int pnzId, int month ){
      List<PnzData> pnzData = new ArrayList<PnzData>();
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      Date date = new Date();
      int year = Year.now().getValue();
      int monthCurrent = date.getMonth()+1;
      if(month > monthCurrent){
          year = year-1;
      }
      try {
         tx = session.beginTransaction();
         Query query = session.createQuery("FROM PnzData WHERE pnzID = :pnzId AND MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         query.setParameter("pnzId", pnzId);
         query.setParameter("month", month);
         query.setParameter("year", year);
         pnzData = query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }
   
    /**
     *
     * @param PnzDataID
     */
    public void deletePnzData(Integer PnzDataID){
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      
      try {
         tx = session.beginTransaction();
         PnzData pnzData = (PnzData)session.get(PnzData.class, PnzDataID); 
         session.delete(pnzData); 
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
   }

    /**
     *
     * @param pnzId
     * @param month
     * @return
     */
    public List minPnzDatas(int pnzId, int month ){
      List pnzData = new ArrayList();
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      Date date = new Date();
      int year = Year.now().getValue();
      int monthCurrent = date.getMonth()+ 1;
      if(month > monthCurrent){
          year = year-1;
      }
      try {
         tx = session.beginTransaction();
         Query query = session.createQuery("SELECT min(pnzdata.bsh), min(pnzdata.ds), min(pnzdata.sr), min(pnzdata.ou), min(pnzdata.do_), min(pnzdata.oa), min(pnzdata.ozon), min(pnzdata.serovodorod), min(pnzdata.fenol), min(pnzdata.fv), min(pnzdata.hlor), min(pnzdata.hv), min(pnzdata.ammiak), min(pnzdata.skIs), min(pnzdata.formaldigid), min(pnzdata.nsm), min(pnzdata.hromSh), min(pnzdata.sumU) FROM PnzData pnzdata WHERE pnzID = :pnzId AND MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         query.setParameter("pnzId", pnzId);
         query.setParameter("month", month);
         query.setParameter("year", year);
         pnzData = query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }

    /**
     *
     * @param pnzId
     * @param month
     * @return
     */
    public List maxPnzDatas(int pnzId, int month ){
      List pnzData = new ArrayList();
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      Date date = new Date();
      int year = Year.now().getValue();
      int monthCurrent = date.getMonth()+1;
      if(month > monthCurrent){
          year = year-1;
      }
      try {
         tx = session.beginTransaction();
         Query query = session.createQuery("SELECT max(pnzdata.bsh), max(pnzdata.ds), max(pnzdata.sr), max(pnzdata.ou), max(pnzdata.do_), max(pnzdata.oa), max(pnzdata.ozon), max(pnzdata.serovodorod), max(pnzdata.fenol), max(pnzdata.fv), max(pnzdata.hlor), max(pnzdata.hv), max(pnzdata.ammiak), max(pnzdata.skIs), max(pnzdata.formaldigid), max(pnzdata.nsm), max(pnzdata.hromSh), max(pnzdata.sumU) FROM PnzData pnzdata WHERE pnzID = :pnzId AND MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         query.setParameter("pnzId", pnzId);
         query.setParameter("month", month);
         query.setParameter("year", year);
         pnzData = query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }
      
    /**
     *
     * @param pnzId
     * @param month
     * @return
     */
    public List avgPnzDatas(int pnzId, int month ){
      List pnzData = new ArrayList();
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      Date date = new Date();
      int year = Year.now().getValue();
      int monthCurrent = date.getMonth()+1;
      if(month > monthCurrent){
          year = year-1;
      }
      try {
         tx = session.beginTransaction();
         Query query = session.createQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do_), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM PnzData pnzdata WHERE pnzID = :pnzId AND MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         query.setParameter("pnzId", pnzId);
         query.setParameter("month", month);
         query.setParameter("year", year);
         pnzData = query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }
      
    /**
     *
     * @param pnzId
     * @param month
     * @param year
     * @return
     */
    public List<PnzData> listPnzDatasByMonth(int pnzId, int month, int year ){
      List<PnzData> pnzData = new ArrayList<PnzData>();
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      try {
         tx = session.beginTransaction();
         Query query = session.createQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do_), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM PnzData pnzdata WHERE pnzID = :pnzId AND MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         query.setParameter("pnzId", pnzId);
         query.setParameter("month", month);
         query.setParameter("year", year);
         pnzData = query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }
   
    /**
     *
     * @param month
     * @param year
     * @return
     */
    public List<PnzData> listAllPnzDatasByMonth(int month, int year, int cityId ){
      List<PnzData> pnzData = new ArrayList<PnzData>();
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      try {
         tx = session.beginTransaction();
         SQLQuery query = session.createSQLQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.dO), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM pnz_data pnzdata, Pnz p WHERE MONTH(pnzDateTime)= "+month+" AND YEAR(pnzDateTime)= "+year+" AND pnzdata.pnzID=p.pnzID AND p.city_id="+cityId+"");
         pnzData = query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }
      
    /**
     *
     * @param month
     * @return
     */
    public ArrayList<PnzData>[] qAvgPnzDatas( int month, int cityId ){
      ArrayList<PnzData>[] avgData = (ArrayList<PnzData>[])new ArrayList[4];
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      Date date = new Date();
      int currentYear = Year.now().getValue();
      int lastYear = Year.now().getValue()-1;
      int monthCurrent = date.getMonth()+1;
      if(month > monthCurrent){
          currentYear = currentYear-1;
          lastYear = lastYear-1;
      }
      try {
         tx = session.beginTransaction();
         SQLQuery query1 = session.createSQLQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM pnz_data pnzdata, Pnz p WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year AND pnzdata.pnzID=p.pnzID AND p.city_id="+cityId+" ");
         if(month==1){
            query1.setParameter("month", 12);
            query1.setParameter("year", lastYear-1);
         }else{
            query1.setParameter("month", month-1);
            query1.setParameter("year", lastYear);
         }
         avgData[0] = (ArrayList<PnzData>) query1.list();
         tx.commit();
         
         tx = session.beginTransaction();
         SQLQuery query2 = session.createSQLQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM pnz_data pnzdata, Pnz p WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year AND pnzdata.pnzID=p.pnzID AND p.city_id="+cityId+" ");
         query2.setParameter("month", month);
         query2.setParameter("year", lastYear);
         avgData[1] = (ArrayList<PnzData>) query2.list();
         tx.commit();
         
         tx = session.beginTransaction();
         SQLQuery query3 = session.createSQLQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM pnz_data pnzdata, Pnz p WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year AND pnzdata.pnzID=p.pnzID AND p.city_id="+cityId+" ");
         if(month == 12){
            query3.setParameter("month", 1);
            query3.setParameter("year", currentYear);
         }else{
            query3.setParameter("month", month+1);
            query3.setParameter("year", lastYear);
         }
         avgData[2] = (ArrayList<PnzData>) query3.list();
         tx.commit();
         
         tx = session.beginTransaction();
         SQLQuery query4 = session.createSQLQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM pnz_data pnzdata, Pnz p WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year AND pnzdata.pnzID=p.pnzID AND p.city_id="+cityId+" ");
         if(month == 1){
            query4.setParameter("month", 12);
            query4.setParameter("year", lastYear);
         }else{
            query4.setParameter("month", month-1);
            query4.setParameter("year", currentYear);
         }
         avgData[3] = (ArrayList<PnzData>) query4.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return avgData;
   }
    
    public ArrayList<PnzData>[] listQAvgToPP(String dateStr ) throws ParseException{
      ArrayList<PnzData>[] avgData = (ArrayList<PnzData>[])new ArrayList[4];
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
      Date date = formatter.parse(dateStr);
      SimpleDateFormat formatYear = new SimpleDateFormat("YYYY");
      int currentYear = Integer.parseInt(formatYear.format(date));
      int lastYear = currentYear-1;
      int monthCurrent = date.getMonth()+1;
  
      try {
         tx = session.beginTransaction();
         Query query1 = session.createQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do_), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM PnzData pnzdata WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         if(monthCurrent==1){
            query1.setParameter("month", 12);
            query1.setParameter("year", lastYear-1);
         }else{
            query1.setParameter("month", monthCurrent-1);
            query1.setParameter("year", lastYear);
         }
         avgData[0] = (ArrayList<PnzData>) query1.list();
         System.out.println(query1.list().size());
         tx.commit();
         
         tx = session.beginTransaction();
         Query query2 = session.createQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do_), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM PnzData pnzdata WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         query2.setParameter("month", monthCurrent);
         query2.setParameter("year", lastYear);
         avgData[1] = (ArrayList<PnzData>) query2.list();
         System.out.println(query2.list().size());
         tx.commit();
         
         tx = session.beginTransaction();
         Query query3 = session.createQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do_), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM PnzData pnzdata WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         if(monthCurrent == 12){
            query3.setParameter("month", 1);
            query3.setParameter("year", currentYear);
         }else{
            query3.setParameter("month", monthCurrent+1);
            query3.setParameter("year", lastYear);
         }
         avgData[2] = (ArrayList<PnzData>) query3.list();
         System.out.println(query3.list().size());
         tx.commit();
         
         tx = session.beginTransaction();
         Query query4 = session.createQuery("SELECT avg(pnzdata.bsh), avg(pnzdata.ds), avg(pnzdata.sr), avg(pnzdata.ou), avg(pnzdata.do_), avg(pnzdata.oa), avg(pnzdata.ozon), avg(pnzdata.serovodorod), avg(pnzdata.fenol), avg(pnzdata.fv), avg(pnzdata.hlor), avg(pnzdata.hv), avg(pnzdata.ammiak), avg(pnzdata.skIs), avg(pnzdata.formaldigid), avg(pnzdata.nsm), avg(pnzdata.hromSh), avg(pnzdata.sumU) FROM PnzData pnzdata WHERE MONTH(pnzDateTime)= :month AND YEAR(pnzDateTime)= :year");
         if(monthCurrent == 1){
            query4.setParameter("month", 12);
            query4.setParameter("year", lastYear);
         }else{
            query4.setParameter("month", monthCurrent-1);
            query4.setParameter("year", currentYear);
         }
         avgData[3] = (ArrayList<PnzData>) query4.list();
         System.out.println(query4.list().size());
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return avgData;
   }
    
    public ArrayList<PnzData>[] listPnzDatasToPP(int pnzId, String dateStr ) throws ParseException{
      ArrayList<PnzData>[] pnzData = (ArrayList<PnzData>[])new ArrayList[4];
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
      Date date;
      String dateTime;
      Query query;
      Calendar cal = Calendar.getInstance();
      try {
         tx = session.beginTransaction();
         dateTime = dateStr+" 13:00";
         date = simpleDateFormat.parse(dateTime);
         cal.setTime(date);
         cal.add(Calendar.DAY_OF_MONTH, -1);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", simpleDateFormat.parse(simpleDateFormat.format(cal.getTime())));
         pnzData[0] = (ArrayList<PnzData>) query.list();
         tx.commit();
         
         tx = session.beginTransaction();
         dateTime = dateStr+" 19:00";
         date = simpleDateFormat.parse(dateTime);
         cal.setTime(date);
         cal.add(Calendar.DAY_OF_MONTH, -1);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", cal.getTime());
         pnzData[1] = (ArrayList<PnzData>) query.list();
         tx.commit();
         
         tx = session.beginTransaction();
         dateTime = dateStr+" 01:00";
         date = simpleDateFormat.parse(dateTime);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", date);
         pnzData[2] = (ArrayList<PnzData>) query.list();
         tx.commit();
         
         tx = session.beginTransaction();
         dateTime = dateStr+" 07:00";
         date = simpleDateFormat.parse(dateTime);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", date);
         pnzData[3] = (ArrayList<PnzData>) query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }
    
    public ArrayList<PnzData>[] listPnzDatasToFP(int pnzId, String dateStr ) throws ParseException{
      ArrayList<PnzData>[] pnzData = (ArrayList<PnzData>[])new ArrayList[4];
      Session session = sessionFactory.openSession();
      Transaction tx = null;
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
      Date date;
      String dateTime;
      Query query;
      try {
         tx = session.beginTransaction();
         dateTime = dateStr+" 01:00";
         date = simpleDateFormat.parse(dateTime);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", date);
         pnzData[0] = (ArrayList<PnzData>) query.list();
         tx.commit();
         
         tx = session.beginTransaction();
         dateTime = dateStr+" 07:00";
         date = simpleDateFormat.parse(dateTime);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", date);
         pnzData[1] = (ArrayList<PnzData>) query.list();
         tx.commit();
         
         tx = session.beginTransaction();
         dateTime = dateStr+" 13:00";
         date = simpleDateFormat.parse(dateTime);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", date);
         pnzData[2] = (ArrayList<PnzData>) query.list();
         tx.commit();
         
         tx = session.beginTransaction();
         dateTime = dateStr+" 19:00";
         date = simpleDateFormat.parse(dateTime);
         query = session.createQuery("SELECT pnzdata.bsh, pnzdata.ds, pnzdata.sr, pnzdata.ou, pnzdata.do_, pnzdata.oa, pnzdata.ozon, pnzdata.serovodorod, pnzdata.fenol, pnzdata.fv, pnzdata.hlor, pnzdata.hv, pnzdata.ammiak, pnzdata.skIs, pnzdata.formaldigid, pnzdata.nsm, pnzdata.hromSh, pnzdata.sumU FROM PnzData pnzdata WHERE pnzID = :pnzId AND pnzDateTime= :date ");
         query.setParameter("pnzId", pnzId);
         query.setParameter("date", date);
         pnzData[3] = (ArrayList<PnzData>) query.list();
         tx.commit();
      } catch (HibernateException e) {
         if (tx!=null) tx.rollback();
         e.printStackTrace(); 
      } finally {
         session.close(); 
      }
      return pnzData;
   }
}