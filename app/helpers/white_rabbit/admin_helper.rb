module WhiteRabbit
  module AdminHelper
    def month_options
      [['January', 1],
       ['February', 2],
       ['March', 3],
       ['April', 4],
       ['May', 5],
       ['June', 6],
       ['July', 7],
       ['August', 8],
       ['September', 9],
       ['October', 10],
       ['November', 11],
       ['December', 12]]
    end

    def days_of_week_options
      [['Sunday', 0], ['Monday', 1], ['Tuesday', 2], ['Wednesday', 3], ['Thursday', 4], ['Friday', 5], ['Saturday', 6]]
    end

    def days_option
      (1..31).to_a.each_with_index.map { |item, index| [item.to_s << 'th', index + 1] }
    end
  end
end
