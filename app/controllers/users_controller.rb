class UsersController < ApplicationController




  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index" })
  end
  
  def show
   
    

    if current_user && user_signed_in?
      the_id = params.fetch("path_id")

      matching_users = User.where({ :Username => the_id })
  
      @the_user = matching_users.at(0)

    render({ :template => "users/show" })
    else
      redirect_to("/users/sign_in")
    end

  end

  def create
    the_user = User.new
    the_user.fan_id = params.fetch("query_fan_id")
    the_user.photo_id = params.fetch("query_photo_id")

    if the_user.valid?
      the_user.save
      redirect_to("/users", { :notice => "user created successfully." })
    else
      redirect_to("/users", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.fan_id = params.fetch("query_fan_id")
    the_user.photo_id = params.fetch("query_photo_id")

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "user updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "user deleted successfully."} )
  end
end
