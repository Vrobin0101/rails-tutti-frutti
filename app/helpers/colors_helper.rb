module ColorsHelper
  def color(score)
    color = ""
    if score < 20
      color = "#FC755D"
    elsif score >= 20 && score < 40
      color = "#FDB3A5"
    elsif score >= 40 && score < 60
      color = "#FDCB44"
    elsif score >= 60 && score < 80
      color = "#90DBD0"
    elsif score <= 100
      color = "#0B8790"
    end
    return color
  end
end
