require "./sub_lexer.rb"
require "./sub_runer.rb"
class Pinenut
	def initialize(code)
		@code = code
		@chomp = @code.split(" ")
		@token = []
	end
	def run
		@token = Lexer.new(@chomp).run
		Runer.new(@token).run(0,@token.size)
	end
end

Pinenut.new(ARGF.read).run
