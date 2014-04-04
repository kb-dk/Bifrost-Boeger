#Extending the default Blacklight CatalogHelper and adding some extra functionality
module CatalogHelper
  #Don't remove this, when we over-ride Blacklights CatalogHelper we need to include all its behaviour manually
  # otherwise the default Blacklight behaviour goes missing
  include Blacklight::CatalogHelperBehavior

  #Function to create a REX search link for the digital book using the Aleph SYS num
  # @param [String] sys_num
  # @return [String] URL for REX book search
  def create_rex_physical_book_search_link(sys_num)
    REX_CONFIG['rex_book_search_template_uri'].gsub('SYS_NUM', "KGL01#{sys_num.to_sentence.html_safe}")
  end

  # given a hash of search_fields, render a ul with search fields
  # as list elements within links
  def render_search_dropdown(search_fields)
    content_tag(:ul, class: 'dropdown-menu', id: 'js_search_type') do
      search_fields.each do |key, value|
        concat(content_tag(:li,  content_tag(:a, key, {href: '#'}), {id: value}))
      end
    end
  end

  def render_bifrost_header

    title = @document['title_tesim'].to_sentence.html_safe if @document['title_tesim']
    titleExtended = @document['titleExtended_tesim'].to_sentence.html_safe if @document['titleExtended_tesim']
    subtitle = @document['subtitle_tesim'].to_sentence.html_safe if @document['subtitle_tesim']

    if title and titleExtended and subtitle
      content_tag(:h1, title) + content_tag(:h2, titleExtended) + content_tag(:h3, subtitle)
    elsif title and titleExtended
      content_tag(:h1, title) + content_tag(:h2, titleExtended)
    elsif title and subtitle
      content_tag(:h1, title) + content_tag(:h3, subtitle)
    elsif titleExtended and subtitle
      content_tag(:h1, titleExtended) + content_tag(:h3, subtitle)
    elsif title
      content_tag(:h1, title)
    elsif titleExtended
      content_tag(:h2, titleExtended)
    elsif subtitle
      content_tag(:h3, subtitle)
    end

  end

  ##
  # Render the index field label for a document
  #
  # KB rewrite of render_index_field_label
  # handle translations better
  #
  # @overload render_index_field_label(options)
  #   Use the default, document-agnostic configuration
  #   @param [Hash] opts
  #   @options opts [String] :field
  # @overload render_index_field_label(document, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [Hash] opts
  #   @options opts [String] :field
  def render_bifrost_index_field_label *args
    options = args.extract_options!
    document = args.first

    field = options[:field]
    html_escape t(index_fields(document)[field].label, default: t('kb.search.index.label'))
  end

  ##
  # Render the show field label for a document
  #
  # @overload render_document_show_field_label(options)
  #   Use the default, document-agnostic configuration
  #   @param [Hash] opts
  #   @options opts [String] :field
  # @overload render_document_show_field_label(document, options)
  #   Allow an extention point where information in the document
  #   may drive the value of the field
  #   @param [SolrDocument] doc
  #   @param [Hash] opts
  #   @options opts [String] :field
  def render_bifrost_show_field_label *args
    options = args.extract_options!
    document = args.first

    field = options[:field]

    html_escape t(document_show_fields(document)[field].label, default: t('kb.search.index.label'))
  end
end