require 'open-uri'
require 'nokogiri'

module Summerizer
  def Summerizer.split_into_sentences content
    #content = content.gsub("\n", '.')
    return content.split('.').map { |sentence| sentence.strip }
  end

  def Summerizer.split_into_paragraphs content
  return content.split("\n\n")
  end

  def Summerizer.normalized_intersection_score list1, list2

  set1 = Set.new list1.split
    set2 = Set.new list2.split
    intersection = set1 & set2
    if intersection.length == 0
      return 0
    end
    normalizer = (list1.length.to_f + list2.length.to_f) / 2
    return intersection.length.to_f / normalizer
  end

  def Summerizer.build_sentences_graph content
  sentences = split_into_sentences content
    weights = Array.new(sentences.length) { Array.new(sentences.length) { 0 } }
    scores = {}
    (0...sentences.length).each { |i|
      (0...sentences.length).each { |j|
        if i == j
          weights[i][j] = 0
        else
          weights[i][j] = normalized_intersection_score sentences[i], sentences[j]
        end
      }
    }

    sentences.zip(weights).each { |sentence, current_weights|
      scores[sentence] = current_weights.reduce(:+)
    }

    return scores
  end

  def Summerizer.paragraph_maximizer content, scores
  paragraphs = split_into_paragraphs content
    key_sentences = []
    paragraphs.each { |paragraph|
      sentences = split_into_sentences paragraph
      if sentences.length < 3
        next
      end
      max = nil
      sentences.each { |sentence|
        sentence = sentence.strip()
        if sentence != nil and not sentence.empty? and scores[sentence] != nil
          max = sentence.strip()
          break
        end
      }
      if scores[max] == nil
        next
      end
      sentences.each { |sentence|
        if not sentence == nil and not sentence.empty? and scores[sentence] != nil and scores[sentence] > scores[max]
          max = sentence
        end
      }
      if not key_sentences.include? max and max.split.length > 3
        key_sentences << max
      end
    }
    return key_sentences
  end

  def Summerizer.get_summary url
    text = Nokogiri::HTML(open url)
    paras = []
    text.xpath('//p').each do |node|
      paras << node.text
    end
    text = paras.join("\n\n")
    scores = build_sentences_graph text
    key_sentences = paragraph_maximizer text, scores
    key_sentences = key_sentences.join("\n")

    return key_sentences, text.length
  end
end
