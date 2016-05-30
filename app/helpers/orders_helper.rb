module OrdersHelper
    
    def display_order_status status
        case status
            when "pending"
                content_tag :span, :class => "label label-warning" do
                    content_tag(:i, '', :class => "fa fa-clock-o") + " #{status.titleize}"
                end
            when "delivering"
                content_tag :span, :class => "label label-info" do
                    content_tag(:i, '', :class => "fa fa-motorcycle") + " #{status.titleize}"
                end
            when "completed"
                content_tag :span, :class => "label label-success" do
                    content_tag(:i, '', :class => "fa fa-check") + " #{status.titleize}"
                end
            when "cancelled"
                content_tag :span, :class => "label label-danger" do
                    content_tag(:i, '', :class => "fa fa-times") + " #{status.titleize}"
                end
        end
    end
end
