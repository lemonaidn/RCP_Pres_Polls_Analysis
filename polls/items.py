# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class PollsItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    poll = scrapy.Field()
    date = scrapy.Field()
    sample = scrapy.Field()
    moe = scrapy.Field()
    biden = scrapy.Field()
    trump = scrapy.Field()
    spread = scrapy.Field()
