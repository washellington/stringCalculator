class CalculatorsController < ApplicationController

  def index
    if calculator_params.present?
      puts "expression = #{calculator_params}"
      begin 
        @calculator = Calculator.new calculator_params
        @calculator.calculate
      rescue Exception => e
        flash.now[:error] = "The following error occured:\n#{e.to_s}"    
      end
    end
  end



  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def calculator_params
      params.fetch(:expression, {})
    end
end
