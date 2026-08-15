<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

Connection con = null;
Statement st = null;
String msg = "";
String type = "success";

try {
    con = util.DBConnectionManager.getConnectionFromPool();
    st = con.createStatement();

    try {
        st.execute(
            "ALTER TABLE `prod_product` " +
            "MODIFY COLUMN `tamil_name` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL"
        );
        msg = "Tamil name column updated to utf8mb4. You can save Tamil text now.";
    } catch (SQLException modifyEx) {
        if (modifyEx.getMessage() != null && modifyEx.getMessage().toLowerCase().contains("unknown column")) {
            st.execute(
                "ALTER TABLE `prod_product` " +
                "ADD COLUMN `tamil_name` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL AFTER `name`"
            );
            msg = "Tamil name column added with utf8mb4. You can save Tamil text now.";
        } else {
            throw modifyEx;
        }
    }

    con.commit();
} catch (Exception e) {
    if (con != null) {
        try { con.rollback(); } catch (SQLException ignore) {}
    }
    msg = "Database fix failed: " + (e.getMessage() != null ? e.getMessage() : "Unknown error");
    type = "danger";
} finally {
    if (st != null) try { st.close(); } catch (Exception ignore) {}
    if (con != null) try { con.close(); } catch (Exception ignore) {}
}

response.sendRedirect(
    request.getContextPath() + "/product/master/product/product.jsp?msg="
    + java.net.URLEncoder.encode(msg, "UTF-8") + "&type=" + type
);
