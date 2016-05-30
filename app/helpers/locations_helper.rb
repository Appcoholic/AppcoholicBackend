module LocationsHelper
    
    def display_product_stock quantity
        case quantity
            when 0
                content_tag :span, quantity, :class => "label label-danger"
            when 1..10
                content_tag :span, quantity, :class => "label label-warning"
            else
                content_tag :span, quantity, :class => "label label-success"
        end
    end
    
end
