require 'transaction'

describe Transaction do
    describe '#initialize' do
        it 'should create a deposit transaction for $10' do
            t = Transaction.new(:deposit, 10)
            expect(t.type).to eql(:deposit)
            expect(t.amount).to eql(10)
            expect(t.date).to be < Time.now
        end
    end
end