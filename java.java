Edit 
<script>
    // Save changes from the modal
    function saveChanges() {
        let formData = $("#editForm").serialize(); 

        $.ajax({
            url: '${baseurl}/doh-master',
            type: 'POST',
            data: formData + '&action=editData',  
            success: function(response) {
                // Handle success response
                swal.fire({
                    title: 'Edited!',
                    text: 'The data has been successfully edited.',
                    icon: 'success',
                    willClose: function() {
                        $('#editModal').modal('hide');  
                        table.ajax.reload();  
                    }
                });
            },
            error: function(xhr, status, error) {
                swal.fire({
                    title: 'Error!',
                    text: 'An error occurred while editing the data.',
                    icon: 'error'
                });
            }
        });
    }
</script>

protected void doeditData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    String category = request.getParameter("selectcategory");
    String drug = request.getParameter("selectdrug");
    String procode = request.getParameter("selectprocode");
    String prodesc = request.getParameter("selectprodesc");
    String updateBy = (String) request.getSession().getAttribute("userID");  
    LocalDateTime updateDate = LocalDateTime.now();  

    ItemModel doh = new ItemModel();
    doh.setItemcategory(category);
    doh.setIddrugcateg(drug);
    doh.setProcode(procode);
    doh.setProdecs(prodesc);
    doh.setUpdatedby(updateBy);
    doh.setUpdateddate(updateDate.toString());

    boolean success = DOHMaster.editdoh(doh);

    Map<String, Object> responseData = new LinkedHashMap<>();
    responseData.put("success", success);
    response.getWriter().write(Useful.gson(responseData));
}

public static boolean editdoh(ItemModel doh) {
    Connection connection = null;
    PreparedStatement ps = null;
    try {
        connection = HCP.getDataSource().getConnection();
        String updateQuery = "UPDATE items_table SET category = ?, drug_categ = ?, pro_code = ?, pro_desc = ?, updated_by = ?, updated_date = ? WHERE id_items = ?";
        ps = connection.prepareStatement(updateQuery);
        ps.setString(1, doh.getItemcategory());
        ps.setString(2, doh.getIddrugcateg());
        ps.setString(3, doh.getProcode());
        ps.setString(4, doh.getProdecs());
        ps.setString(5, doh.getUpdatedby());
        ps.setString(6, doh.getUpdateddate());
        ps.setInt(7, doh.getId_items());  

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    } finally {
        RSM.closeConnection(connection, ps);
    }
}

$("#selectcategory").select2({
    placeholder: 'Search here...',
    allowClear: true,
    closeOnSelect: true,
    minimumInputLength: 2, 
    ajax: {
        url: "${baseurl}/doh-master",
        dataType: 'json',
        type: 'POST',
        data: function (params) {
            return {
                action: "get_category",
                q: params.term 
            };
        },
        processResults: function (data) {
            return {
                results: data.results.map(function (item) {
                    return {
                        id: item.id_category,
                        text: item.item_category
                    };
                })
            };
        }
    }
});

protected void doCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    Object categories = DOHMaster.getcategory();
    Map<String, Object> result = new LinkedHashMap<>();
    result.put("results", categories);

    response.getWriter().write(Useful.gson(result));
}

public static List<Map<String, Object>> getcategory() {
    List<Map<String, Object>> categories = new ArrayList<>();
    // Your database logic to fetch categories
    // Add each category to the 'categories' list
    return categories;
}

$('#editModal').on('shown.bs.modal', function () {
    $('#selectcategory').select2().trigger('change');
    $('#selectdrug').select2().trigger('change');
    $('#selectprocode').select2().trigger('change');
    $('#selectprodesc').select2().trigger('change');
});

