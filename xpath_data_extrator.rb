#!/usr/bin/env ruby

# Title: Ruby Modules for Email Parsing Application
# URL: http://jobs.rubynow.com/jobs/show/4401
# Posted:	2010-07-31
# Company name:	Social Commerce Startup
# Contact Info:	irisnt@gmail.com
# Travel:	0%
# Onsite:	No
# Description:	
#   We are developing an application in Ruby that parses incoming email messages from a known list of senders in a known list of formats/sending templates. We need strong Ruby coders to write modules for our application to support specific templates of HTML email. We will supply you with a template of HTML, and your job is to write a script using Ruby and scrubyt to 1) parse the HTML and extract specific information; 2) access Web services to query for additional data, using the data extracted from the email, and return all of this data as a string of XML.
#   We have a large number of these templates for which we need scripts written. If interested, please reply to this email with a summary of your specific experience with Ruby, and any experience you have in Xpath or using tools like scrubyt. If selected, we will reply with sample code of one of our existing modules, and we will hire you to create a single module for a specific HTML template. After this, if your work is satisfactory, we will give you additional work.
# Required Skills: Ruby, Xpath or tools like scrubyt.
# Employment terms:	Contractor(hourly)
# Hours: Flexible

$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'mechanize'

@@http = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

html_doc = @@http.get( 'http://jobs.rubynow.com/jobs/show/4401' )

fetched_data = {}

def get_col_data_hash(doc, label, key)
  if doc.to_s.scan(Regexp.new(label)).length > 0
    label, data = doc.search('td')
    data_hash = { key.to_sym => data.to_s.gsub(/\<[^>]+\>/, '').strip }
  end
  data_hash
end

html_doc.root.xpath('//table/tr').each do |tr| 
  if email = get_col_data_hash(tr, 'Contact Info', 'email')
    fetched_data = fetched_data.merge(email)
  end

  if company_name = get_col_data_hash(tr, 'Company name', 'company_name')
    fetched_data = fetched_data.merge(company_name)
  end
end

puts fetched_data.to_xml