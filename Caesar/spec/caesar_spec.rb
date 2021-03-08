require './Caesar_Cipher'

describe Caesar do
    describe "#caesar_cipher" do
        it "Shifts a normal string 1 place" do
            c = Caesar.new
            expect(c.caesar_cipher("hello", 1)).to eql("ifmmp")
        end

        it "Shifts a normal string with a capital 1 place" do
            c = Caesar.new
            expect(c.caesar_cipher("Hello", 1)).to eql("Ifmmp")
        end

        it "Shifts a string 0 places" do
            c = Caesar.new
            expect(c.caesar_cipher("Hello", 0)).to eql("Hello")
        end

        it "Shifts a normal string 5 places" do
            c = Caesar.new
            expect(c.caesar_cipher("Hello", 5)).to eql("Mjqqt")
        end

        it "Shifts a normal string -5 places" do
            c = Caesar.new
            expect(c.caesar_cipher("Hello", -5)).to eql("Czggj")
        end

        it "Shifts a string with special characters 5 places" do
            c = Caesar.new
            expect(c.caesar_cipher("?? _Hello!", 5)).to eql("?? _Mjqqt!")
        end
    end
  end