

<%        if(session!=null) {
                session.invalidate();
        }


      RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
       rd.forward(request,response);
       %>
