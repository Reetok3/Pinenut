# print "aiueo"
# => aiueo
# print 123
# => 123
# print 123.456
# => 123.456 
# print nil 
# => nil # print true # => 0 # print false # => 1 # print 123,456  =>123456
# print "aiueo",123
# => aiueo123

class Lexer
	def initialize(chomp)
		@chomp = chomp
		@token = []
	end
	def run
		i=0
		while true
			case @chomp[i]
			when "print"         		#print
				@token.push(["PRINT","print"])
			when "pn_start"
				@token.push(["PN_S",@chomp[i]])
			when "pn_new"
				@token.push(["PN_N",@chomp[i]])
			when /random\(\d+\)/
				@token.push(["RANDOM",$1.to_i])
			when  /\w+\[\d+\]/
				@token.push(["ARRAY",@chomp[i]])
			when /".+"/          		#文字列
				@token.push(["STRING",@chomp[i]])
			when "true"
				@token.push(["TRUTH",@chomp[i]])
			when "false"
				@token.push(["TRUTH",@chomp[i]])
			when /\w+==\w+/
				@token.push(["COND",@chomp[i]])
			when /\w+!=\w+/
				@token.push(["COND",@chomp[i]])
			when /\w+<\w+/
				@token.push(["COND",@chomp[i]])
			when /\w+>\w+/
				@token.push(["COND",@chomp[i]])
			when /(\w(\+|-))+\w/
				@token.push(["EXP",@chomp[i]])
			when "="
				@token.push(["EQUAL","="])
			when /\d+/
				@token.push(["INTEGER",@chomp[i]])
			when "while"
				@token.push(["WHILE","while"])
			when "endwhile"
				@token.push(["END_WHILE","endwhile"])
			when "if"
				@token.push(["IF","if"])
			when "endif"
				@token.push(["END_WHIlE","endif"])
			when nil
				break
			when ""
			when "\n"
			else
				if @chomp[i] =~ /\w+/ #変数
					@token.push(["VAR",@chomp[i]])
				else         		#エラー
					error("LEXERエラー,#{i}個目,#{@chomp[i]}")
				end
			end
			i+=1
		end
	return @token
	end
	def error(char)
		puts char+"\n"
	end
end
