import scrapy


class AmazonBotSpider(scrapy.Spider):
    name = 'amazon-bot'
    allowed_domains = ['amazon.ca']
    start_urls = ['https://www.amazon.ca/best-sellers-books-Amazon/zgbs/books/ref=zg_bs_unv_books_1_933484_1']

    def parse(self, response):
        cateogry_links = response.xpath("//*[@id='zg-left-col']/div/div/div[2]/div[2]/div/a/@href")
        for href in cateogry_links:
            cateogry_link = 'https://www.amazon.ca' +href.extract()
            print(cateogry_link)
            if cateogry_link:
                yield scrapy.Request(cateogry_link,callback= self.parse2)
 
        pass


    def parse2(self, response):
        product_category = response.css('h1::text') .extract_first().replace('Best Sellers in ','')
        cateogry_links2 =  response.xpath("//*[@id='zg-left-col']/div/div/div[2]/div[2]/div[2]/div/a/@href")
        for href in cateogry_links2:
            cateogry_link2 = 'https://www.amazon.ca' + href.extract()
            print(cateogry_link2)
            if cateogry_link2:
                yield scrapy.Request(cateogry_link2,callback= self.parse_category, meta={
                    'product_category': product_category
                })
 
        pass


    def parse_category(self,response):
        product_category = response.meta['product_category']
        product_category2 = response.css('h1::text') .extract_first().replace('Best Sellers in ','')
        ranks1 = response.xpath("//*[@class='zg-bdg-text']/text()").extract()
        rank_urls1 = response.xpath('//*[@class="zg-grid-general-faceout"]/div/a[1]/@href').extract()
        next_page =  response.xpath("//*[@class='a-last']/a/@href").extract_first() 
        next_page_url =  response.urljoin('https://www.amazon.ca' +next_page)

       ## print(product_category2,ranks1, rank_urls1, next_page_url)
        if next_page:
            yield scrapy.Request(next_page_url,callback= self.parse_category2, meta={
                'product_category': product_category,
                'product_subcategory': product_category2,
                'rank1': ranks1,
                'url1': rank_urls1
            })


        pass

    def parse_category2(self,response):
        ranks2 = response.xpath("//*[@class='zg-bdg-text']/text()").extract()
        rank_urls2 = response.xpath('//*[@class="zg-grid-general-faceout"]/div/a[1]/@href').extract()
        rank1_to100 =response.meta['rank1'] + ranks2
        urls1_to100 =response.meta['url1'] + rank_urls2


        for i in range(len(rank1_to100)):
            print(rank1_to100[i],urls1_to100[i])
            ## full_product_url = response.urljoin('https://www.amazon.ca' +urls1_to100[i])
            yield {#  scrapy.Request(full_product_url,callback=self.parse_book, meta={
                'product_category': response.meta['product_category'],
                'product_subcategory': response.meta['product_subcategory'],
                'rank': rank1_to100[i]
            }
            ## })
        pass







## response.xpath("//*[@class='zg-bdg-text']").extract()
## response.xpath("//*[@class='a-last']/a/@href").extract()
## scrapy crawl amazon-bot
##   type and date :  response.css('#productSubtitle::text').extract_first()
## number of ratings  :  response.css('#acrCustomerReviewText::text').extract_first()
###   auhtoro name :  response.xpath('//*[@id="bylineInfo"]/span/span[1]/a[1]/text()')





## response.xpath('//*[@id="tmmSwatches"]/ul/li/span/span/span/span/span')

## response.xpath('//*[@id="tmmSwatches"]/ul/li/span/span/span/a/span/span/text()').extract()



## response.xpath('//*[@id="detailBullets_feature_div"]/ul/li/span/span[2]/text()')[0]