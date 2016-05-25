module OrdersHelper
    
    def display_order_status status
        case status
            when 0
                content_tag(:span, "Pending", class: "label label-warning")
            when 1
                content_tag(:span, "Completed", class: "label label-success")
            when 2
                content_tag(:span, "Canceled", class: "label label-danger")
        end
    end
end
