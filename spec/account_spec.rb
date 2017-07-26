require 'account'
describe Account do
    describe '#initialize' do
        it 'should create a checking account with zero balance and no transactions' do
            a=Account.new(:checking)
            expect(a.type).to eql(:checking)
            expect(a.balance).to eql(0)
            expect(a.transactions.size).to eql(0)
        end
        
    end
    describe '#deposit' do
        it 'should add $75 to a new savings account' do
            a=Account.new(:saving)
            a.deposit(75)
            expect(a.balance).to eql(75)
            expect(a.transactions.size).to eql(1)
            t = a.transactions.first
            expect(t.type).to eql(:deposit)
            expect(t.amount).to eql(75)
        end
    end
    
    describe '#withdraw' do
        it 'should withdraw when funds are available' do
            a=Account.new(:checking)
            a.deposit(100)
            a.withdraw(25)
            expect(a.balance).to eql(75)
            expect(a.transactions.size).to eql (2)
            t1 = a.transactions[0]
            t2 = a.transactions[1]
            expect(t1.type).to eql(:deposit)
            expect(t1.amount).to eql(100)
            expect(t2.type).to eql(:withdraw)
            expect(t2.amount).to eql(25)
        end
        it 'should not withdraw when funds are insufficient' do
            a = Account.new(:checking)
            a.deposit(20)
            a.withdraw(25)
            expect(a.balance).to eql(-30)
            expect(a.transactions.size).to eql(2)
        end
    end
    describe '#filter_transactions' do
        it 'show all transactions' do
            a = Account.new(:saving)
            a.deposit(75)
            a.deposit(75)
            a.withdraw(25)
            trx = a.filter_transactions
            expect(trx.size).to eql(3)       
        end
        it 'show deposit transactions' do
            a = Account.new(:saving)
            a.deposit(75)
            a.deposit(75)
            a.withdraw(25)
            trx = a.filter_transactions(:deposit)
            expect(trx.size).to eql(2)       
        end
    end
    describe '#stats' do
        it 'find the mean value, medium, and standard deviation' do
            a = Account.new(:checking)
            a.deposit(75)
            a.deposit(105)
            a.deposit(33)
            a.deposit(215)
            a.deposit(68)
            stats = a.stats(:deposit)
            expect(stats[:mean]).to be_within(0.1).of(99.2)
            expect(stats[:median]).to be_within(0.1).of(33.0)
            expect(stats[:stdev]).to be_within(0.1).of(69.6)
        end
    end
end