package com.cvbuilder.controller;

import com.cvbuilder.model.CVBean;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CVServlet extends HttpServlet {

    // GET: sample template flow
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("sample".equals(action)) {
            CVBean sample = new CVBean();
            sample.setFullName("Aisyah Rahman");
            sample.setTitle("Junior Software Developer");
            sample.setEmail("aisyah.rahman@example.com");
            sample.setPhone("+60 12-345 6789");
            sample.setLinkedin("https://linkedin.com/in/aisyahrahman");
            sample.setSummary("Motivated graduate with hands-on experience in Java web "
                    + "development and database design. Enjoys building practical systems.");

            sample.setDegree("Bachelor of Computer Science (Hons.)");
            sample.setInstitution("Universiti Teknologi MARA");
            sample.setGradYear("2025");
            sample.setMajor("Computer Science");

            sample.setJobTitle("Software Developer Intern");
            sample.setCompany("TechNova Sdn Bhd");
            sample.setDuration("Jun 2025 - Dec 2025");
            sample.setResponsibilities("Built REST APIs with Java and Spring\n"
                    + "Designed MySQL database tables\n"
                    + "Fixed bugs and wrote unit tests");

            sample.setTechnicalSkills("Java, JSP, Servlets, SQL, HTML, CSS, Git");
            sample.setSoftSkills("Teamwork, Communication, Problem Solving");

            request.setAttribute("cvData", sample);
            RequestDispatcher rd = request.getRequestDispatcher("/cvView.jsp");
            rd.forward(request, response);
        } else {
            // No action: go to the form
            RequestDispatcher rd = request.getRequestDispatcher("/cvForm.jsp");
            rd.forward(request, response);
        }
    }

    // POST: form submission flow
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CVBean cv = new CVBean();

        // Personal
        cv.setFullName(request.getParameter("fullName"));
        cv.setTitle(request.getParameter("title"));
        cv.setEmail(request.getParameter("email"));
        cv.setPhone(request.getParameter("phone"));
        cv.setLinkedin(request.getParameter("linkedin"));
        cv.setSummary(request.getParameter("summary"));
        cv.setPhotoUrl(request.getParameter("photoUrl"));

        // Education
        cv.setDegree(request.getParameter("degree"));
        cv.setInstitution(request.getParameter("institution"));
        cv.setGradYear(request.getParameter("gradYear"));
        cv.setMajor(request.getParameter("major"));

        // Experience
        cv.setJobTitle(request.getParameter("jobTitle"));
        cv.setCompany(request.getParameter("company"));
        cv.setDuration(request.getParameter("duration"));
        cv.setResponsibilities(request.getParameter("responsibilities"));

        // Skills
        cv.setTechnicalSkills(request.getParameter("technicalSkills"));
        cv.setSoftSkills(request.getParameter("softSkills"));

        if (cv.validate()) {
            request.setAttribute("cvData", cv);
            RequestDispatcher rd = request.getRequestDispatcher("/cvView.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("errors", cv.getErrors());
            RequestDispatcher rd = request.getRequestDispatcher("/cvError.jsp");
            rd.forward(request, response);
        }
    }
}