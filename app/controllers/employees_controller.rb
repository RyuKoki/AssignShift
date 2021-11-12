class EmployeesController < ApplicationController

	def show
		@time = Time.current
		day = Time.current.strftime("%Y-%m-%d")
		@date = day.to_time

		id_user = current_user.id
		user = User.find_by_id(id_user)
		plan = Plan.find_by(:date => @date, :user_id => id_user)

		check_actual = Actual.find_by(:date => @date, :user_id => id_user)

		if ( params.key?("save_in") )
			if ( check_actual == nil )
				user_actual = Actual.create(:date => @date, :time_in => @time)
				plan.actuals << user_actual
				user.actuals << user_actual
			else
				check_actual.update(:time_in => @time)
			end
			flash[:notice] = "Check in was successfully."
			redirect_to schedule_path
		end

		if ( params.key?("save_out") )
			if ( check_actual == nil )
				user_actual = Actual.create(:time_out => @time)
				plan.actuals << user_actual
				user.actuals << user_actual
			else 
				check_actual.update(:time_out => @time)
			end
			flash[:notice] = "Check out was successfully."
			redirect_to schedule_path
		end
	end
end
