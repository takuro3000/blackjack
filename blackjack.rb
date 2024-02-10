puts "ブラックジャックへようこそ"
puts "ゲームを開始します"
suits = ['ハート', 'ダイヤ', 'スペード', 'クラブ']
ranks = ['A','2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', ]
deck = []

suits.each do |suit|
  ranks.each do |rank|
    deck << "#{suit}の#{rank}"
  end
end

default_trump = deck.sample(30)
divided_default_trump=default_trump.each_slice(15).to_a
player_trump=divided_default_trump[0]
dealer_trump=divided_default_trump[1]
player_default_trump = [player_trump[0],player_trump[1]]
dealer_default_trump = [dealer_trump[0],dealer_trump[1]]
puts "あなたの引いたカードは#{player_default_trump[0]}です"
puts "あなたの引いたカードは#{player_default_trump[1]}です"
puts "ディーラーの引いたカードは#{dealer_default_trump[0]}です"
puts "ディーラーの2枚目のカードはわかりません"

default_score = []
default_trump.each do | youso |
    if youso.slice(-1)== "K" || youso.slice(-1)== "Q" || youso.slice(-1)== "J" || youso.slice(-1)== "0" 
        default_score << 10
    elsif youso.slice(-1)=="A"
        default_score << 1
    else
        default_score << youso.slice(-1).to_i
    end 
end

divided_default_score = default_score.each_slice(15).to_a
player_score = divided_default_score[0]
dealer_score = divided_default_score[1]

player_default_score = player_score[0] + player_score[1]

puts "あなたの現在の得点は#{player_default_score}です。"

player_sum_score=0
player_display_score=[]
player_score.each do | score |
  player_sum_score+=score
  player_display_score << score
  break if player_sum_score >= 22
end

player_display_added_score = player_display_score.drop(2)

player_sum_trump_card = player_display_score.length
player_display_trump = player_trump.take(player_sum_trump_card) 
player_display_default_trump = player_display_trump.take(2)
player_display_added_trump = player_display_trump.drop(2)

player_display_sum_score = player_default_score
player_display_added_score.zip(player_display_added_trump).each do | score , card |
    puts "カードを引きますか？引く場合はYを、引かない場合はNを入力してください"
    player_choice=gets.chomp
    if player_choice == "N"
        break
    elsif player_choice == "Y"
        player_display_sum_score += score
        puts "あなたの引いたカードは#{card}です。"
        puts "あなたの現在の得点は#{player_display_sum_score}です。"
    end
end


puts "ディーラーの2枚目のカードは#{dealer_default_trump[1]}でした。"

dealer_default_score = dealer_score[0] + dealer_score[1]

puts "ディーラーの現在の得点は#{dealer_default_score}です。"

dealer_sum_score=0
dealer_display_score = []

dealer_score.each do | score |
  dealer_sum_score += score
  dealer_display_score << score
  break if dealer_sum_score >= 17
end

dealer_sum_trump_card = dealer_display_score.length
dealer_display_trump = dealer_trump.take(dealer_sum_trump_card) 
dealer_display_default_trump = dealer_display_trump.take(2)
dealer_display_added_trump = dealer_display_trump.drop(2)

dealer_display_added_trump.each do | trump |
  puts "ディーラーの引いたカードは#{trump}です。"
end

puts "あなたの得点は#{player_display_sum_score}です。"
puts "ディーラーの得点は#{dealer_sum_score}です。"

player_gap_score = 22 - player_display_sum_score
dealer_gap_score = 22 - dealer_sum_score

if player_display_sum_score >= 22 && dealer_sum_score >= 22
    puts "引き分けです"
elsif player_display_sum_score == dealer_sum_score
    puts "引き分けです"
elsif player_display_sum_score <= 21 && dealer_sum_score >= 22
    puts "あなたの勝ちです"
elsif player_display_sum_score >= 22 && dealer_sum_score <= 21
    puts "ディーラーの勝ちです"
elsif player_gap_score < dealer_gap_score
    puts "あなたの勝ちです"
elsif player_gap_score > dealer_gap_score
    puts "ディーラーの勝ちです"
end