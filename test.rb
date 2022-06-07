require 'open-uri'
require 'nokogiri'

def scrapping(name)
  url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{name}"
  html = URI.open(url).read
  doc = Nokogiri::HTML(html)
  html_doc = doc.search(".MRTN__sc-1gofnyi-2")
  @recipes = []
  3.times do |index|
    @recipes << { name: html_doc[index].search(".MRTN__sc-30rwkm-0").text, note: html_doc[index].search(".SHRD__sc-10plygc-0").text, link:  "https://www.marmiton.org/#{html_doc[0].attribute('href').value}"}
  end
end
