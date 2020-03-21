class TestsController < ApplicationController
  def index
    @tests = Test.all
    @test = Test.new
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
