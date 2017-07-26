require 'customer'
describe Customer do
    describe '#initialize' do
        it 'should create customer and associate to a new checking account with zero balance' do
            c = Customer.new('sara john')
            expect(c.firstname).to eql('sara')
            expect(c.lastname).to eql('john')
            c.addaccount(:checking)
            b = c.accounts.first
            expect(b.balance).to eql(0)
        end
    end
end

