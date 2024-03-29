---
layout: post
title: "Jekyll Post Generator"
date: 2023-10-12 09:08:30 -1000
tags: "jekyll generator ruby"
category: "dev"
permalink: /jekyll-post-generator/
---

As easy as Jekyll is to use, typing out the `front-mattter` each time can be frustrating.  It can also be error prone.
So I would like to share a little Ruby generator for you!

(This post was actually generated by this tool!)

```ruby
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
```

I have this file located in the root directory of my Jekyll project as `.scripts/generate_post.rb`.
Hope this helps you write faster posts!

### Caveats
You'll notice that I am using 1 category.  This is just my preference for layouts.
You can easily modify this script to use multiple categories.