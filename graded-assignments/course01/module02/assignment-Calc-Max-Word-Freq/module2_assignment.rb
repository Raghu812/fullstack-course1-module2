#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)

  attr_reader :highest_wf_count
	attr_reader :highest_wf_words
	attr_reader :content
	attr_reader :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
    def initialize(content,line_number)
  	@content=content.to_s
  	@line_number=line_number.to_i
  	@highest_wf_words=Array.new
  	calculate_word_frequency()
  	end
  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def calculate_word_frequency()

		rep=Hash.new(0)
		tmp=content.split
		tmp.each{|word| word.downcase!}
		tmp.each{|word| rep[word]+=1}
		maxi=0
		rep.each{|key,value| maxi=value if value>maxi }
		@highest_wf_count=maxi
		rep.each{|key,value| @highest_wf_words.push(key.to_s) if value.to_i==@highest_wf_count}
	end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
end

#  Implement a class called Solution.
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers
	attr_reader :highest_count_across_lines
	attr_reader :highest_count_words_across_lines
  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in
  #  highest_count_words_across_lines in the specified format
  def initialize()
  	@analyzers=Array.new();
  	end
    def analyze_file()
  		begin
  		i=1
  		File.foreach('.\test.txt') do |line|

  		@analyzers<<LineAnalyzer.new(line.chomp,i)
  		i+=1
  		end

  		rescue Exception =>e
  		  puts e.message
  		  puts "File not found!!"

  		end
  	end
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines
  #* Create an array of LineAnalyzers for each line in the file
  def calculate_line_with_highest_frequency()
@highest_count_words_across_lines=Array.new()
		maxi=0
		@analyzers.each do |x|
		maxi=x.highest_wf_count if x.highest_wf_count>maxi
		end
		@highest_count_across_lines=maxi


		@analyzers.each do |x|
		@highest_count_words_across_lines<<x if x.highest_wf_count==@highest_count_across_lines
		end


	end

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def print_highest_word_frequency_across_lines()
	  puts "The following words have the highest word frequency per line:"
	  @highest_count_words_across_lines.each do |x|
			puts "#{x.highest_wf_words.inspect} (appears in line #{x.line_number})"


	end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
end
end
