module OrdersHelper
    
    def display_order_status status
        case status
            when 0
                content_tag :span, :class => "label label-warning" do
                    content_tag(:i, '', :class => "fa fa-clock-o") + ' Pending'
                end
            when 1
                content_tag :span, :class => "label label-success" do
                    content_tag(:i, '', :class => "fa fa-check") + ' Completed'
                end
            when 2
                content_tag :span, :class => "label label-danger" do
                    content_tag(:i, '', :class => "fa fa-times") + ' Cancelled'
                end
        end
    end
end
