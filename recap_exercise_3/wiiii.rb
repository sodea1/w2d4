def no_dupes?(arr)
    uniqs = []
    dups = []

    (0...arr.length).each do |i|
        if !arr[i+1..-1].include?(arr[i]) && !dups.include?(arr[i])
            uniqs << arr[i]
        else
            dups << arr[i]
        end
    end
    
    uniqs
end

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    (0...arr.length - 1).none? { |i| arr[i] == arr[i + 1] }
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    h = Hash.new() { |h, k| h[k] = [] }
    str.each_char.with_index { |c, i| h[c] << i }
    h
end

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)

    cons = []
    sub = str[0]

    (0...str.length).each do |i|
        if sub[-1] == str[i + 1]
            sub += str[i + 1]
        else
            cons << sub 
            sub = str[i + 1]
        end
    end

    cons.max_by(&:length)

    # their_solution:

    # current_streak = ''
    # best_streak = ''

    # (0...str.length).each do |idx|
    #     if str[idx] == str[idx - 1] || idx == 0
    #         current_streak += str[idx]
    #     else
    #         current_streak = str[idx]
    #     end

    #     best_streak = current_streak if current_streak.length >= best_streak.length
    # end

    # best_streak

    # longest = [str[0]]
    # contender = []
    
    # (1...str.length).each do |i|
    #     if longest.last == str[i]
    #         longest << str[i]
    #     else
    #         contender << str[i]
    #         longest = contender if contender.length >= longest.length
    #     end
end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def bi_prime?(n)
    (2...n).any? { |div| n % div == 0 && prime?(div) && prime?(n / div) }
end

def prime?(n)
    return false if n < 2

    (2...n).each do |fact|
        return false if n % fact == 0
    end

    true
end

# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false
# require "byebug"
def vigenere_cipher(word, keys) # zebra [3, 0, 1]
    alpha = ("a".."z").to_a
    ciphered = ""

    i = 0
    # byebug
    word.each_char.with_index do |c, i|
        key = keys.first
        cur_i = alpha.index(c)
        new_i = cur_i + key
        ciphered += alpha[new_i % 26]
        keys = keys.rotate
    end

    ciphered
end

# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    rotated = ""
    vowels = "aeiou"
    vows = []
    str.each_char { |char| vows << char if vowels.include?(char) }

    count = 0
    str.each_char do |c|
        if vowels.include?(c) && count == 0
            rotated += vows[-1]
            count += 1
        elsif vowels.include?(c)
            rotated += vows[count - 1]
            count += 1
        else
            rotated += c
        end
    end

    rotated

    # new_str = str[0..-1]
    # vowels = 'aeiou'

    # vowel_idxs = (0...str.length).select { |i| vowels.include?(str[i]) }
    # rotated_vowel_idxs = vowel_idxs.rotate(-1)

    # vowel_idxs.each_with_index do |vowel_idx, i|
    #     new_vowel = str[rotated_vowel_idxs[i]]
    #     new_str[vowel_idx] = new_vowel
    # end

    # new_str
end

# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

class String

    def select(&prc)
        new_string = ""
        return new_string if prc.nil?
        self.each_char { |c| new_string += c if prc.call(c) }
        new_string
    end

    def map!(&prc)
        self.each_char.with_index do |c, i|
            self[i] = prc.call(c, i)
        end
        self
    end
end

# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

def multiply(a, b) # a * 5
    return a if b == 1
    if b > 0
        a + multiply(a, b - 1)
    else
        -a - multiply(a, b.abs - 1)
    end
end

# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(n)
    return [] if n == 0
    return [2] if n == 1
    return [2, 1] if n == 2

    next_num = lucas_sequence(n - 1).last + lucas_sequence(n - 2).last
    lucas_sequence(n - 1) << next_num
end

# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]


def prime_factorization(num) # 12
    return [num] if prime?(num)

    div = 0
    first = 0

    (2...num).each do |n| # 2
        if num % n == 0
            first = n
            div = num / n # 3
            break
        end
    end

    prime_factorization(first) + prime_factorization(div)

end

p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]