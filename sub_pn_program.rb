require 'time'
src = {"time"=>Time.now.to_i.to_s}
dst = {"time"=>Time.now.to_i.to_s}
while true
	line = STDIN.gets
	data = []
	# 処理できるかどうかを判定。これ以外は、まだできない。
		if line =~ /([0-9]+\.[0-9]+\s[A-Za-z0-9]+\s[\w\.-]+\.[\w\.-]+\s>\s[\w\.-]+\.[\w\.-]+)/
		# 処理
		line = $1.split(" ")
		data[0] = line[0].to_i.to_s
		data[1] = "OK"
		data[2] = line[1]
		ip = line[2].split(".")
		data[3] = ip[ip.size-1]
		ip.delete_at(ip.size-1)
		data[4] = ip.join(".")
		ip = line[4].split(".")
		data[5] = ip[ip.size-1]
		ip.delete_at(ip.size-1)
		data[6] = ip.join(".")
		# p data
		File.open("data_list_var.txt","w") do |f|
			f.puts(data)
		end
	else
	end
end

# require 'time'
# STDOUT.sync = true
# src = {}
# dst = {}
# while true do
# 	line = STDIN.gets
# 	data = []
# 	# (0-9)が一個以上・"."・(0-9)が一個以上
# 	# 63298463284.5324234や52342.46242や1.1が含まれる
# 	#1509443929.374623 IP tg-in-f189.1e100.net.https > 192.168.10.26.50906: Flags [.], ack 391, win 295, options [nop,nop,TS val 3875233738 ecr 585822888], length 0
# 	#(\d+\.\d+\sIP\s
# 	if line =~ /([0-9]+\.[0-9]+\s[A-Za-z0-9]+\s[\w\.-]+\.[\w\.-]+\s>\s[\w\.-]+\.[\w\.-]+)/

# 		line = $1.split(" ")
# 		data[0] = "OK"
# 		data[1] = line[0].to_i.to_s
# 		data[2] = line[1]
# 		ip = line[2].split(".")
# 		data[3] = ip[ip.size-1]
# 		ip.delete_at(ip.size-1)
# 		data[4] = ip.join(".")
# 		ip = line[4].split(".")
# 		data[5] = ip[ip.size-1]
# 		ip.delete_at(ip.size-1)
# 		data[6] = ip.join(".")
# 		File.open("data_list_var.txt","w") do |f|
# 			f.puts(@date)
# 		end
# 	end
# end
