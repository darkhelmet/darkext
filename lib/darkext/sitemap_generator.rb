require 'nokogiri'
require 'open-uri'
require 'builder'
require 'darkext/hash'

class SitemapBuilder
  FORUM_CLASS_DEFAULT = 'forumtitle'
  TOPIC_CLASS_DEFAULT = 'topictitle'
  FORUM_PRIORITY_DEFAULT = 0.8
  TOPIC_PRIORITY_DEFAULT = 0.5
  PAGE_PRIORITY_DEFAULT = 0.1
  FORUM_CHANGE_FREQ_DEFAULT = 'daily'
  TOPIC_CHANGE_FREQ_DEFAULT = 'hourly'
  PAGE_CHANGE_FREQ_DEFAULT = 'monthly'

  def initialize(opts={})
    defaults = {
      :forum => {
        :class => FORUM_CLASS_DEFAULT,
        :priority => FORUM_PRIORITY_DEFAULT,
        :change_freq => FORUM_CHANGE_FREQ_DEFAULT
      },
      :topic => {
        :class => TOPIC_CLASS_DEFAULT,
        :priority => TOPIC_PRIORITY_DEFAULT,
        :change_freq => TOPIC_CHANGE_FREQ_DEFAULT
      },
      :page => {
        :priority => PAGE_PRIORITY_DEFAULT,
        :change_freq => PAGE_CHANGE_FREQ_DEFAULT
      }
    }
    defaults.deep_merge!(opts)

    @options = defaults

    @forums = Array.new
    @topics = Array.new
    @pages = Array.new
  end

  def index(url, target = $stdout)
    @pages << url

    root = Nokogiri::HTML(open(url))
    root.search("a.#{@options.nested_find(:forum,:class)}").each do |link|
      index_forum(link.attributes['href'].to_s)
    end

    xml = Builder::XmlMarkup.new(:target => $stdout, :indent => 1)
    xml.instruct!
    xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
      @pages.each do |page|
        xml.url do
          xml.loc(page)
          xml.changefreq(@options.nested_find(:page,:change_freq))
          xml.priority(@options.nested_find(:page,:priority))
        end
      end
      @forums.each do |forum|
        xml.url do
          xml.loc(forum)
          xml.changefreq(@options.nested_find(:forum,:change_freq))
          xml.priority(@options.nested_find(:forum,:priority))
        end
      end
      @topics.each do |topic|
        xml.url do
          xml.loc(topic)
          xml.changefreq(@options.nested_find(:topic,:change_freq))
          xml.priority(@options.nested_find(:topic,:priority))
        end
      end
    end

    private
    def index_forum(href)
      root = Nokogiri::HTML(open(href))
      root.search("a.#{@options.nested_find(:forum,:class)}").each do |link|
        index_forum(link.attributes['href'].to_s)
      end
      root.search("a.#{@options.nested_find(:forum,:topic)}").each do |link|
        @topics << link.attributes['href'].to_s
      end
      @forums << href
    end
  end
end
