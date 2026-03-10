

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import DataBase.DBConnection;

/**
 * Servlet implementation class StudentProfile
 */
@WebServlet("/StudentProfile")
public class StudentProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
HttpSession session = request.getSession(false);
		
		response.setContentType("text/html");
		PrintWriter out= response.getWriter();
		
		if(session == null || !"student".equals(session.getAttribute("userrole"))) {
			response.sendRedirect("student_authentication.jsp");
			return;
		}
		
		request.getRequestDispatcher("/Student/student_profile.jsp").include(request, response);
		
		try(Connection con = DBConnection.getConnection()){
//			Statement st = con.createStatement();
			
			String studentName = (String) session.getAttribute("username");
			out.println("<script>");
			out.println("document.getElementById('username').innerText = '" + studentName + "';");
			out.println("document.getElementById('profile_logo').innerText = '"+studentName.toUpperCase().charAt(0)+"'");
			out.println("</script>");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
