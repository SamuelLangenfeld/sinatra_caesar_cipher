require 'sinatra'
require 'sinatra/reloader' if development?



string=""
shift=0 


get "/" do
	erb :index, :locals => {:shifted_message => nil}
end


post "/" do
	puts params["shift"].to_i
	shifted_message=caesar_cipher(params["string"], params["shift"].to_i)
	erb :index, :locals=>{:string=>string, :shift=>shift, :shifted_message=>shifted_message}
end



def caesar_cipher(initial_string,number)

#I create two arrays to check the characters of the message against: one for uppercase, one for lower
	alphabet = ('a'..'z').to_a
	upper_alphabet = ('A'..'Z').to_a


	shifted_string=""
	number=number%26

	puts initial_string
	
#This is a loop that looks at each character before comparing them to the lowercase alphabet array
#If it finds a match, it will add on to the new shifted message. If it doesn't find the match there
#the loop looks in the uppercase alphabet. If there's no match anywhere we can assume the character
#is not a letter and simply append it to the shifted message in order to keep punctuation.

	initial_string.each_char do |i|


		if alphabet.include? i
			new_index=number+alphabet.index(i)
			new_index=new_index%26
			shifted_string+=alphabet[new_index]

		elsif upper_alphabet.include? i
			new_index=number+upper_alphabet.index(i)
			new_index=new_index%26
			shifted_string+=upper_alphabet[new_index]

		else
			shifted_string+=i

		end


	end


	shifted_string

end

