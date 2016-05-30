module InventoryOrdersHelper
    
    def display_order_quantity quantity
        if quantity > 0
           content_tag :span, "+#{quantity}" , class: 'text-success'
        else
           content_tag :span, quantity , class: 'text-danger' 
        end
    end
end
