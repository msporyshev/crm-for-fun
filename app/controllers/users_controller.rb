class UsersController < ApplicationController
  skip_before_filter :redirect_to_sign_in_page_if_not_signed_in, :only => [:new, :create]
  skip_before_filter :redirect_to_root_with_correct_subdomain_if_subdomain_is_invalid, :only => [:new, :create]
  before_filter :redirect_to_root_if_user_has_no_access

  # GET /users
  # GET /users.json
  def index
    @users = User.where(:subdomain => crm_subdomain).
      paginate(page: params[:page], per_page: PAGE_COUNT)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.role = crm_subdomain.blank? ? "admin" : "user"

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  protected

  def redirect_to_root_if_user_has_no_access
    redirect_to root_url if current_user.id != params[:id].to_i and current_user.role != "admin"
  end
end
