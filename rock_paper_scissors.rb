# rules:
#   Rock smashes Scissors
#   Scissors cuts Paper
#   Paper covers Rock

class Users
  attr_accessor :name, :scores, :options

  def initialize name
    @name = name
    @scores = { :wins => 0, :loses => 0, :ties => 0 }
    @options = ["rock", "paper", "scissors"]
  end

  def play
    loop do
      puts "#{self.name}'s choice:"
      input = gets.chomp.downcase

      # validate the input
      if options.include?(input)
        return input.to_sym
      else
        puts "The choice is invalid. Available choices are: #{options}.\n Please re-enter the choice."
      end
    end
  end

end

class RockPaperScissors
  attr_accessor :winners, :losers

  def initialize
    @winners = [[:scissors, :papers], [:paper, :rock], [:rock, :scissors]]
    @losers = @winners.map{ |x| x.reverse }
  end


  def play
    # Create new users before playing
    user_1 = collect_user_info
    user_2 = collect_user_info

    loop do
      puts "\n### New game between #{user_1.name} and #{user_2.name} ###"

      choice_by_1 = user_1.play
      choice_by_2 = user_2.play

      inputs = [choice_by_1, choice_by_2]

      out = compare(inputs)

      case out
        when :win
          puts "\n#{user_1.name} won!"
          user_1.scores[:wins] += 1
          user_2.scores[:loses] += 1
        when :lose
          puts "\n#{user_2.name} won!"
          user_2.scores[:wins] += 1
          user_1.scores[:loses] += 1
        else
          puts "\nYou tied."
          user_1.scores[:ties] += 1
          user_2.scores[:ties] += 1
      end

      puts "Would you like to play again? [Y/n]"
      answer = gets.chomp.downcase
      break if answer == "n"
    end
    puts "Game stats for #{user_1.name}: #{user_1.scores}"
    puts "Game stats for #{user_2.name}: #{user_2.scores}"
  end

  private

  def collect_user_info
    puts "Enter your name:"
    input = gets.chomp.downcase
    Users.new(input)
  end

  def compare inputs
    return :win if winners.include?(inputs)
    return :lose if losers.include?(inputs)
    :tie
  end
end

RockPaperScissors.new.play
