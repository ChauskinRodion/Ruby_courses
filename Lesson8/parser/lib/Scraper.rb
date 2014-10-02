class Scraper

APARTMENTS_LIST_URL = "http://www.hata.by/search/~s_what=flat~s_do=sale~ckod=5000000000~ctype=ckod~scena_to=%d~currency=840~rooms=1~metro_station=217,216,215,101,102,103,104,105,106,107,108,109,110,111,201,202,203,204,205,206,207,208,209,210,211,212,213,214~uslovie=10~search_type=big/page/%d/"
  
@@agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }

  def self.scrape_apartments (params)
    apartments = []
    page_number = 1
    new_flats =  {}
    loop do
      
      page_link = APARTMENTS_LIST_URL % [params.max_price,page_number];
      @@agent.get(page_link) do |page|
        puts "Process page #{page_number}..."
          new_flats = apartments_from_one_page(page)
          apartments += new_flats      
          page_number +=1          
      end
      break if new_flats.nil? || new_flats.empty? || page_number > 10
    end    
    apartments
  end


private


  def self.apartments_from_one_page (page)
    links = page.parser.css(".showcase-title").map {|x| x.children.first.attributes["href"].value}
    apartments = []
      links.each do |link|
        @@agent.get(link) do |apartment_info_page|
            apartments << get_apartment_info(apartment_info_page)
            apartments.last[:Link] = link
        end
      end
    apartments
  end

  def self.get_apartment_info (page)
    apartment = {}
        apartment["Price"] = page.parser.css(".card-info .price").children.to_s
      page.parser.css(".card-params tr").each do |parameter|
        column = parameter.children.first.children.to_s
        value  = parameter.children.last.children.to_s
        apartment[column] = value
      end
    apartment
  end

end