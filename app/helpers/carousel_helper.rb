module CarouselHelper
  def carousel_for(images, id)
    Carousel.new(self, images, id).html
  end

  class Carousel
    def initialize(view, images, id)
      @view, @images = view, images
      @uid = "l-"+id.to_s
    end

    def html
      options = {
        id: uid,
        class: 'carousel slide',
        data: { 
          ride: 'carousel', 
        }
      }
      content = safe_join([indicators, slides, controls])
      content_tag(:div, content, options)
    end

    private

    attr_accessor :view, :images, :uid
    delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

    def indicators
      items = images.count.times.map { |index| indicator_tag(index) }
      content_tag(:ol, safe_join(items), class: 'carousel-indicators')
    end

    def indicator_tag(index)
      options = {
        class: (index.zero? ? 'active' : ''),
        data: { 
          target: "#"+uid, 
          slide_to: index
        }
      }

      content_tag(:li, '', options)
    end

    def slides
      items = images.map.with_index { |image, index| slide_tag(image, index.zero?) }
      content_tag(:div, safe_join(items), class: 'carousel-inner')
    end

    def slide_tag(image, is_active)
      options = {
        class: (is_active ? 'carousel-item active' : 'carousel-item'),
      }

      content_tag(:div, image_tag(image, class: "d-block w-100"), options)
    end

    def controls
      safe_join([control_tag('prev'), control_tag('next')])
    end

    def control_tag(direction)
      a_options = {
        class: "carousel-control-#{direction}",
        href: "#"+uid,
        role: "button",
        data: { slide: direction
              }
      }

      icon_options = {
        class: "carousel-control-#{direction}-icon",
        aria: {
          hidden: "true"
        }
      }
    
      icon = content_tag(:span, '', icon_options) + content_tag(:span, direction, class: "sr-only")
      control = content_tag(:a, icon, a_options)
    end
  end
end