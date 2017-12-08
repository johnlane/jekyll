# frozen_string_literal: true

module Jekyll
  class Publisher
    def initialize(site)
      @site = site
    end

    def publish?(thing)
      can_be_published?(thing) && !hidden_in_the_future?(thing)
    end

    def hidden_in_the_future?(thing)
      thing.respond_to?(:date) && !@site.future && thing.date.to_i > @site.time.to_i
    end

    private

    def can_be_published?(thing)
      (thing.data.fetch("published", true) || @site.unpublished) && (

        (@site.with_categories.to_a.empty? ||
         ! (thing.data.fetch("categories",[]) & @site.with_categories).empty? ) &&

        (@site.without_categories.to_a.empty? ||
           (thing.data.fetch("categories",[]) & @site.without_categories).empty? ) &&

        (@site.with_tags.to_a.empty? ||
         ! (thing.data.fetch("tags",[]) & @site.without_tags).empty? ) &&

        (@site.without_tags.to_a.empty? ||
           (thing.data.fetch("tags",[]) & @site.without_tags).empty? ) )
    end
  end
end
