# Player Game
# TEST https://repl.it/Muh6/4

require 'pry'


class Board
  attr_accessor :cases, :rowCount, :colCount

  def initialize (rowCount, colCount)
    casesTotal = rowCount * colCount

    @cases = Array.new(casesTotal, "X")
    @rowCount = rowCount
    @colCount = colCount
  end

  def getCase(row, col)
    @cases[getIndexFromRowAndCol(row, col)]
  end

  def getIndexFromRowAndCol (row, col)
    row * colCount + col
  end

  def printCase(row, col)
    caseValue = getCase(row, col)
    print "|#{caseValue}|"
  end

  def to_s
    row = 0
    col = 0

    while row < @colCount

      while col < @rowCount
        printCase(row, col)
        col += 1
      end

      puts ""
      col = 0
      row += 1
    end

    puts "\n\n"
  end
end

class Game

  attr_accessor :players, :playersCount, :board

  def initialize (playersCount, rowCount, colCount)
    @players = []
    @playersCount = playersCount
    @board = Board.new(rowCount, colCount)

    printWelcomeMessage
    initPlayers
    startGame
  end

  def startGame
    puts "Let's start this...\n\n"

    gameLoop

    puts @board
  end

  def gameLoop
    @board.cases = [
      "O", "X", "O",
      "X", "O", "O",
      "X", "O", "X",
      ];
      while !gameIsFinished
      end
    end

    def gameIsFinished
      if (isVerticalVictory || isHorizontalVictory || isDiagonalVictory || isDraw)
        true
      else
        false
      end
    end
    
    def isDiagonalVictory
        win = true
        startingPoints = [
            [0, 0, 1, 1],
            [@board.rowCount - 1, 0, -1, 1]
        ]
        
        startingPoints.each { |startingPoint|
            row = startingPoint[0]
            col = startingPoint[1]
            directionRow = startingPoint[2]
            directionCol = startingPoint[3]
            matchingSymbol = @board.getCase(row, col)
            
            while row < @board.rowCount && col < @board.rowCount && row > 0 && col> 0
                symbol = @board.getCase(row, col)
                
                puts "must match #{matching}"
                
                if (symbol == " " || symbol != symbolToMatch)
                    win = false
                    break ;
                end
                
                row += directionRow
                col += directionCol
            end
        }
        
        puts "diagonal #{win}"
        win
    end

    def isDraw
        draw = true
   
        @board.cases.each { |boardCase|
            if (boardCase == " ")
                draw = false
            end
        }
        
        puts "draw #{draw}"
        draw
    end

    def isHorizontalVictory
      row = 0
      col = 0
      win = false
      symbol = " "

      while row < @board.rowCount && win == false

        symbolToMatch = @board.getCase(row, col)

        while col < @board.colCount && win == false

          symbol = @board.getCase(row, col)

          if (symbol == " " || symbol != symbolToMatch)
            break ;
          end

          col+= 1

          if (col == @board.rowCount)
            win = true
          end


        end
          col = 0
          row+= 1
      end

      puts "horizontal #{win}"
      win
    end

    def isVerticalVictory
      row = 0
      col = 0
      win = false
      symbol = " "

      while col < @board.colCount && win == false

        symbolToMatch = @board.getCase(row, col)

        while row < @board.rowCount && win == false

          symbol = @board.getCase(row, col)

          if (symbol == " " || symbol != symbolToMatch)
            break ;
          end

          row += 1

          if (row == @board.rowCount)
            win = true
          end


        end
          row = 0
          col += 1
      end

        puts "vertical #{win}"
      win
    end

    def initPlayers ()
      i = 0
      symbols = ["X", "O", "$", "#"]

      while i < @playersCount
        playerSymbol = symbols[i]

        puts "Player #{playerSymbol}, what's your name ?"

        playerName = gets.chomp

        puts "Hello #{playerName} ! Nice to see you.\n\n"
        @players.push(Player.new(playerName, playerSymbol))

        i += 1
      end
    end

    def printWelcomeMessage
      puts "Welcome to my Awesome Tic Tac Toe !\n\n"
    end
  end

  class Player

    attr_accessor :name, :symbol

    def initialize (name, symbol)
      @name = name
      @symbol = symbol
    end

  end

  binding.pry

# Entry Point
Game.new(2, 3, 3)