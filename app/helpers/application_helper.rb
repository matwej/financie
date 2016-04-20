module ApplicationHelper

  def euro_currency(value)
    number_to_currency(value, precision: 2, :unit => "€", :separator => ",", :delimiter => "\u00a0", :format => "%n\u00a0%u")
  end

end
