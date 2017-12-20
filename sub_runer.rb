class Runer
	def initialize(token)
		@token = token
		@var = {}
		@i=0
		srand(Time.now.to_i)
	end
	def run(s,f)
		@i=s
		while true
			case @token[@i][0]
			when "PRINT"
				@i+=1
				puts getVar(@token[@i][1])
			when "ARRAY"
				@i+=1
				if @token[@i][0] == "EQUAL"
					@i+=1
					@var[@token[@i][1-2].split("]")[0].delete("[")][@token[@i-2][1].split("]")[1]] = getVar(@token[@i[1]])
				end
			when "VAR"
				@i+=1
				if @token[@i][0] == "EQUAL"
					@i+=1
					@var[@token[@i-2][1]] = getVar(@token[@i][1])
				end
			when "IF"
				start = @i+2
				i = @i+2
				wi = 1
				while wi != 0
					if @token[i][0] == "END_IF"
						wi-=1
					elsif @token[i][0] == "IF"
						wi+=1
					end
					i+=1
				end
				finish = i+1
				if getVar(@token[@i+1][1])=="true"
					run(start,finish)
				end
				@i = f+1
			when "WHILE"
				# 今のi	   i=>WHILE  i+1=>COND   i+2=s>コード   i+??=f=>最後のコード
				start = @i+2
				i=@i+2
				wi=1
				while wi != 0
					if @token[i][0] == "END_WHILE"
						wi-=1
					elsif @token[i][0] == "WHILE"
						wi+=1
					end
					i+=1
				end
				finish = i-1
				save_i = @i
				while getVar(@token[@i+1][1])=="true"
					run(start,finish)
					@i = save_i
				end
				@i=f+1
			when "PN_S"
				sleep 3
				`sudo echo \"\"`
				Thread.new do
					`sudo tcpdump -f -tt | ruby sub_pn_program.rb`
				end
			end
			@i+=1
			if @token[@i] == nil || @i-1 == f
				break
			end
		end
	end

	def evalCond(c)
		l = c.split(/(==|!=|<|>)/)[0]
		ope = c.split(/(==|!=|<|>)/)[1]
		r = c.split(/(==|!=|<|>)/)[2]
		if ope == "=="
			s = (getVar(l) == getVar(r))
		elsif ope == "!="
			s = (getVar(l) != getVar(r))
		elsif ope == "<"
			s = (getVar(l) < getVar(r))
		elsif ope == ">"
			s = (getVar(l) > getVar(r))
		end
		if s
			return "true"
		else
			return "false"
		end
	end

	def getValue(exp)
		if exp =~ /(\+|-)/
			exp = exp.split(/(\+|-)/)
		else
			exp = [exp]
		end

		if exp[0] == ""
			exp.delete_at(0)
		end

		i=0
		type="start"
		acc=0
		while i != exp.size
			if exp[i] == "+" && type != "opr"
				type = "opr"
			elsif exp[i] == "-" && type != "opr"
				type = "opr"
			elsif exp[i] =~ /\d+/ && type != "value" && type != "var"
				type = "value"
			elsif exp[i] =~ /\w+/ && type != "var" && type != "value"
				type = "var"
				exp[i] = getVar(exp[i])
			else
			end
			i+=1
		end

		if exp[0] != "+" && exp[0] != "-"
			exp.unshift("+")
		end

		i=0
		while i != exp.size
			if exp[i] == "+"
				i+=1
				acc += exp[i].to_i
			elsif exp[i] == "-"
				i+=1
				acc -= exp[i].to_i
			end
			i+=1
		end
		return acc
	end
	def getVar(c)
		case c
		when /"(.+)"/
			return $1
		when "true"
			return c
		when "false"
			return c
		when /\w==\w/
			return evalCond(c)

		when /\w!=\w/
			return evalCond(c)

		when /\w<\w/
			return evalCond(c)

		when /\w>\w/
			return evalCond(c)
		when /(\w(\+|-))+\w/
			return getValue(c)
		when /(\w+)\[(\d+)\]/
			return eval(@var[$1])[$2.to_i].to_s
		when /\[(.+,)*.+\]/
			return eval(c).to_s
		when /\d+/
			return c.to_i			
		when /pn_new/
			sleep 5
			File.foreach('data_list_var.txt') do |l|
				return eval(l.chomp)
			end
		when /random\((\d+)\)/
			return rand($1.to_i)
		when /\w+/
			return @var[c]
		end
	end
end
