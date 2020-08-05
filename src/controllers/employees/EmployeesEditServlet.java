package controllers.employees;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Employee;
import utils.DBUtil;

/**
 * Servlet implementation class EmployeesEditServlet
 */
@WebServlet("/employees/edit")
public class EmployeesEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeesEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();

        Employee e = em.find(Employee.class, Integer.parseInt(request.getParameter("id")));
        //注意したいのが request.getParameter() はどのようなデータもString型のデータとして取得するという特徴です。
        em.close();

        request.setAttribute("employee", e);
        request.setAttribute("_token", request.getSession().getId());
        //こっちは良いにしても
        request.getSession().setAttribute("employee_id", e.getId());
        //こっちはいつ使う？Updateで使う。なぜ？ EditServ -> edit.jsp -> UpdateServ
        //リクエストスコープにIDを入れた場合、このあと作成する /update へデータを
        //送信する際に <input type="hidden"> を使ってメッセージIDの情報をフォームに追加する必要があります。
        //しかし今回はセッションスコープへメッセージのIDの情報を保存して、/update へ渡すことにしました。


        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/employees/edit.jsp");
        rd.forward(request, response);
    }

}
