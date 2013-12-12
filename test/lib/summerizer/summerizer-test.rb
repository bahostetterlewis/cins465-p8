require 'summerizer'
require 'set'
require 'rake/testtask'
require 'minitest/autorun'


$url = "http://en.wikipedia.org/wiki/Automatic_summarization#Unsupervised_keyphrase_extraction:_TextRank"


def set_url_from_pair str, pos
    if pos == nil
        return
    end

    key = str[0...pos]
    if key == "url"
        $url = str[pos+1...-1]
    end
end

def collect_command_line_arguments
    ARGV.each do|a|
        pos_colon = a.index(":");
        pos_equal = a.index("=");

        if pos_colon != nil
            set_url_from_pair a, pos_colon
        elsif pos_equal != nil
            set_url_from_pair a, pos_equal
        end
    end
end


class SimpleTest < Minitest::Unit::TestCase
    def test_ok
        # collect_command_line_arguments 
        # whould be nice to be able to pass
        # arguments from the rake file through 
        # the TestTask into this specific test..

        summary, old_length = Summerizer.get_summary $url

        puts  '-' * 50
        puts summary
        puts  '-' * 50
        puts "Old Length: " + old_length.to_s
        puts "New Length: " + summary.length.to_s
    end
end