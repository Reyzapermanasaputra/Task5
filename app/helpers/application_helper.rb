module ApplicationHelper
def flash_class(type)
    case type.to_sym
      when :notice then "alert alert-success"
      when :info then "alert alert-info"
      when :alert then "alert alert-danger"
      when :warning then "alert alert-warning"
      when :error then "alert alert-danger"
    end
  end
end
