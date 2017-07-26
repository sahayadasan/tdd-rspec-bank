require 'transaction'

class Account
    attr_reader :type, :balance, :transactions
#    TYPES = [:checking, :saving]
    def initialize(type)
#        raise :bad_type unless TYPES.include?(type)
        @type = type
        @balance = 0
        @transactions = []
    end
    def deposit(amount)
        @balance = @balance + amount
        t = Transaction.new(:deposit, amount)
        @transactions << t
    end
    def withdraw(amount)
        if amount <= @balance
           @balance -= amount
            t = Transaction.new(:withdraw, amount)
        else
            @balance -= 50
            t = Transaction.new(:fee, 50)
        end
            
        @transactions << t
    end
    def filter_transactions(type=nil)
        type ? @transactions.select{|t|t.type ==type} : @transactions
    end
    def stats(type)
        transactions = self.filter_transactions(type)
        amountlist = transactions.map{|t| t.amount}
        mean = amountlist.sum / amountlist.size.to_f
        
        n = amountlist.size
        amountlist.sort
        if n.odd?
            idx = (n/2).floor
            median = amountlist[idx]
        else
            idx = (n / 2) - 1
            values = amountlist[idx, 2]
            median = values.sum / 2.0
        end
        
        sum_sq_diff = amountlist.map {|x| (x - mean) ** 2}.sum
        stdev = (sum_sq_diff / (n - 1)) ** 0.5
    
        {mean: mean, median: median, stdev: stdev}
    end        
end
        