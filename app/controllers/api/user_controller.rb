class Api::UserController < ApplicationController
       def index
        @temp = Hash.new
        @users = User.find_by(email: params[:email])
        @temp = {:fullname => "#{@users.fname} #{@users.lname}",:age => "#{@users.age}"}
        render json: @temp
       end
       def create
        @user=User.create(user_params)
         if@user.save
           render json:@user
         else
           render json: {error:"unable to create"}, status: 400
         end
       end
       def update
        @user=User.find(params[:id])
         if@user
          @user.update(user_params)
           render json: {message: "updated"}, status:200
         else
           render json: {message: "unable to update"}, status:400
         end
       end
       def destroy
        @user.find(params[:id])
         if@user.destroy
           render json: {message: "user deleted"}, status:200
         else
           render json: {error: "delete failed"}
         end
       end
       private
       def user_params
         params.permit(:fname, :lname, :email, :age)
       end
end
