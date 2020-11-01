from scrapy import Spider, Request
from polls.items import PollsItem

class BudgetSpider(Spider):
    name = 'polls_spider'
    start_urls = ['https://www.realclearpolitics.com/epolls/2020/president/us/general_election_trump_vs_biden-6247.html']
    allowed_urls = ['https://www.realclearpolitics.com']

    def parse(self, response):
        #rows = response.xpath('//*[@id="polling-data-full"]/table//tr').extract()
        rows = response.xpath('//*[@id="polling-data-full"]/table//tr')

        for row in rows[1:]:
            poll = row.xpath('./td[1]//text()').extract_first()
            date = row.xpath('./td[2]//text()').extract_first()
            sample = row.xpath('./td[3]//text()').extract_first()
            moe = row.xpath('./td[4]//text()').extract_first()
            biden = row.xpath('./td[5]//text()').extract_first()
            trump = row.xpath('./td[6]//text()').extract_first()
            spread = row.xpath('./td[7]//text()').extract_first()

            item = PollsItem()
            item['poll'] = poll
            item['date'] = date
            item['sample'] = sample
            item['moe'] = moe
            item['biden'] = biden
            item['trump'] = trump
            item['spread'] = spread

            yield item