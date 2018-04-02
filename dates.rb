first = Date.new(2018,1,1)
last = Date.new(2018,3,31)
checked_days = [1,3,5]

def all_days(first_date, last_date, checked_days)
  number_of_days = (last_date - first_date + 1).to_i
  days = []

  number_of_days.times do |i|
    if (first_date + i).wday.in?(checked_days)
      days << first_date + i
    end
  end
  p days
end
