$(document).ready(function(){
    
    $("#orders_table").on("cocoon:before-insert change", ".product-select", function() {
        
        // Get the select field
        var selected_product = $(this);
        
        // Obtain the price value from its data attribute
        var product_price = selected_product.find(':selected').data('unit-price');
        
        // Display it as text in the <span> tag
        selected_product.parent().parent().find('.product-price').text(product_price);
        
        // Display total
        updateTotal(product_price);
    });
    
    function updateTotal(total) {
        $("#total").text("Total: " + total);
    };
    
});