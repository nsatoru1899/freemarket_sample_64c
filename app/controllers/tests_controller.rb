class TestsController < ApplicationController
  def index
    @items = Item.where('buyer_id IS NULL').order("id DESC").limit(3)
  end

  def create
    @test = Test.create(test_params)
    redirect_to root_path
  end

  private

  def test_params
    params.require(:test).permit(:body, :image)
  end

end
