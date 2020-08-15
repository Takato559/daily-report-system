package controllers.reports;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Report;
import utils.DBUtil;

/**
 * Servlet implementation class ReportsApprovalServlet
 */
@WebServlet("/reports/approval")
public class ReportsApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportsApprovalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String _token = (String)request.getParameter("_token");
        if(_token != null && _token.equals(request.getSession().getId())) {
            EntityManager em = DBUtil.createEntityManager();
            Report r = em.find(Report.class, Integer.parseInt(request.getParameter("report_id_for_approval")));

            if(r.getApproval() == 1) {
                r.setApproval(0);
//                request.getSession().setAttribute("result", "承認する");
            } else {
                r.setApproval(1);
//                request.getSession().setAttribute("result", "承認を解除する");
            }

            em.getTransaction().begin();
            em.getTransaction().commit();
            em.close();

//            request.getSession().setAttribute("flush", "承認しました。");
            response.sendRedirect(request.getContextPath() + "/reports/index");
        }
//        else {
////            System.out.println("うまくいっていません。");
//        }
    }

}
