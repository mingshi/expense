module ExpenseHelper
    require 'date'
    def generate_date(s)
        date = DateTime.parse(s)
        return date.strftime("%Y-%m-%d")
    end

    def generate_time(s)
        date = DateTime.parse(s)
        return date.strftime("%H:%M")
    end
end
