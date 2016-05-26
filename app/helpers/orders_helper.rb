module OrdersHelper
    
    def display_order_status status
        case status
            when "Pending"
                content_tag :span, :class => "label label-warning" do
                    content_tag(:i, '', :class => "fa fa-clock-o") + " #{status}"
                end
            when "Delivering"
                content_tag :span, :class => "label label-info" do
                    content_tag(:i, '', :class => "fa fa-motorcycle") + " #{status}"
                end
            when "Completed"
                content_tag :span, :class => "label label-success" do
                    content_tag(:i, '', :class => "fa fa-check") + " #{status}"
                end
            when "Cancelled"
                content_tag :span, :class => "label label-danger" do
                    content_tag(:i, '', :class => "fa fa-times") + " #{status}"
                end
        end
    end
end
