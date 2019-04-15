require 'test_helper'

class CalculatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test  "original inputs" do
    c = Calculator.new "5*3+1+6/2+9*100"
    assert 919 == ("%0.2f" % c.calculate).to_f

    c = Calculator.new "5*3+1+6/85+9*100"
    assert  916.07 == ("%0.2f" % c.calculate).to_f
  end

  test "too many operators" do 
    c = Calculator.new "5*3+1+6/85+9*100-"
    assert_raises Exception do
       c.calculate
    end

    c = Calculator.new "5*3+1+6/85+9**100"
    assert_raises Exception do
       c.calculate
    end

    c = Calculator.new "+5*3+1+6/85+9**100"
    assert_raises Exception do
       c.calculate
    end
  end

  test "invalid character" do 
    c = Calculator.new "5*3+1+6/85+9^2"
    assert_raises Exception do
       c.calculate
    end
  end

  test "can not contain whitespace" do 
    c = Calculator.new "5*3+1+6/ 85+9/2"
    assert_raises Exception do
       c.calculate
    end

    c = Calculator.new " 5*3+1+6/2+9*100"
    assert 919 == ("%0.2f" % c.calculate).to_f

    c = Calculator.new " 5*3+1+6/2+9*100 "
    assert 919 == ("%0.2f" % c.calculate).to_f
  end

  test "calculate negative integer" do 
    c = Calculator.new "2--2"
    assert 4 == ("%0.2f" % c.calculate).to_f

    c = Calculator.new "-2+2"
    assert 0 == ("%0.2f" % c.calculate).to_f

    c = Calculator.new "-2--2"
    assert 0 == ("%0.2f" % c.calculate).to_f

    c = Calculator.new "2+-2"
    assert 0 == ("%0.2f" % c.calculate).to_f

    c = Calculator.new "2+-2-"
    assert_raises Exception do
      c.calculate
    end
  end
end