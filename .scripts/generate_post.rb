#!/usr/bin/env ruby

require 'fileutils'

VERSION = "0.1.0"

puts "Jekyll Post Generator v#{VERSION}."

# Function to remove special characters and replace spaces with '-' character
def strip_format(str)
  str.downcase.split(' ').each {|word| word.gsub!(/[^0-9A-Za-z]/, '')}.join('-')
end

time      = Time.now
date      = time.strftime('%Y-%m-%d')
date_time = time.strftime('%Y-%m-%d %H:%M:%S %z')

print "Post Headline> "; headline = gets.chomp
print "Tags> "; tags = gets.chomp.downcase.split(' ').join(' ')
print "Category> "; category = gets.chomp.downcase

slug = strip_format(headline)

front_matter = <<EOH
---
layout: post
title: "#{headline}"
date: #{date_time}
tags: "#{tags}"
category: "#{category}"
permalink: /#{slug}/
---

EOH

# Create a file based on the category location and front matter
FileUtils.mkdir_p("_posts/#{category}")
File.open("_posts/#{category}/#{date}-#{slug}.markdown", 'w') do |file|
  file.write(front_matter)
end
