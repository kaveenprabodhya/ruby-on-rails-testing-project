class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            # puts "session=> #{session[:user_id]}"
            flash[:success] = 'You have successfully logged in.'
            redirect_to user_path(@user)
        else
            flash[:danger] = 'Invalid email or password!'
            redirect_to signin_path
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path
        flash[:success] = 'You have successfully logged out.'
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
      end
end