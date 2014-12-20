class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
  end

  def create
  end

  def new
    @provider = Provider.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end
end
