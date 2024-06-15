class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_next_question, on: :update

  SUCCESS_THRESHOLD = 85

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def success_rate
    (correct_questions.to_f / test.questions.count) * 100
  end

  def success?
    success_rate >= SUCCESS_THRESHOLD
  end

  def current_question_number
    test.questions.order(:id).index(current_question) + 1
  end

  def total_questions_count
    test.questions.count
  end

  def time_left
    return if test.timer.zero?

    (created_at + test.timer.minutes - Time.current).to_i
  end

  def timed_out?
    time_left <= 0
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if current_question.nil?
  end

  def before_validation_set_next_question
    self.current_question = next_question unless current_question.nil?
  end

  def correct_answer?(answer_ids)
    return false unless answer_ids
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
