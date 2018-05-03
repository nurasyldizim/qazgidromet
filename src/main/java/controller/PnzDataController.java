package controller;
 
import dao.PnzDataDao;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Pnz;
 
/**
 *
 * @author user-22112
 */
public class PnzDataController extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            String action = request.getParameter("ACTION");
            if(action.equals("Save")){
            String pnzName = URLDecoder.decode(request.getParameter("pnzName"), "UTF-8");
            int pnzId = Integer.parseInt(request.getParameter("pnzId"));
            int month = Integer.parseInt(request.getParameter("month"));
            int cityId = Integer.parseInt(request.getParameter("cityId"));
            Pnz pnz = new Pnz(pnzId,pnzName);
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm"); 
            Date pnzDateTime = (Date)formatter.parse(request.getParameter("pnzDateTime"));
            double sdda;
            double bsh = Double.valueOf(request.getParameter("bsh"));
            double ds = Double.valueOf(request.getParameter("ds"));
            double sr = Double.valueOf(request.getParameter("sr"));
            double ou = Double.valueOf(request.getParameter("ou"));
            double do_ = Double.valueOf(request.getParameter("do_"));
            double oa = Double.valueOf(request.getParameter("oa"));
            double ozon = Double.valueOf(request.getParameter("ozon"));
            double serovodorod = Double.valueOf(request.getParameter("serovodorod"));
            double fenol = Double.valueOf(request.getParameter("fenol"));
            double fv = Double.valueOf(request.getParameter("fv"));
            double hlor = Double.valueOf(request.getParameter("hlor"));
            double hv = Double.valueOf(request.getParameter("hv"));
            double ammiak = Double.valueOf(request.getParameter("ammiak"));
            double skIs = Double.valueOf(request.getParameter("skIs"));
            double formaldigid = Double.valueOf(request.getParameter("formaldigid"));
            double nsm = Double.valueOf(request.getParameter("nsm"));
            double hromSh = Double.valueOf(request.getParameter("hromSh"));
            double sumU = Double.valueOf(request.getParameter("sumU"));
            
            try {
                PnzDataDao pnzDataDao = new PnzDataDao();
                pnzDataDao.addPnzData(pnz, pnzDateTime, bsh, ds, sr, ou, do_, oa, ozon, serovodorod, fenol, fv, hlor, hv, ammiak, skIs, formaldigid, nsm, hromSh, sumU);
                response.sendRedirect("jsp/pnzdata.jsp?pnzId="+pnzId+"&pnzName="+URLEncoder.encode(pnzName, "UTF-8")+"&month="+month+"&cityId="+cityId);
            } catch (Exception e) {
                
                e.printStackTrace();
            }
            }else if(action.equals("Delete")){
                String pnzName = URLDecoder.decode(request.getParameter("pnzName"), "UTF-8");
                int pnzId = Integer.parseInt(request.getParameter("pnzId"));
                int month = Integer.parseInt(request.getParameter("month"));
                int cityId = Integer.parseInt(request.getParameter("cityId"));
                String pnzDataId = request.getParameter("id");
                try {
                PnzDataDao pnzDataDao = new PnzDataDao();
                pnzDataDao.deletePnzData(Integer.parseInt(pnzDataId));
                response.sendRedirect("jsp/pnzdata.jsp?pnzId="+pnzId+"&pnzName="+URLEncoder.encode(pnzName, "UTF-8")+"&month="+month+"&cityId="+cityId);
            } catch (Exception e) {
                
                e.printStackTrace();
            }
            }else if(action.equals("Edit")){
                String pnzName = URLDecoder.decode(request.getParameter("pnzName"), "UTF-8");
                int pnzId = Integer.parseInt(request.getParameter("pnzId"));
                int month = Integer.parseInt(request.getParameter("month"));
                int cityId = Integer.parseInt(request.getParameter("cityId"));
                String pnzDataId = request.getParameter("id");
                Pnz pnz = new Pnz(pnzId,pnzName);
                SimpleDateFormat formatter=new SimpleDateFormat("MM/dd/yyyy HH:mm");  
                Date pnzDateTime = (Date)formatter.parse(request.getParameter("dateWithoutTime"+pnzDataId)+" "+request.getParameter("time"+pnzDataId));
                double bsh = Double.valueOf(request.getParameter("bsh"+pnzDataId));
                double ds = Double.valueOf(request.getParameter("ds"+pnzDataId));
                double sr = Double.valueOf(request.getParameter("sr"+pnzDataId));
                double ou = Double.valueOf(request.getParameter("ou"+pnzDataId));
                double do_ = Double.valueOf(request.getParameter("do_"+pnzDataId));
                double oa = Double.valueOf(request.getParameter("oa"+pnzDataId));
                double ozon = Double.valueOf(request.getParameter("ozon"+pnzDataId));
                double serovodorod = Double.valueOf(request.getParameter("serovodorod"+pnzDataId));
                double fenol = Double.valueOf(request.getParameter("fenol"+pnzDataId));
                double fv = Double.valueOf(request.getParameter("fv"+pnzDataId));
                double hlor = Double.valueOf(request.getParameter("hlor"+pnzDataId));
                double hv = Double.valueOf(request.getParameter("hv"+pnzDataId));
                double ammiak = Double.valueOf(request.getParameter("ammiak"+pnzDataId));
                double skIs = Double.valueOf(request.getParameter("skIs"+pnzDataId));
                double formaldigid = Double.valueOf(request.getParameter("formaldigid"+pnzDataId));
                double nsm = Double.valueOf(request.getParameter("nsm"+pnzDataId));
                double hromSh = Double.valueOf(request.getParameter("hromSh"+pnzDataId));
                double sumU = Double.valueOf(request.getParameter("sumU"+pnzDataId));

            try {
                PnzDataDao pnzDataDao = new PnzDataDao();
                pnzDataDao.updatePnzData(Integer.parseInt(pnzDataId), pnz, pnzDateTime, bsh, ds, sr, ou, do_, oa, ozon, serovodorod, fenol, fv, hlor, hv, ammiak, skIs, formaldigid, nsm, hromSh, sumU);
                response.sendRedirect("jsp/pnzdata.jsp?pnzId="+pnzId+"&pnzName="+URLEncoder.encode(pnzName, "UTF-8")+"&month="+month+"&cityId="+cityId);
            } catch (Exception e) {
                
                e.printStackTrace();
            }
            }
            
        } catch (ParseException ex) {
 
            Logger.getLogger(PnzDataController.class.getName()).log(Level.SEVERE, null, ex);
        }
 
    }
}