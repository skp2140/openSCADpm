class PackagesController < ApplicationController
  before_action :logged_in_user, only: [:edit]
  def index
    @packages = Package.paginate(page: params[:page])
  end

  def show
    @package = Package.find(params[:id])
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params) 
    if @package.save
      flash[:success] = "Package was successfully added!"
      redirect_to @package
    else
      render 'new'
    end
  end

  def edit
    @package = Packages.find(params[:id])
  end

  private

    def package_params
      params.require(:package).permit(:name, :link, :package_info)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end

