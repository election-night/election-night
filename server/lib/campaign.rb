require 'active_record'

class Campaign < ActiveRecord::Base

  has_and_belongs_to_many :candidates

  def pick_winner
    candidate1 = candidates[0]
    candidate2 = candidates[1]
    candidate1_points = 0
    candidate2_points = 0

    if candidate1.intelligence > candidate2.intelligence
      candidate1_points += 1
    elsif candidate1.intelligence < candidate2.intelligence
      candidate2_points += 1
    else
    end

    if candidate1.charisma > candidate2.charisma
      candidate1_points += 1
    elsif candidate1.charisma < candidate2.charisma
      candidate2_points += 1
    else
    end

    if candidate1.willpower > candidate2.willpower
      candidate1_points += 1
    elsif candidate1.willpower < candidate2.willpower
      candidate2_points += 1
    else
    end

    if candidate1_points > candidate2_points
      self.winner_id = candidate1.id
      save
    elsif candidate1_points < candidate2_points
      self.winner_id = candidate2.id
      save
    else
      save
    end

  end

end
