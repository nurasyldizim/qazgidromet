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
            Double bsh = ((request.getParameter("bsh").equals("")) ? null : Double.valueOf(request.getParameter("bsh")));
            Double ds = ((request.getParameter("ds").equals("")) ? null : Double.valueOf(request.getParameter("ds")));
            Double sr = ((request.getParameter("sr").equals("")) ? null : Double.valueOf(request.getParameter("sr")));
            Double ou = ((request.getParameter("ou").equals("")) ? null : Double.valueOf(request.getParameter("ou")));
            Double do_ = ((request.getParameter("do_").equals("")) ? null : Double.valueOf(request.getParameter("do_")));
            Double oa = ((request.getParameter("oa").equals("")) ? null : Double.valueOf(request.getParameter("oa")));
            Double ozon = ((request.getParameter("ozon").equals("")) ? null : Double.valueOf(request.getParameter("ozon")));
            Double serovodorod = ((request.getParameter("serovodorod").equals("")) ? null : Double.valueOf(request.getParameter("serovodorod")));
            Double fenol = ((request.getParameter("fenol").equals("")) ? null : Double.valueOf(request.getParameter("fenol")));
            Double fv = ((request.getParameter("fv").equals("")) ? null : Double.valueOf(request.getParameter("fv")));
            Double hlor = ((request.getParameter("hlor").equals("")) ? null : Double.valueOf(request.getParameter("hlor")));
            Double hv = ((request.getParameter("hv").equals("")) ? null : Double.valueOf(request.getParameter("hv")));
            Double ammiak = ((request.getParameter("ammiak").equals("")) ? null : Double.valueOf(request.getParameter("ammiak")));
            Double skIs = ((request.getParameter("skIs").equals("")) ? null : Double.valueOf(request.getParameter("skIs")));
            Double formaldigid = ((request.getParameter("formaldigid").equals("")) ? null : Double.valueOf(request.getParameter("formaldigid")));
            Double nsm = ((request.getParameter("nsm").equals("")) ? null : Double.valueOf(request.getParameter("nsm")));
            Double hromSh = ((request.getParameter("hromSh").equals("")) ? null : Double.valueOf(request.getParameter("hromSh")));
            Double sumU = ((request.getParameter("sumU").equals("")) ? null : Double.valueOf(request.getParameter("sumU")));
            
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
                Double bsh = ((request.getParameter("bsh"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("bsh"+pnzDataId)));
                Double ds = ((request.getParameter("ds"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("ds"+pnzDataId)));
                Double sr = ((request.getParameter("sr"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("sr"+pnzDataId)));
                Double ou = ((request.getParameter("ou"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("ou"+pnzDataId)));
                Double do_ = ((request.getParameter("do_"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("do_"+pnzDataId)));
                Double oa = ((request.getParameter("oa"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("oa"+pnzDataId)));
                Double ozon = ((request.getParameter("ozon"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("ozon"+pnzDataId)));
                Double serovodorod = ((request.getParameter("serovodorod"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("serovodorod"+pnzDataId)));
                Double fenol = ((request.getParameter("fenol"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("fenol"+pnzDataId)));
                Double fv = ((request.getParameter("fv"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("fv"+pnzDataId)));
                Double hlor = ((request.getParameter("hlor"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("hlor"+pnzDataId)));
                Double hv = ((request.getParameter("hv"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("hv"+pnzDataId)));
                Double ammiak = ((request.getParameter("ammiak"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("ammiak"+pnzDataId)));
                Double skIs = ((request.getParameter("skIs"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("skIs"+pnzDataId)));
                Double formaldigid = ((request.getParameter("formaldigid"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("formaldigid"+pnzDataId)));
                Double nsm = ((request.getParameter("nsm"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("nsm"+pnzDataId)));
                Double hromSh = ((request.getParameter("hromSh"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("hromSh"+pnzDataId)));
                Double sumU = ((request.getParameter("sumU"+pnzDataId).equals("")) ? null : Double.valueOf(request.getParameter("sumU"+pnzDataId)));

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