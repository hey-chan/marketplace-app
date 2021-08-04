module ApplicationHelper
  def select_alert_subclass(input)
    # This method takes a string as input and a string as output
    case input
    when 'notice'
      return 'info'
    when 'success'
      return 'success'
    when 'error'
      return 'danger'
    when 'alert'
      return 'warning'
    else
      return 'info'
    end
  end
end
