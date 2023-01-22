module UserOpinionsHelper
  def describe_compliance(level)
    case level
    when 0
      "Total anarchy"
    when 1
      "Problematic rental, game copies in bad condition"
    when 2
      "Efficient rental, game copies in bad condition"
    when 3
      "Efficient rental, but copy condition worse than described"
    when 4
      "Efficient rental, copy condition as described"
    when 5
      "Efficient rental, condition better than expected"
    when 6
      "Rental police"
    else
      "Unknown"
    end
  end

  def describe_contact(level)
    case level
    when 0
      "Unpleasant contact"
    when 1
      "High doubts this user exists"
    when 2
      "Scarce contact, had troubles with game exchange"
    when 3
      "Efficient contact"
    when 4
      "Wonderful to talk to, highly engaged in contact"
    else
      "Unknown"
    end
  end
end
