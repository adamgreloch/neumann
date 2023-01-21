module GameCopiesHelper
  def describe_condition(condition)
    case condition
    when 0
      "Barely exists"
    when 1
      "Really bad"
    when 2
      "War-torn"
    when 3
      "Medium"
    when 4
      "Nicely kept"
    when 5
      "Well preserved"
    when 6
      "Nearly mint"
    when 7
      "Played approximately once"
    when 8
      "Untouched"
    else
      "Unknown"
    end
  end
end
