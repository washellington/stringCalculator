class Calculator

  attr_accessor :expression, :result

  ORDER_OPERATIONS = [
    ['*', '/'], ['+', '-']
  ]

  OPERATIONS = {
    '*': lambda{|x,y| x * y},
    '/': lambda{|x,y| x / y},
    '-': lambda{|x,y| x - y},
    '+': lambda{|x,y| x + y} 
  }

  def initialize(expression)
    @expression = expression.strip
    @operands = []
    @operators = []
    @result = 0
    puts "OPERATIONS = ", OPERATIONS.inspect
  end
  def validations
    base_msg = "The expression '#{@expression}'"

    raise "#{base_msg} contains white space charaters" if @expression.strip.scan(/\s+/).present?

    raise "#{base_msg} contains invalid characters" if @expression !~ /-?\d+[.]\d+|-?\d+|\+|-|\*|\//
    #check if right number of operands and operators
    raise "#{base_msg} does not have the right number of operands and operators" if @operands.length != (@operators.length + 1)
    #check operator must me surrounded by operands
    raise "#{base_msg} has misplaced operators"  if @expression.scan(/(?:(?:-?\d+[.]\d+|-?\d+)(?:\+|-|\*|\/))+(?:-?\d+[.]\d+|-?\d+){1}/).first != @expression
  end

  def parse_expression
    @operands = @expression.scan(/(?<!\d)-?\d+[.]\d+|(?<!\d)-?\d+/).map(&:to_f) 
    @operators = @expression.scan(/\+|(?<=\d)-(?=-?\d)|\*|\//)
    puts "Operands = ", @operands.inspect
    puts "Operators = ", @operators.inspect
    validations
  end

  def calculate
    parse_expression
    num_list = @operands
    opp_list = @operators
    begin 
      #gets index of operation
      index = opp_list.index{|x| ORDER_OPERATIONS[0].include?(x)}
      index = opp_list.index{|x| ORDER_OPERATIONS[1].include?(x)} unless index.present?

      puts "operation = #{opp_list[index]}"
      puts "performing: #{num_list[index]} #{opp_list[index]} #{num_list[index + 1]}"
      result  = OPERATIONS[opp_list[index].to_sym].call(num_list[index], num_list[index + 1])
      puts "result = #{result}"

      opp_list.delete_at index
      num_list.insert (index + 2), result
      num_list.delete_if.with_index{|x, i| i == index || i == index + 1}
      puts "new number list = #{num_list.inspect}"
      puts "new operations list = #{opp_list.inspect}"

    end while num_list.length > 1 
    @result = num_list[0]
  end
end
