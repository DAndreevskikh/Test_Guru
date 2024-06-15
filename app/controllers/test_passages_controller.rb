class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result]

  rescue_from NoMethodError, with: :rescue_with_no_method_error

  def show; end

  def result
    @awarded_badge = BadgeIssuanceService.new(@test_passage).call if @test_passage.success?
  end
  
  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.timed_out? || @test_passage.completed?
      if @test_passage.success?
        @awarded_badge = BadgeIssuanceService.new(@test_passage).call
        TestsMailer.completed_test(@test_passage).deliver_now
      end
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def rescue_with_no_method_error
    render plain: t('.no_answer')
  end
end
