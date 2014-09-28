# -*- coding: utf-8 -*-

require 'set'

class Game
  LIMIT = 3
  OVER = 6

  def prepare
    @enemy = Set.new []
    @user = Set.new []
    @flag = 0
    while @enemy.length < LIMIT do
      @enemy.add(rand(9)+1)
    end
    puts "{{{{{初期化完了}}}}}","{{{{{ゲームを開始します}}}}}"
  end

  def input
    while @user.length < LIMIT do
      puts "数字を入力してください{1~9} 重複はなし"
      number = gets.to_i
      if number == 0
        puts "0が入力されたのでもう一度入力してください"
        number = gets.to_i
      end
      @user.add(number)
      p @user
    end
    judge()  
  end

  def judge
    #   eatcounter = 0 #数字、位が合っている
    bitecounter = 0 #数字のみあっている
    if @enemy.subset?(@user) == true
      puts "{{{{{{一致！!}}}}}}"
      return 3
    else
      bitecounter = ((@enemy ^ @user).size).to_i
      if bitecounter == 6
        bitecounter = 0
      elsif bitecounter == 4
        bitecounter = 1
      elsif bitecounter == 2
        bitecounter = 2
      end
      #     eatcounter = ((@enemy ^ @user).size).to_i
      printf("BITE =>%d\n",bitecounter)
      return 1
    end
  end

  def clear
    @user.clear
  end

  def gameover
    @flag = 1
  end

  def gameresult
    if @flag == 0
      puts "{{{{{{ゲームクリア}}}}}}"
    else
      puts "{{{{{{{{ゲームオーバー}}}}}}}}"
      print "今回の正解は  =>   "
      p @enemy
    end
  end
end

endcount = 0
result = 0
main = Game.new()
main.prepare
while result != 3 do
  result = main.input()
  if result == 1
    puts("雑魚め!!!!")
    endcount +=  1
    if endcount > 6
      main.gameover
      break
    end
    main.clear
  end
end
main.gameresult

  # >> {{{{{初期化完了}}}}}
  # >> {{{{{ゲームを開始します}}}}}
  # >> 数字を入力してください{1~9} 重複はなし
