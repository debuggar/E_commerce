<jsp:include page="header.jsp" />  
<body>
<div>
<form action="admin" method="get">
<br>
Select Item:<br>
<select name="category">
        <option value="Laptop">Laptop</option>
        <option value="Mobile">Mobile</option>
        <option value="Telivision">Telivision</option>
        <option value="Refrigerator">Refrigerator</option>
        <option value="Camera">Camera</option>
</select><br>
Min Cost<br>
<input type="text" name="minCost"><br>
Max Cost<br>
<input type="text" name="maxCost"><br>
No of products<br>
<input type="text" name="pcount"><br><br>
<input type="submit" value="submit"> <input type="reset">
</form>
</div>

</body>
</html>