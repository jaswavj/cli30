<%@ page language="java" contentType="text/csv; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}
response.setHeader("Content-Disposition", "attachment; filename=\"Product_Bulk_Upload_Sample.csv\"");
out.print("\uFEFF");
%>
Category,Brand,Product Name,Product Code,HSN,Unit,Cost Price,MRP,GST
General,Others,Sample Product 1,SP001,1234,Nos,50.00,100.00,18
General,Others,Sample Product 2,SP002,5678,Nos,25.00,45.00,5
