require 'customer'
require 'account'

class Customer
    attr_reader :firstname, :lastname, :accounts
    def initialize(name)
        fullname = name.split
        @firstname = fullname.first
        @lastname = fullname.last
        @accounts = []
    end
    def addaccount(type)
        return if @accounts.any? {|a| a.type == type}
        a=Account.new(type)
        @accounts << a
    
    end
end
        