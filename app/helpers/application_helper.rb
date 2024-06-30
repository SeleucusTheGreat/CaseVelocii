module ApplicationHelper
    
   
        def sort_link(title, column)
          direction = (params[:sort] == column && params[:direction] == "asc") ? "desc" : "asc"
          icon = params[:sort] == column ? (direction == "asc" ? "▲" : "▼") : ""
          link_to admin_dashboard_path(sort: column, direction: direction), class: 'sort-link' do
            raw("#{title} <span class='sort-icon'>#{icon}</span>")
          end
        end
      
end
